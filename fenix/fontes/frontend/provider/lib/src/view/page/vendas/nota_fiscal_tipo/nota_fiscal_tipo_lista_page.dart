/*
Title: T2Ti ERP Fenix                                                                
Description: ListaPage relacionada à tabela [NOTA_FISCAL_TIPO] 
                                                                                
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
import 'nota_fiscal_tipo_persiste_page.dart';

class NotaFiscalTipoListaPage extends StatefulWidget {
  @override
  _NotaFiscalTipoListaPageState createState() => _NotaFiscalTipoListaPageState();
}

class _NotaFiscalTipoListaPageState extends State<NotaFiscalTipoListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<NotaFiscalTipoViewModel>(context).listaNotaFiscalTipo == null && Provider.of<NotaFiscalTipoViewModel>(context).objetoJsonErro == null) {
      Provider.of<NotaFiscalTipoViewModel>(context).consultarLista();
    }
    var listaNotaFiscalTipo = Provider.of<NotaFiscalTipoViewModel>(context).listaNotaFiscalTipo;
    var colunas = NotaFiscalTipo.colunas;
    var campos = NotaFiscalTipo.campos;

    final NotaFiscalTipoDataSource _notaFiscalTipoDataSource =
        NotaFiscalTipoDataSource(listaNotaFiscalTipo, context);

    void _sort<T>(Comparable<T> getField(NotaFiscalTipo notaFiscalTipo), int columnIndex, bool ascending) {
      _notaFiscalTipoDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<NotaFiscalTipoViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Nota Fiscal Tipo'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<NotaFiscalTipoViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Nota Fiscal Tipo'),
          actions: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) => 
					  NotaFiscalTipoPersistePage(notaFiscalTipo: NotaFiscalTipo(), title: 'Nota Fiscal Tipo - Inserindo', operacao: 'I')))
                  .then((_) {
                Provider.of<NotaFiscalTipoViewModel>(context).consultarLista();
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
                          title: 'Nota Fiscal Tipo - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<NotaFiscalTipoViewModel>(context)
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
            child: listaNotaFiscalTipo == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Nota Fiscal Tipo'),
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
									_sort<num>((NotaFiscalTipo notaFiscalTipo) => notaFiscalTipo.id,
										columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Id'),
								tooltip: 'Id',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((NotaFiscalTipo notaFiscalTipo) => notaFiscalTipo.id,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Modelo NF'),
								tooltip: 'Modelo Nota Fiscal',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((NotaFiscalTipo notaFiscalTipo) => notaFiscalTipo.notaFiscalModelo?.descricao,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Nome'),
								tooltip: 'Nome',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((NotaFiscalTipo notaFiscalTipo) => notaFiscalTipo.nome,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Descrição'),
								tooltip: 'Descrição',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((NotaFiscalTipo notaFiscalTipo) => notaFiscalTipo.descricao,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Série'),
								tooltip: 'Série',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((NotaFiscalTipo notaFiscalTipo) => notaFiscalTipo.serie,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Série SCAN'),
								tooltip: 'Série SCAN',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((NotaFiscalTipo notaFiscalTipo) => notaFiscalTipo.serieScan,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Último Número'),
								tooltip: 'Último Número',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((NotaFiscalTipo notaFiscalTipo) => notaFiscalTipo.ultimoNumero,
									columnIndex, ascending),
							),
                        ],
                        source: _notaFiscalTipoDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future _refrescarTela() async {
    await Provider.of<NotaFiscalTipoViewModel>(context).consultarLista();
  }
}

/// codigo referente a fonte de dados
class NotaFiscalTipoDataSource extends DataTableSource {
  final List<NotaFiscalTipo> listaNotaFiscalTipo;
  final BuildContext context;

  NotaFiscalTipoDataSource(this.listaNotaFiscalTipo, this.context);

  void _sort<T>(Comparable<T> getField(NotaFiscalTipo notaFiscalTipo), bool ascending) {
    listaNotaFiscalTipo.sort((NotaFiscalTipo a, NotaFiscalTipo b) {
      if (!ascending) {
        final NotaFiscalTipo c = a;
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
    if (index >= listaNotaFiscalTipo.length) return null;
    final NotaFiscalTipo notaFiscalTipo = listaNotaFiscalTipo[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${ notaFiscalTipo.id ?? ''}'), onTap: () {
          detalharNotaFiscalTipo(notaFiscalTipo, context);
        }),
		DataCell(Text('${notaFiscalTipo.id ?? ''}'), onTap: () {
			detalharNotaFiscalTipo(notaFiscalTipo, context);
		}),
		DataCell(Text('${notaFiscalTipo.notaFiscalModelo?.descricao ?? ''}'), onTap: () {
			detalharNotaFiscalTipo(notaFiscalTipo, context);
		}),
		DataCell(Text('${notaFiscalTipo.nome ?? ''}'), onTap: () {
			detalharNotaFiscalTipo(notaFiscalTipo, context);
		}),
		DataCell(Text('${notaFiscalTipo.descricao ?? ''}'), onTap: () {
			detalharNotaFiscalTipo(notaFiscalTipo, context);
		}),
		DataCell(Text('${notaFiscalTipo.serie ?? ''}'), onTap: () {
			detalharNotaFiscalTipo(notaFiscalTipo, context);
		}),
		DataCell(Text('${notaFiscalTipo.serieScan ?? ''}'), onTap: () {
			detalharNotaFiscalTipo(notaFiscalTipo, context);
		}),
		DataCell(Text('${notaFiscalTipo.ultimoNumero ?? ''}'), onTap: () {
			detalharNotaFiscalTipo(notaFiscalTipo, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaNotaFiscalTipo.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharNotaFiscalTipo(NotaFiscalTipo notaFiscalTipo, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/notaFiscalTipoDetalhe',
    arguments: notaFiscalTipo,
  );
}