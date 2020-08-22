/*
Title: T2Ti ERP Fenix                                                                
Description: AbaMestre ListaPage relacionada à tabela [TABELA_PRECO] 
                                                                                
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
import 'tabela_preco_page.dart';

class TabelaPrecoListaPage extends StatefulWidget {
  @override
  _TabelaPrecoListaPageState createState() => _TabelaPrecoListaPageState();
}

class _TabelaPrecoListaPageState extends State<TabelaPrecoListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<TabelaPrecoViewModel>(context).listaTabelaPreco == null && Provider.of<TabelaPrecoViewModel>(context).objetoJsonErro == null) {
      Provider.of<TabelaPrecoViewModel>(context).consultarLista();
    }     
    var tabelaPrecoProvider = Provider.of<TabelaPrecoViewModel>(context);
    var listaTabelaPreco = tabelaPrecoProvider.listaTabelaPreco;
    var colunas = TabelaPreco.colunas;
    var campos = TabelaPreco.campos;

    final TabelaPrecoDataSource _tabelaPrecoDataSource =
        TabelaPrecoDataSource(listaTabelaPreco, context);

    void _sort<T>(Comparable<T> getField(TabelaPreco tabelaPreco), int columnIndex, bool ascending) {
      _tabelaPrecoDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<TabelaPrecoViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Tabela Preco'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<TabelaPrecoViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Tabela Preco'),
          actions: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                      TabelaPrecoPage(tabelaPreco: TabelaPreco(), title: 'Tabela Preco - Inserindo', operacao: 'I')))
                  .then((_) {
                Provider.of<TabelaPrecoViewModel>(context).consultarLista();
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
                          title: 'Tabela Preco - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<TabelaPrecoViewModel>(context)
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
            child: listaTabelaPreco == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Tabela Preco'),
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
									_sort<num>((TabelaPreco tabelaPreco) => tabelaPreco.id,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Nome'),
								tooltip: 'Nome',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((TabelaPreco tabelaPreco) => tabelaPreco.nome,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Principal'),
								tooltip: 'Principal',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((TabelaPreco tabelaPreco) => tabelaPreco.principal,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Coeficiente'),
								tooltip: 'Coeficiente',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((TabelaPreco tabelaPreco) => tabelaPreco.coeficiente,
									columnIndex, ascending),
							),
                        ],
                        source: _tabelaPrecoDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future _refrescarTela() async {
    await Provider.of<TabelaPrecoViewModel>(context).consultarLista();
  }
}

/// codigo referente a fonte de dados
class TabelaPrecoDataSource extends DataTableSource {
  final List<TabelaPreco> listaTabelaPreco;
  final BuildContext context;

  TabelaPrecoDataSource(this.listaTabelaPreco, this.context);

  void _sort<T>(Comparable<T> getField(TabelaPreco tabelaPreco), bool ascending) {
    listaTabelaPreco.sort((TabelaPreco a, TabelaPreco b) {
      if (!ascending) {
        final TabelaPreco c = a;
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
    if (index >= listaTabelaPreco.length) return null;
    final TabelaPreco tabelaPreco = listaTabelaPreco[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
		DataCell(Text('${tabelaPreco.id ?? ''}'), onTap: () {
			detalharTabelaPreco(tabelaPreco, context);
		}),
		DataCell(Text('${tabelaPreco.nome ?? ''}'), onTap: () {
			detalharTabelaPreco(tabelaPreco, context);
		}),
		DataCell(Text('${tabelaPreco.principal ?? ''}'), onTap: () {
			detalharTabelaPreco(tabelaPreco, context);
		}),
		DataCell(Text('${tabelaPreco.coeficiente != null ? Constantes.formatoDecimalValor.format(tabelaPreco.coeficiente) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharTabelaPreco(tabelaPreco, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaTabelaPreco.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharTabelaPreco(TabelaPreco tabelaPreco, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/tabelaPrecoDetalhe',
    arguments: tabelaPreco,
  );
}
