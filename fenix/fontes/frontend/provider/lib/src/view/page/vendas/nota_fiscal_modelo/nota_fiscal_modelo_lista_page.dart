/*
Title: T2Ti ERP Fenix                                                                
Description: ListaPage relacionada à tabela [NOTA_FISCAL_MODELO] 
                                                                                
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
// import 'nota_fiscal_modelo_persiste_page.dart';

class NotaFiscalModeloListaPage extends StatefulWidget {
  @override
  _NotaFiscalModeloListaPageState createState() => _NotaFiscalModeloListaPageState();
}

class _NotaFiscalModeloListaPageState extends State<NotaFiscalModeloListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<NotaFiscalModeloViewModel>(context).listaNotaFiscalModelo == null && Provider.of<NotaFiscalModeloViewModel>(context).objetoJsonErro == null) {
      Provider.of<NotaFiscalModeloViewModel>(context).consultarLista();
    }
    var listaNotaFiscalModelo = Provider.of<NotaFiscalModeloViewModel>(context).listaNotaFiscalModelo;
    var colunas = NotaFiscalModelo.colunas;
    var campos = NotaFiscalModelo.campos;

    final NotaFiscalModeloDataSource _notaFiscalModeloDataSource =
        NotaFiscalModeloDataSource(listaNotaFiscalModelo, context);

    void _sort<T>(Comparable<T> getField(NotaFiscalModelo notaFiscalModelo), int columnIndex, bool ascending) {
      _notaFiscalModeloDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<NotaFiscalModeloViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Nota Fiscal Modelo'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<NotaFiscalModeloViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Nota Fiscal Modelo'),
          actions: <Widget>[],
        ),
        // floatingActionButton: FloatingActionButton(
        //     backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
        //     child: ViewUtilLib.getIconBotaoInserir(),
        //     onPressed: () {
        //       Navigator.of(context)
        //           .push(MaterialPageRoute(
        //               builder: (BuildContext context) => 
				// 	  NotaFiscalModeloPersistePage(notaFiscalModelo: NotaFiscalModelo(), title: 'Nota Fiscal Modelo - Inserindo', operacao: 'I')))
        //           .then((_) {
        //         Provider.of<NotaFiscalModeloViewModel>(context).consultarLista();
        //       });
        //     }),
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
                          title: 'Nota Fiscal Modelo - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<NotaFiscalModeloViewModel>(context)
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
            child: listaNotaFiscalModelo == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Nota Fiscal Modelo'),
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
									_sort<num>((NotaFiscalModelo notaFiscalModelo) => notaFiscalModelo.id,
										columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Id'),
								tooltip: 'Id',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((NotaFiscalModelo notaFiscalModelo) => notaFiscalModelo.id,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Código do Modelo'),
								tooltip: 'Código do Modelo',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((NotaFiscalModelo notaFiscalModelo) => notaFiscalModelo.codigo,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Descrição'),
								tooltip: 'Descrição',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((NotaFiscalModelo notaFiscalModelo) => notaFiscalModelo.descricao,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Modelo'),
								tooltip: 'Modelo',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((NotaFiscalModelo notaFiscalModelo) => notaFiscalModelo.modelo,
									columnIndex, ascending),
							),
                        ],
                        source: _notaFiscalModeloDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future _refrescarTela() async {
    await Provider.of<NotaFiscalModeloViewModel>(context).consultarLista();
  }
}

/// codigo referente a fonte de dados
class NotaFiscalModeloDataSource extends DataTableSource {
  final List<NotaFiscalModelo> listaNotaFiscalModelo;
  final BuildContext context;

  NotaFiscalModeloDataSource(this.listaNotaFiscalModelo, this.context);

  void _sort<T>(Comparable<T> getField(NotaFiscalModelo notaFiscalModelo), bool ascending) {
    listaNotaFiscalModelo.sort((NotaFiscalModelo a, NotaFiscalModelo b) {
      if (!ascending) {
        final NotaFiscalModelo c = a;
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
    if (index >= listaNotaFiscalModelo.length) return null;
    final NotaFiscalModelo notaFiscalModelo = listaNotaFiscalModelo[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${ notaFiscalModelo.id ?? ''}'), onTap: () {
          detalharNotaFiscalModelo(notaFiscalModelo, context);
        }),
		DataCell(Text('${notaFiscalModelo.id ?? ''}'), onTap: () {
			detalharNotaFiscalModelo(notaFiscalModelo, context);
		}),
		DataCell(Text('${notaFiscalModelo.codigo ?? ''}'), onTap: () {
			detalharNotaFiscalModelo(notaFiscalModelo, context);
		}),
		DataCell(Text('${notaFiscalModelo.descricao ?? ''}'), onTap: () {
			detalharNotaFiscalModelo(notaFiscalModelo, context);
		}),
		DataCell(Text('${notaFiscalModelo.modelo ?? ''}'), onTap: () {
			detalharNotaFiscalModelo(notaFiscalModelo, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaNotaFiscalModelo.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharNotaFiscalModelo(NotaFiscalModelo notaFiscalModelo, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/notaFiscalModeloDetalhe',
    arguments: notaFiscalModelo,
  );
}