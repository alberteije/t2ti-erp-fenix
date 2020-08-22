/*
Title: T2Ti ERP Fenix                                                                
Description: AbaMestre ListaPage relacionada à tabela [VENDA_CONDICOES_PAGAMENTO] 
                                                                                
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
import 'venda_condicoes_pagamento_page.dart';

class VendaCondicoesPagamentoListaPage extends StatefulWidget {
  @override
  _VendaCondicoesPagamentoListaPageState createState() => _VendaCondicoesPagamentoListaPageState();
}

class _VendaCondicoesPagamentoListaPageState extends State<VendaCondicoesPagamentoListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<VendaCondicoesPagamentoViewModel>(context).listaVendaCondicoesPagamento == null && Provider.of<VendaCondicoesPagamentoViewModel>(context).objetoJsonErro == null) {
      Provider.of<VendaCondicoesPagamentoViewModel>(context).consultarLista();
    }     
    var vendaCondicoesPagamentoProvider = Provider.of<VendaCondicoesPagamentoViewModel>(context);
    var listaVendaCondicoesPagamento = vendaCondicoesPagamentoProvider.listaVendaCondicoesPagamento;
    var colunas = VendaCondicoesPagamento.colunas;
    var campos = VendaCondicoesPagamento.campos;

    final VendaCondicoesPagamentoDataSource _vendaCondicoesPagamentoDataSource =
        VendaCondicoesPagamentoDataSource(listaVendaCondicoesPagamento, context);

    void _sort<T>(Comparable<T> getField(VendaCondicoesPagamento vendaCondicoesPagamento), int columnIndex, bool ascending) {
      _vendaCondicoesPagamentoDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<VendaCondicoesPagamentoViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Venda Condicoes Pagamento'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<VendaCondicoesPagamentoViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Venda Condicoes Pagamento'),
          actions: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                      VendaCondicoesPagamentoPage(vendaCondicoesPagamento: VendaCondicoesPagamento(), title: 'Venda Condicoes Pagamento - Inserindo', operacao: 'I')))
                  .then((_) {
                Provider.of<VendaCondicoesPagamentoViewModel>(context).consultarLista();
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
                          title: 'Venda Condicoes Pagamento - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<VendaCondicoesPagamentoViewModel>(context)
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
            child: listaVendaCondicoesPagamento == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Venda Condicoes Pagamento'),
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
                                  _sort<num>((VendaCondicoesPagamento vendaCondicoesPagamento) => vendaCondicoesPagamento.id,
                                      columnIndex, ascending),
                            ),
							DataColumn(
								label: const Text('Nome'),
								tooltip: 'Nome',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((VendaCondicoesPagamento vendaCondicoesPagamento) => vendaCondicoesPagamento.nome,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Descrição'),
								tooltip: 'Descrição',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((VendaCondicoesPagamento vendaCondicoesPagamento) => vendaCondicoesPagamento.descricao,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Faturamento Mínimo'),
								tooltip: 'Faturamento Mínimo',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((VendaCondicoesPagamento vendaCondicoesPagamento) => vendaCondicoesPagamento.faturamentoMinimo,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Faturamento Máximo'),
								tooltip: 'Faturamento Máximo',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((VendaCondicoesPagamento vendaCondicoesPagamento) => vendaCondicoesPagamento.faturamentoMaximo,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Índice de Correção'),
								tooltip: 'Índice de Correção',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((VendaCondicoesPagamento vendaCondicoesPagamento) => vendaCondicoesPagamento.indiceCorrecao,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Dias de Tolerância'),
								tooltip: 'Dias de Tolerância',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((VendaCondicoesPagamento vendaCondicoesPagamento) => vendaCondicoesPagamento.diasTolerancia,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Valor Tolerância'),
								tooltip: 'Valor Tolerância',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((VendaCondicoesPagamento vendaCondicoesPagamento) => vendaCondicoesPagamento.valorTolerancia,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Prazo Médio'),
								tooltip: 'Prazo Médio',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((VendaCondicoesPagamento vendaCondicoesPagamento) => vendaCondicoesPagamento.prazoMedio,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Vista ou Prazo'),
								tooltip: 'Vista ou Prazo',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((VendaCondicoesPagamento vendaCondicoesPagamento) => vendaCondicoesPagamento.vistaPrazo,
									columnIndex, ascending),
							),
                        ],
                        source: _vendaCondicoesPagamentoDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future _refrescarTela() async {
    await Provider.of<VendaCondicoesPagamentoViewModel>(context).consultarLista();
  }
}

/// codigo referente a fonte de dados
class VendaCondicoesPagamentoDataSource extends DataTableSource {
  final List<VendaCondicoesPagamento> listaVendaCondicoesPagamento;
  final BuildContext context;

  VendaCondicoesPagamentoDataSource(this.listaVendaCondicoesPagamento, this.context);

  void _sort<T>(Comparable<T> getField(VendaCondicoesPagamento vendaCondicoesPagamento), bool ascending) {
    listaVendaCondicoesPagamento.sort((VendaCondicoesPagamento a, VendaCondicoesPagamento b) {
      if (!ascending) {
        final VendaCondicoesPagamento c = a;
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
    if (index >= listaVendaCondicoesPagamento.length) return null;
    final VendaCondicoesPagamento vendaCondicoesPagamento = listaVendaCondicoesPagamento[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${ vendaCondicoesPagamento.id ?? ''}'), onTap: () {
          detalharVendaCondicoesPagamento(vendaCondicoesPagamento, context);
        }),
		DataCell(Text('${vendaCondicoesPagamento.nome ?? ''}'), onTap: () {
			detalharVendaCondicoesPagamento(vendaCondicoesPagamento, context);
		}),
		DataCell(Text('${vendaCondicoesPagamento.descricao ?? ''}'), onTap: () {
			detalharVendaCondicoesPagamento(vendaCondicoesPagamento, context);
		}),
		DataCell(Text('${vendaCondicoesPagamento.faturamentoMinimo != null ? Constantes.formatoDecimalValor.format(vendaCondicoesPagamento.faturamentoMinimo) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharVendaCondicoesPagamento(vendaCondicoesPagamento, context);
		}),
		DataCell(Text('${vendaCondicoesPagamento.faturamentoMaximo != null ? Constantes.formatoDecimalValor.format(vendaCondicoesPagamento.faturamentoMaximo) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharVendaCondicoesPagamento(vendaCondicoesPagamento, context);
		}),
		DataCell(Text('${vendaCondicoesPagamento.indiceCorrecao != null ? Constantes.formatoDecimalValor.format(vendaCondicoesPagamento.indiceCorrecao) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharVendaCondicoesPagamento(vendaCondicoesPagamento, context);
		}),
		DataCell(Text('${vendaCondicoesPagamento.diasTolerancia ?? ''}'), onTap: () {
			detalharVendaCondicoesPagamento(vendaCondicoesPagamento, context);
		}),
		DataCell(Text('${vendaCondicoesPagamento.valorTolerancia != null ? Constantes.formatoDecimalValor.format(vendaCondicoesPagamento.valorTolerancia) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharVendaCondicoesPagamento(vendaCondicoesPagamento, context);
		}),
		DataCell(Text('${vendaCondicoesPagamento.prazoMedio ?? ''}'), onTap: () {
			detalharVendaCondicoesPagamento(vendaCondicoesPagamento, context);
		}),
		DataCell(Text('${vendaCondicoesPagamento.vistaPrazo ?? ''}'), onTap: () {
			detalharVendaCondicoesPagamento(vendaCondicoesPagamento, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaVendaCondicoesPagamento.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharVendaCondicoesPagamento(VendaCondicoesPagamento vendaCondicoesPagamento, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/vendaCondicoesPagamentoDetalhe',
    arguments: vendaCondicoesPagamento,
  );
}
