/*
Title: T2Ti ERP Fenix                                                                
Description: ListaPage relacionada à tabela [VENDEDOR_ROTA] 
                                                                                
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
import 'vendedor_rota_persiste_page.dart';

class VendedorRotaListaPage extends StatefulWidget {
  @override
  _VendedorRotaListaPageState createState() => _VendedorRotaListaPageState();
}

class _VendedorRotaListaPageState extends State<VendedorRotaListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<VendedorRotaViewModel>(context).listaVendedorRota == null && Provider.of<VendedorRotaViewModel>(context).objetoJsonErro == null) {
      Provider.of<VendedorRotaViewModel>(context).consultarLista();
    }
    var listaVendedorRota = Provider.of<VendedorRotaViewModel>(context).listaVendedorRota;
    var colunas = VendedorRota.colunas;
    var campos = VendedorRota.campos;

    final VendedorRotaDataSource _vendedorRotaDataSource =
        VendedorRotaDataSource(listaVendedorRota, context);

    void _sort<T>(Comparable<T> getField(VendedorRota vendedorRota), int columnIndex, bool ascending) {
      _vendedorRotaDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<VendedorRotaViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Vendedor Rota'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<VendedorRotaViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Vendedor Rota'),
          actions: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) => 
					  VendedorRotaPersistePage(vendedorRota: VendedorRota(), title: 'Vendedor Rota - Inserindo', operacao: 'I')))
                  .then((_) {
                Provider.of<VendedorRotaViewModel>(context).consultarLista();
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
                          title: 'Vendedor Rota - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<VendedorRotaViewModel>(context)
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
            child: listaVendedorRota == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Vendedor Rota'),
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
									_sort<num>((VendedorRota vendedorRota) => vendedorRota.id,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Vendedor'),
								tooltip: 'Vendedor',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((VendedorRota vendedorRota) => vendedorRota.vendedor?.colaborador?.pessoa?.nome,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Cliente'),
								tooltip: 'Cliente',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((VendedorRota vendedorRota) => vendedorRota.cliente?.pessoa?.nome,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Posição Rota'),
								tooltip: 'Posição Rota',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((VendedorRota vendedorRota) => vendedorRota.posicao,
									columnIndex, ascending),
							),
                        ],
                        source: _vendedorRotaDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future _refrescarTela() async {
    await Provider.of<VendedorRotaViewModel>(context).consultarLista();
  }
}

/// codigo referente a fonte de dados
class VendedorRotaDataSource extends DataTableSource {
  final List<VendedorRota> listaVendedorRota;
  final BuildContext context;

  VendedorRotaDataSource(this.listaVendedorRota, this.context);

  void _sort<T>(Comparable<T> getField(VendedorRota vendedorRota), bool ascending) {
    listaVendedorRota.sort((VendedorRota a, VendedorRota b) {
      if (!ascending) {
        final VendedorRota c = a;
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
    if (index >= listaVendedorRota.length) return null;
    final VendedorRota vendedorRota = listaVendedorRota[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
		DataCell(Text('${vendedorRota.id ?? ''}'), onTap: () {
			detalharVendedorRota(vendedorRota, context);
		}),
		DataCell(Text('${vendedorRota.vendedor?.colaborador?.pessoa?.nome ?? ''}'), onTap: () {
			detalharVendedorRota(vendedorRota, context);
		}),
		DataCell(Text('${vendedorRota.cliente?.pessoa?.nome ?? ''}'), onTap: () {
			detalharVendedorRota(vendedorRota, context);
		}),
		DataCell(Text('${vendedorRota.posicao ?? ''}'), onTap: () {
			detalharVendedorRota(vendedorRota, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaVendedorRota.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharVendedorRota(VendedorRota vendedorRota, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/vendedorRotaDetalhe',
    arguments: vendedorRota,
  );
}