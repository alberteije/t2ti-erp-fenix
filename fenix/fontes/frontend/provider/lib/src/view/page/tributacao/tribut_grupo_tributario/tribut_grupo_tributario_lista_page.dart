/*
Title: T2Ti ERP Fenix                                                                
Description: ListaPage relacionada à tabela [TRIBUT_GRUPO_TRIBUTARIO] 
                                                                                
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
import 'tribut_grupo_tributario_persiste_page.dart';

class TributGrupoTributarioListaPage extends StatefulWidget {
  @override
  _TributGrupoTributarioListaPageState createState() => _TributGrupoTributarioListaPageState();
}

class _TributGrupoTributarioListaPageState extends State<TributGrupoTributarioListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<TributGrupoTributarioViewModel>(context).listaTributGrupoTributario == null && Provider.of<TributGrupoTributarioViewModel>(context).objetoJsonErro == null) {
      Provider.of<TributGrupoTributarioViewModel>(context).consultarLista();
    }
    var listaTributGrupoTributario = Provider.of<TributGrupoTributarioViewModel>(context).listaTributGrupoTributario;
    var colunas = TributGrupoTributario.colunas;
    var campos = TributGrupoTributario.campos;

    final TributGrupoTributarioDataSource _tributGrupoTributarioDataSource =
        TributGrupoTributarioDataSource(listaTributGrupoTributario, context);

    void _sort<T>(Comparable<T> getField(TributGrupoTributario tributGrupoTributario), int columnIndex, bool ascending) {
      _tributGrupoTributarioDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<TributGrupoTributarioViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Tribut Grupo Tributario'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<TributGrupoTributarioViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Tribut Grupo Tributario'),
          actions: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) => 
					  TributGrupoTributarioPersistePage(tributGrupoTributario: TributGrupoTributario(), title: 'Tribut Grupo Tributario - Inserindo', operacao: 'I')))
                  .then((_) {
                Provider.of<TributGrupoTributarioViewModel>(context).consultarLista();
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
                          title: 'Tribut Grupo Tributario - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<TributGrupoTributarioViewModel>(context)
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
            child: listaTributGrupoTributario == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Tribut Grupo Tributario'),
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
									_sort<num>((TributGrupoTributario tributGrupoTributario) => tributGrupoTributario.id,
										columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Id'),
								tooltip: 'Id',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((TributGrupoTributario tributGrupoTributario) => tributGrupoTributario.id,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Descrição'),
								tooltip: 'Descrição',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((TributGrupoTributario tributGrupoTributario) => tributGrupoTributario.descricao,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Origem da Mercadoria'),
								tooltip: 'Origem da Mercadoria',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((TributGrupoTributario tributGrupoTributario) => tributGrupoTributario.origemMercadoria,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Observação'),
								tooltip: 'Observação',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((TributGrupoTributario tributGrupoTributario) => tributGrupoTributario.observacao,
									columnIndex, ascending),
							),
                        ],
                        source: _tributGrupoTributarioDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future _refrescarTela() async {
    await Provider.of<TributGrupoTributarioViewModel>(context).consultarLista();
  }
}

/// codigo referente a fonte de dados
class TributGrupoTributarioDataSource extends DataTableSource {
  final List<TributGrupoTributario> listaTributGrupoTributario;
  final BuildContext context;

  TributGrupoTributarioDataSource(this.listaTributGrupoTributario, this.context);

  void _sort<T>(Comparable<T> getField(TributGrupoTributario tributGrupoTributario), bool ascending) {
    listaTributGrupoTributario.sort((TributGrupoTributario a, TributGrupoTributario b) {
      if (!ascending) {
        final TributGrupoTributario c = a;
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
    if (index >= listaTributGrupoTributario.length) return null;
    final TributGrupoTributario tributGrupoTributario = listaTributGrupoTributario[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${ tributGrupoTributario.id ?? ''}'), onTap: () {
          detalharTributGrupoTributario(tributGrupoTributario, context);
        }),
		DataCell(Text('${tributGrupoTributario.id ?? ''}'), onTap: () {
			detalharTributGrupoTributario(tributGrupoTributario, context);
		}),
		DataCell(Text('${tributGrupoTributario.descricao ?? ''}'), onTap: () {
			detalharTributGrupoTributario(tributGrupoTributario, context);
		}),
		DataCell(Text('${tributGrupoTributario.origemMercadoria ?? ''}'), onTap: () {
			detalharTributGrupoTributario(tributGrupoTributario, context);
		}),
		DataCell(Text('${tributGrupoTributario.observacao ?? ''}'), onTap: () {
			detalharTributGrupoTributario(tributGrupoTributario, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaTributGrupoTributario.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharTributGrupoTributario(TributGrupoTributario tributGrupoTributario, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/tributGrupoTributarioDetalhe',
    arguments: tributGrupoTributario,
  );
}