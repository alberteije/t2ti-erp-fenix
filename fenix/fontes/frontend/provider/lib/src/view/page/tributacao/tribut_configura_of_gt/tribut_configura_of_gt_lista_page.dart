/*
Title: T2Ti ERP Fenix                                                                
Description: AbaMestre ListaPage relacionada à tabela [TRIBUT_CONFIGURA_OF_GT] 
                                                                                
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
import 'tribut_configura_of_gt_page.dart';

class TributConfiguraOfGtListaPage extends StatefulWidget {
  @override
  _TributConfiguraOfGtListaPageState createState() => _TributConfiguraOfGtListaPageState();
}

class _TributConfiguraOfGtListaPageState extends State<TributConfiguraOfGtListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<TributConfiguraOfGtViewModel>(context).listaTributConfiguraOfGt == null && Provider.of<TributConfiguraOfGtViewModel>(context).objetoJsonErro == null) {
      Provider.of<TributConfiguraOfGtViewModel>(context).consultarLista();
    }     
    var tributConfiguraOfGtProvider = Provider.of<TributConfiguraOfGtViewModel>(context);
    var listaTributConfiguraOfGt = tributConfiguraOfGtProvider.listaTributConfiguraOfGt;
    var colunas = TributConfiguraOfGt.colunas;
    var campos = TributConfiguraOfGt.campos;

    final TributConfiguraOfGtDataSource _tributConfiguraOfGtDataSource =
        TributConfiguraOfGtDataSource(listaTributConfiguraOfGt, context);

    void _sort<T>(Comparable<T> getField(TributConfiguraOfGt tributConfiguraOfGt), int columnIndex, bool ascending) {
      _tributConfiguraOfGtDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<TributConfiguraOfGtViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Tribut Configura Of Gt'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<TributConfiguraOfGtViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Tribut Configura Of Gt'),
          actions: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                      TributConfiguraOfGtPage(tributConfiguraOfGt: TributConfiguraOfGt(), title: 'Tribut Configura Of Gt - Inserindo', operacao: 'I')))
                  .then((_) {
                Provider.of<TributConfiguraOfGtViewModel>(context).consultarLista();
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
                          title: 'Tribut Configura Of Gt - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<TributConfiguraOfGtViewModel>(context)
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
            child: listaTributConfiguraOfGt == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Tribut Configura Of Gt'),
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
                                  _sort<num>((TributConfiguraOfGt tributConfiguraOfGt) => tributConfiguraOfGt.id,
                                      columnIndex, ascending),
                            ),
							DataColumn(
								label: const Text('Grupo Tributário'),
								tooltip: 'Grupo Tributário',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((TributConfiguraOfGt tributConfiguraOfGt) => tributConfiguraOfGt.tributGrupoTributario?.descricao,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Operação Fiscal'),
								tooltip: 'Operação Fiscal',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((TributConfiguraOfGt tributConfiguraOfGt) => tributConfiguraOfGt.tributOperacaoFiscal?.descricao,
									columnIndex, ascending),
							),
                        ],
                        source: _tributConfiguraOfGtDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future _refrescarTela() async {
    await Provider.of<TributConfiguraOfGtViewModel>(context).consultarLista();
  }
}

/// codigo referente a fonte de dados
class TributConfiguraOfGtDataSource extends DataTableSource {
  final List<TributConfiguraOfGt> listaTributConfiguraOfGt;
  final BuildContext context;

  TributConfiguraOfGtDataSource(this.listaTributConfiguraOfGt, this.context);

  void _sort<T>(Comparable<T> getField(TributConfiguraOfGt tributConfiguraOfGt), bool ascending) {
    listaTributConfiguraOfGt.sort((TributConfiguraOfGt a, TributConfiguraOfGt b) {
      if (!ascending) {
        final TributConfiguraOfGt c = a;
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
    if (index >= listaTributConfiguraOfGt.length) return null;
    final TributConfiguraOfGt tributConfiguraOfGt = listaTributConfiguraOfGt[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${ tributConfiguraOfGt.id ?? ''}'), onTap: () {
          detalharTributConfiguraOfGt(tributConfiguraOfGt, context);
        }),
		DataCell(Text('${tributConfiguraOfGt.tributGrupoTributario?.descricao ?? ''}'), onTap: () {
			detalharTributConfiguraOfGt(tributConfiguraOfGt, context);
		}),
		DataCell(Text('${tributConfiguraOfGt.tributOperacaoFiscal?.descricao ?? ''}'), onTap: () {
			detalharTributConfiguraOfGt(tributConfiguraOfGt, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaTributConfiguraOfGt.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharTributConfiguraOfGt(TributConfiguraOfGt tributConfiguraOfGt, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/tributConfiguraOfGtDetalhe',
    arguments: tributConfiguraOfGt,
  );
}
