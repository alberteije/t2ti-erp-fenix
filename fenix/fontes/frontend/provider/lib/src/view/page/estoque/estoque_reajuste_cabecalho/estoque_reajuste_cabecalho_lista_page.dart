/*
Title: T2Ti ERP Fenix                                                                
Description: AbaMestre ListaPage relacionada à tabela [ESTOQUE_REAJUSTE_CABECALHO] 
                                                                                
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
import 'estoque_reajuste_cabecalho_page.dart';

class EstoqueReajusteCabecalhoListaPage extends StatefulWidget {
  @override
  _EstoqueReajusteCabecalhoListaPageState createState() => _EstoqueReajusteCabecalhoListaPageState();
}

class _EstoqueReajusteCabecalhoListaPageState extends State<EstoqueReajusteCabecalhoListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<EstoqueReajusteCabecalhoViewModel>(context).listaEstoqueReajusteCabecalho == null && Provider.of<EstoqueReajusteCabecalhoViewModel>(context).objetoJsonErro == null) {
      Provider.of<EstoqueReajusteCabecalhoViewModel>(context).consultarLista();
    }     
    var estoqueReajusteCabecalhoProvider = Provider.of<EstoqueReajusteCabecalhoViewModel>(context);
    var listaEstoqueReajusteCabecalho = estoqueReajusteCabecalhoProvider.listaEstoqueReajusteCabecalho;
    var colunas = EstoqueReajusteCabecalho.colunas;
    var campos = EstoqueReajusteCabecalho.campos;

    final EstoqueReajusteCabecalhoDataSource _estoqueReajusteCabecalhoDataSource =
        EstoqueReajusteCabecalhoDataSource(listaEstoqueReajusteCabecalho, context);

    void _sort<T>(Comparable<T> getField(EstoqueReajusteCabecalho estoqueReajusteCabecalho), int columnIndex, bool ascending) {
      _estoqueReajusteCabecalhoDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<EstoqueReajusteCabecalhoViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Estoque Reajuste Cabecalho'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<EstoqueReajusteCabecalhoViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Estoque Reajuste Cabecalho'),
          actions: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                      EstoqueReajusteCabecalhoPage(estoqueReajusteCabecalho: EstoqueReajusteCabecalho(), title: 'Estoque Reajuste Cabecalho - Inserindo', operacao: 'I')))
                  .then((_) {
                Provider.of<EstoqueReajusteCabecalhoViewModel>(context).consultarLista();
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
                          title: 'Estoque Reajuste Cabecalho - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<EstoqueReajusteCabecalhoViewModel>(context)
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
            child: listaEstoqueReajusteCabecalho == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Estoque Reajuste Cabecalho'),
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
                              label: const Text('Id'),
                              numeric: true,
                              onSort: (int columnIndex, bool ascending) =>
                                  _sort<num>((EstoqueReajusteCabecalho estoqueReajusteCabecalho) => estoqueReajusteCabecalho.id,
                                      columnIndex, ascending),
                            ),
							DataColumn(
								label: const Text('Colaborador'),
								tooltip: 'Colaborador',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((EstoqueReajusteCabecalho estoqueReajusteCabecalho) => estoqueReajusteCabecalho.colaborador?.pessoa?.nome,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Data do Reajuste'),
								tooltip: 'Data do Reajuste',
								onSort: (int columnIndex, bool ascending) =>
									_sort<DateTime>((EstoqueReajusteCabecalho estoqueReajusteCabecalho) => estoqueReajusteCabecalho.dataReajuste,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Taxa Reajuste'),
								tooltip: 'Taxa Reajuste',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((EstoqueReajusteCabecalho estoqueReajusteCabecalho) => estoqueReajusteCabecalho.taxa,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Tipo do Reajuste'),
								tooltip: 'Tipo do Reajuste de Pessoa',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((EstoqueReajusteCabecalho estoqueReajusteCabecalho) => estoqueReajusteCabecalho.tipoReajuste,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Justificativa'),
								tooltip: 'Justificativa',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((EstoqueReajusteCabecalho estoqueReajusteCabecalho) => estoqueReajusteCabecalho.justificativa,
									columnIndex, ascending),
							),
                        ],
                        source: _estoqueReajusteCabecalhoDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future _refrescarTela() async {
    await Provider.of<EstoqueReajusteCabecalhoViewModel>(context).consultarLista();
  }
}

/// codigo referente a fonte de dados
class EstoqueReajusteCabecalhoDataSource extends DataTableSource {
  final List<EstoqueReajusteCabecalho> listaEstoqueReajusteCabecalho;
  final BuildContext context;

  EstoqueReajusteCabecalhoDataSource(this.listaEstoqueReajusteCabecalho, this.context);

  void _sort<T>(Comparable<T> getField(EstoqueReajusteCabecalho estoqueReajusteCabecalho), bool ascending) {
    listaEstoqueReajusteCabecalho.sort((EstoqueReajusteCabecalho a, EstoqueReajusteCabecalho b) {
      if (!ascending) {
        final EstoqueReajusteCabecalho c = a;
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
    if (index >= listaEstoqueReajusteCabecalho.length) return null;
    final EstoqueReajusteCabecalho estoqueReajusteCabecalho = listaEstoqueReajusteCabecalho[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${ estoqueReajusteCabecalho.id ?? ''}'), onTap: () {
          detalharEstoqueReajusteCabecalho(estoqueReajusteCabecalho, context);
        }),
		DataCell(Text('${estoqueReajusteCabecalho.colaborador?.pessoa?.nome ?? ''}'), onTap: () {
			detalharEstoqueReajusteCabecalho(estoqueReajusteCabecalho, context);
		}),
		DataCell(Text('${estoqueReajusteCabecalho.dataReajuste != null ? DateFormat('dd/MM/yyyy').format(estoqueReajusteCabecalho.dataReajuste) : ''}'), onTap: () {
			detalharEstoqueReajusteCabecalho(estoqueReajusteCabecalho, context);
		}),
		DataCell(Text('${estoqueReajusteCabecalho.taxa != null ? Constantes.formatoDecimalTaxa.format(estoqueReajusteCabecalho.taxa) : 0.toStringAsFixed(Constantes.decimaisTaxa)}'), onTap: () {
			detalharEstoqueReajusteCabecalho(estoqueReajusteCabecalho, context);
		}),
		DataCell(Text('${estoqueReajusteCabecalho.tipoReajuste ?? ''}'), onTap: () {
			detalharEstoqueReajusteCabecalho(estoqueReajusteCabecalho, context);
		}),
		DataCell(Text('${estoqueReajusteCabecalho.justificativa ?? ''}'), onTap: () {
			detalharEstoqueReajusteCabecalho(estoqueReajusteCabecalho, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaEstoqueReajusteCabecalho.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharEstoqueReajusteCabecalho(EstoqueReajusteCabecalho estoqueReajusteCabecalho, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/estoqueReajusteCabecalhoDetalhe',
    arguments: estoqueReajusteCabecalho,
  );
}
