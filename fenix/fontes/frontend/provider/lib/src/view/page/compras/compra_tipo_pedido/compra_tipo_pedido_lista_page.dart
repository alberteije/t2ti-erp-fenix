/*
Title: T2Ti ERP Fenix                                                                
Description: ListaPage relacionada à tabela [COMPRA_TIPO_PEDIDO] 
                                                                                
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
import 'compra_tipo_pedido_persiste_page.dart';

class CompraTipoPedidoListaPage extends StatefulWidget {
  @override
  _CompraTipoPedidoListaPageState createState() => _CompraTipoPedidoListaPageState();
}

class _CompraTipoPedidoListaPageState extends State<CompraTipoPedidoListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<CompraTipoPedidoViewModel>(context).listaCompraTipoPedido == null && Provider.of<CompraTipoPedidoViewModel>(context).objetoJsonErro == null) {
      Provider.of<CompraTipoPedidoViewModel>(context).consultarLista();
    }
    var listaCompraTipoPedido = Provider.of<CompraTipoPedidoViewModel>(context).listaCompraTipoPedido;
    var colunas = CompraTipoPedido.colunas;
    var campos = CompraTipoPedido.campos;

    final CompraTipoPedidoDataSource _compraTipoPedidoDataSource =
        CompraTipoPedidoDataSource(listaCompraTipoPedido, context);

    void _sort<T>(Comparable<T> getField(CompraTipoPedido compraTipoPedido), int columnIndex, bool ascending) {
      _compraTipoPedidoDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<CompraTipoPedidoViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Compra Tipo Pedido'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<CompraTipoPedidoViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Compra Tipo Pedido'),
          actions: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) => 
					  CompraTipoPedidoPersistePage(compraTipoPedido: CompraTipoPedido(), title: 'Compra Tipo Pedido - Inserindo', operacao: 'I')))
                  .then((_) {
                Provider.of<CompraTipoPedidoViewModel>(context).consultarLista();
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
                          title: 'Compra Tipo Pedido - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<CompraTipoPedidoViewModel>(context)
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
            child: listaCompraTipoPedido == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Compra Tipo Pedido'),
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
									_sort<num>((CompraTipoPedido compraTipoPedido) => compraTipoPedido.id,
										columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Código do Pedido'),
								tooltip: 'Código do Pedido',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((CompraTipoPedido compraTipoPedido) => compraTipoPedido.codigo,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Nome'),
								tooltip: 'Nome',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((CompraTipoPedido compraTipoPedido) => compraTipoPedido.nome,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Descrição'),
								tooltip: 'Descrição',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((CompraTipoPedido compraTipoPedido) => compraTipoPedido.descricao,
									columnIndex, ascending),
							),
                        ],
                        source: _compraTipoPedidoDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future _refrescarTela() async {
    await Provider.of<CompraTipoPedidoViewModel>(context).consultarLista();
  }
}

/// codigo referente a fonte de dados
class CompraTipoPedidoDataSource extends DataTableSource {
  final List<CompraTipoPedido> listaCompraTipoPedido;
  final BuildContext context;

  CompraTipoPedidoDataSource(this.listaCompraTipoPedido, this.context);

  void _sort<T>(Comparable<T> getField(CompraTipoPedido compraTipoPedido), bool ascending) {
    listaCompraTipoPedido.sort((CompraTipoPedido a, CompraTipoPedido b) {
      if (!ascending) {
        final CompraTipoPedido c = a;
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
    if (index >= listaCompraTipoPedido.length) return null;
    final CompraTipoPedido compraTipoPedido = listaCompraTipoPedido[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${ compraTipoPedido.id ?? ''}'), onTap: () {
          detalharCompraTipoPedido(compraTipoPedido, context);
        }),
		DataCell(Text('${compraTipoPedido.codigo ?? ''}'), onTap: () {
			detalharCompraTipoPedido(compraTipoPedido, context);
		}),
		DataCell(Text('${compraTipoPedido.nome ?? ''}'), onTap: () {
			detalharCompraTipoPedido(compraTipoPedido, context);
		}),
		DataCell(Text('${compraTipoPedido.descricao ?? ''}'), onTap: () {
			detalharCompraTipoPedido(compraTipoPedido, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaCompraTipoPedido.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharCompraTipoPedido(CompraTipoPedido compraTipoPedido, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/compraTipoPedidoDetalhe',
    arguments: compraTipoPedido,
  );
}