/*
Title: T2Ti ERP Fenix                                                                
Description: AbaMestre ListaPage relacionada à tabela [COMPRA_COTACAO] 
                                                                                
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
import 'package:intl/intl.dart';
import 'compra_cotacao_page.dart';

class CompraCotacaoListaPage extends StatefulWidget {
  @override
  _CompraCotacaoListaPageState createState() => _CompraCotacaoListaPageState();
}

class _CompraCotacaoListaPageState extends State<CompraCotacaoListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<CompraCotacaoViewModel>(context).listaCompraCotacao == null && Provider.of<CompraCotacaoViewModel>(context).objetoJsonErro == null) {
      Provider.of<CompraCotacaoViewModel>(context).consultarLista();
    }     
    var compraCotacaoProvider = Provider.of<CompraCotacaoViewModel>(context);
    var listaCompraCotacao = compraCotacaoProvider.listaCompraCotacao;
    var colunas = CompraCotacao.colunas;
    var campos = CompraCotacao.campos;

    final CompraCotacaoDataSource _compraCotacaoDataSource =
        CompraCotacaoDataSource(listaCompraCotacao, context);

    void _sort<T>(Comparable<T> getField(CompraCotacao compraCotacao), int columnIndex, bool ascending) {
      _compraCotacaoDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<CompraCotacaoViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Compra Cotacao'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<CompraCotacaoViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Compra Cotacao'),
          actions: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                      CompraCotacaoPage(compraCotacao: CompraCotacao(), title: 'Compra Cotacao - Inserindo', operacao: 'I')))
                  .then((_) {
                Provider.of<CompraCotacaoViewModel>(context).consultarLista();
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
                          title: 'Compra Cotacao - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<CompraCotacaoViewModel>(context)
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
            child: listaCompraCotacao == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Compra Cotacao'),
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
                                  _sort<num>((CompraCotacao compraCotacao) => compraCotacao.id,
                                      columnIndex, ascending),
                            ),
							DataColumn(
								label: const Text('Requisição'),
								tooltip: 'Requisição',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((CompraCotacao compraCotacao) => compraCotacao.compraRequisicao?.descricao,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Data da Cotação'),
								tooltip: 'Data da Cotação',
								onSort: (int columnIndex, bool ascending) =>
									_sort<DateTime>((CompraCotacao compraCotacao) => compraCotacao.dataCotacao,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Descrição'),
								tooltip: 'Descrição',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((CompraCotacao compraCotacao) => compraCotacao.descricao,
									columnIndex, ascending),
							),
                        ],
                        source: _compraCotacaoDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future _refrescarTela() async {
    await Provider.of<CompraCotacaoViewModel>(context).consultarLista();
  }
}

/// codigo referente a fonte de dados
class CompraCotacaoDataSource extends DataTableSource {
  final List<CompraCotacao> listaCompraCotacao;
  final BuildContext context;

  CompraCotacaoDataSource(this.listaCompraCotacao, this.context);

  void _sort<T>(Comparable<T> getField(CompraCotacao compraCotacao), bool ascending) {
    listaCompraCotacao.sort((CompraCotacao a, CompraCotacao b) {
      if (!ascending) {
        final CompraCotacao c = a;
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
    if (index >= listaCompraCotacao.length) return null;
    final CompraCotacao compraCotacao = listaCompraCotacao[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${ compraCotacao.id ?? ''}'), onTap: () {
          detalharCompraCotacao(compraCotacao, context);
        }),
		DataCell(Text('${compraCotacao.compraRequisicao?.descricao ?? ''}'), onTap: () {
			detalharCompraCotacao(compraCotacao, context);
		}),
		DataCell(Text('${compraCotacao.dataCotacao != null ? DateFormat('dd/MM/yyyy').format(compraCotacao.dataCotacao) : ''}'), onTap: () {
			detalharCompraCotacao(compraCotacao, context);
		}),
		DataCell(Text('${compraCotacao.descricao ?? ''}'), onTap: () {
			detalharCompraCotacao(compraCotacao, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaCompraCotacao.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharCompraCotacao(CompraCotacao compraCotacao, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/compraCotacaoDetalhe',
    arguments: compraCotacao,
  );
}
