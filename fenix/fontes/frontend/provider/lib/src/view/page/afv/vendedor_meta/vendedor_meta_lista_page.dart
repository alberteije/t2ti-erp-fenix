/*
Title: T2Ti ERP Fenix                                                                
Description: ListaPage relacionada à tabela [VENDEDOR_META] 
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2020 T2Ti.COM                                          
                                                                                
Permission is hereby granted, free of charge, to any person                     
obtaining a copy of this software and associated documentation                  
files (the "Software"), to deal in the Software without                         
restriction, including without limitation the rights to use,                    
copy, modify, merge, publish, distribute, sublicense, and/or sell               
copies of the Software, and to permit persons to whom the                       
Software is furnished to do so, subject to the following                        
conditions:                                                                     
                                                                                
The above copyright notice and this permission notice shall be                  
included in all copies or substantial portions of the Software.                 
                                                                                
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,                 
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES                 
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND                        
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT                     
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,                    
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING                    
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR                   
OTHER DEALINGS IN THE SOFTWARE.                                                 
                                                                                
       The author may be contacted at:                                          
           t2ti.com@gmail.com                                                   
                                                                                
@author Albert Eije (alberteije@gmail.com)                    
@version 1.0.0
*******************************************************************************/
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fenix/src/model/model.dart';
import 'package:fenix/src/view_model/view_model.dart';
import 'package:fenix/src/model/filtro.dart';
import 'package:fenix/src/view/shared/erro_page.dart';
import 'package:fenix/src/view/shared/filtro_page.dart';
import 'package:fenix/src/view/shared/view_util_lib.dart';
import 'package:fenix/src/infra/constantes.dart';
import 'package:intl/intl.dart';
import 'vendedor_meta_persiste_page.dart';

class VendedorMetaListaPage extends StatefulWidget {
  @override
  _VendedorMetaListaPageState createState() => _VendedorMetaListaPageState();
}

class _VendedorMetaListaPageState extends State<VendedorMetaListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<VendedorMetaViewModel>(context).listaVendedorMeta == null && Provider.of<VendedorMetaViewModel>(context).objetoJsonErro == null) {
      Provider.of<VendedorMetaViewModel>(context).consultarLista();
    }
    var listaVendedorMeta = Provider.of<VendedorMetaViewModel>(context).listaVendedorMeta;
    var colunas = VendedorMeta.colunas;
    var campos = VendedorMeta.campos;

    final VendedorMetaDataSource _vendedorMetaDataSource =
        VendedorMetaDataSource(listaVendedorMeta, context);

    void _sort<T>(Comparable<T> getField(VendedorMeta vendedorMeta), int columnIndex, bool ascending) {
      _vendedorMetaDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<VendedorMetaViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Vendedor Meta'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<VendedorMetaViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Vendedor Meta'),
          actions: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) => 
					  VendedorMetaPersistePage(vendedorMeta: VendedorMeta(), title: 'Vendedor Meta - Inserindo', operacao: 'I')))
                  .then((_) {
                Provider.of<VendedorMetaViewModel>(context).consultarLista();
              });
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: BottomAppBar(
          color: ViewUtilLib.getBottomAppBarColor(),
          shape: CircularNotchedRectangle(),
          child: Row(
            children: <Widget>[
              IconButton(
                icon: ViewUtilLib.getIconBotaoFiltro(),
                onPressed: () async {
                  Filtro filtro = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => FiltroPage(
                          title: 'Vendedor Meta - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<VendedorMetaViewModel>(context)
                          .consultarLista(filtro: filtro);
                    }
                  }
                },
              )
            ],
          ),
        ),
        body: RefreshIndicator(
          onRefresh: _refrescarTela,
          child: Scrollbar(
            child: listaVendedorMeta == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Vendedor Meta'),
                        rowsPerPage: _rowsPerPage,
                        onRowsPerPageChanged: (int value) {
                          setState(() {
                            _rowsPerPage = value;
                          });
                        },
                        sortColumnIndex: _sortColumnIndex,
                        sortAscending: _sortAscending,
                        columns: <DataColumn>[
							DataColumn(
								numeric: true,
								label: const Text('Id'),
								tooltip: 'Id',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((VendedorMeta vendedorMeta) => vendedorMeta.id,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Vendedor'),
								tooltip: 'Vendedor',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((VendedorMeta vendedorMeta) => vendedorMeta.vendedor?.colaborador?.pessoa?.nome,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Cliente'),
								tooltip: 'Cliente',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((VendedorMeta vendedorMeta) => vendedorMeta.cliente?.pessoa?.nome,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Período'),
								tooltip: 'Período',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((VendedorMeta vendedorMeta) => vendedorMeta.periodoMeta,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Meta Orçada'),
								tooltip: 'Meta Orçada',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((VendedorMeta vendedorMeta) => vendedorMeta.metaOrcada,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Meta Realizada'),
								tooltip: 'Meta Realizada',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((VendedorMeta vendedorMeta) => vendedorMeta.metaRealizada,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Data Inicial'),
								tooltip: 'Data Inicial',
								onSort: (int columnIndex, bool ascending) =>
									_sort<DateTime>((VendedorMeta vendedorMeta) => vendedorMeta.dataInicio,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Data Final'),
								tooltip: 'Data Final',
								onSort: (int columnIndex, bool ascending) =>
									_sort<DateTime>((VendedorMeta vendedorMeta) => vendedorMeta.dataFim,
									columnIndex, ascending),
							),
                        ],
                        source: _vendedorMetaDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future _refrescarTela() async {
    await Provider.of<VendedorMetaViewModel>(context).consultarLista();
  }
}

/// codigo referente a fonte de dados
class VendedorMetaDataSource extends DataTableSource {
  final List<VendedorMeta> listaVendedorMeta;
  final BuildContext context;

  VendedorMetaDataSource(this.listaVendedorMeta, this.context);

  void _sort<T>(Comparable<T> getField(VendedorMeta vendedorMeta), bool ascending) {
    listaVendedorMeta.sort((VendedorMeta a, VendedorMeta b) {
      if (!ascending) {
        final VendedorMeta c = a;
        a = b;
        b = c;
      }
      Comparable<T> aValue = getField(a);
      Comparable<T> bValue = getField(b);

      if (aValue == null) aValue = '' as Comparable<T>;
      if (bValue == null) bValue = '' as Comparable<T>;

      return Comparable.compare(aValue, bValue);
    });
    notifyListeners();
  }

  int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= listaVendedorMeta.length) return null;
    final VendedorMeta vendedorMeta = listaVendedorMeta[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
		DataCell(Text('${vendedorMeta.id ?? ''}'), onTap: () {
			detalharVendedorMeta(vendedorMeta, context);
		}),
		DataCell(Text('${vendedorMeta.vendedor?.colaborador?.pessoa?.nome ?? ''}'), onTap: () {
			detalharVendedorMeta(vendedorMeta, context);
		}),
		DataCell(Text('${vendedorMeta.cliente?.pessoa?.nome ?? ''}'), onTap: () {
			detalharVendedorMeta(vendedorMeta, context);
		}),
		DataCell(Text('${vendedorMeta.periodoMeta ?? ''}'), onTap: () {
			detalharVendedorMeta(vendedorMeta, context);
		}),
		DataCell(Text('${vendedorMeta.metaOrcada != null ? Constantes.formatoDecimalValor.format(vendedorMeta.metaOrcada) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharVendedorMeta(vendedorMeta, context);
		}),
		DataCell(Text('${vendedorMeta.metaRealizada != null ? Constantes.formatoDecimalValor.format(vendedorMeta.metaRealizada) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharVendedorMeta(vendedorMeta, context);
		}),
		DataCell(Text('${vendedorMeta.dataInicio != null ? DateFormat('dd/MM/yyyy').format(vendedorMeta.dataInicio) : ''}'), onTap: () {
			detalharVendedorMeta(vendedorMeta, context);
		}),
		DataCell(Text('${vendedorMeta.dataFim != null ? DateFormat('dd/MM/yyyy').format(vendedorMeta.dataFim) : ''}'), onTap: () {
			detalharVendedorMeta(vendedorMeta, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaVendedorMeta.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharVendedorMeta(VendedorMeta vendedorMeta, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/vendedorMetaDetalhe',
    arguments: vendedorMeta,
  );
}