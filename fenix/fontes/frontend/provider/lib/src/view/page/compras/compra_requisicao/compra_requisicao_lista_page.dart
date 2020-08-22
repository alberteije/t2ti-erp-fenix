/*
Title: T2Ti ERP Fenix                                                                
Description: AbaMestre ListaPage relacionada à tabela [COMPRA_REQUISICAO] 
                                                                                
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
import 'compra_requisicao_page.dart';

class CompraRequisicaoListaPage extends StatefulWidget {
  @override
  _CompraRequisicaoListaPageState createState() => _CompraRequisicaoListaPageState();
}

class _CompraRequisicaoListaPageState extends State<CompraRequisicaoListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<CompraRequisicaoViewModel>(context).listaCompraRequisicao == null && Provider.of<CompraRequisicaoViewModel>(context).objetoJsonErro == null) {
      Provider.of<CompraRequisicaoViewModel>(context).consultarLista();
    }     
    var compraRequisicaoProvider = Provider.of<CompraRequisicaoViewModel>(context);
    var listaCompraRequisicao = compraRequisicaoProvider.listaCompraRequisicao;
    var colunas = CompraRequisicao.colunas;
    var campos = CompraRequisicao.campos;

    final CompraRequisicaoDataSource _compraRequisicaoDataSource =
        CompraRequisicaoDataSource(listaCompraRequisicao, context);

    void _sort<T>(Comparable<T> getField(CompraRequisicao compraRequisicao), int columnIndex, bool ascending) {
      _compraRequisicaoDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<CompraRequisicaoViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Compra Requisicao'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<CompraRequisicaoViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Compra Requisicao'),
          actions: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                      CompraRequisicaoPage(compraRequisicao: CompraRequisicao(), title: 'Compra Requisicao - Inserindo', operacao: 'I')))
                  .then((_) {
                Provider.of<CompraRequisicaoViewModel>(context).consultarLista();
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
                          title: 'Compra Requisicao - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<CompraRequisicaoViewModel>(context)
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
            child: listaCompraRequisicao == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Compra Requisicao'),
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
                                  _sort<num>((CompraRequisicao compraRequisicao) => compraRequisicao.id,
                                      columnIndex, ascending),
                            ),
							DataColumn(
								label: const Text('Tipo Requisição'),
								tooltip: 'Tipo Requisição',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((CompraRequisicao compraRequisicao) => compraRequisicao.compraTipoRequisicao?.nome,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Colaborador'),
								tooltip: 'Colaborador',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((CompraRequisicao compraRequisicao) => compraRequisicao.colaborador?.pessoa?.nome,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Descrição'),
								tooltip: 'Descrição',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((CompraRequisicao compraRequisicao) => compraRequisicao.descricao,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Data da Requisição'),
								tooltip: 'Data da Requisição',
								onSort: (int columnIndex, bool ascending) =>
									_sort<DateTime>((CompraRequisicao compraRequisicao) => compraRequisicao.dataRequisicao,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Observação'),
								tooltip: 'Observação',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((CompraRequisicao compraRequisicao) => compraRequisicao.observacao,
									columnIndex, ascending),
							),
                        ],
                        source: _compraRequisicaoDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future _refrescarTela() async {
    await Provider.of<CompraRequisicaoViewModel>(context).consultarLista();
  }
}

/// codigo referente a fonte de dados
class CompraRequisicaoDataSource extends DataTableSource {
  final List<CompraRequisicao> listaCompraRequisicao;
  final BuildContext context;

  CompraRequisicaoDataSource(this.listaCompraRequisicao, this.context);

  void _sort<T>(Comparable<T> getField(CompraRequisicao compraRequisicao), bool ascending) {
    listaCompraRequisicao.sort((CompraRequisicao a, CompraRequisicao b) {
      if (!ascending) {
        final CompraRequisicao c = a;
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
    if (index >= listaCompraRequisicao.length) return null;
    final CompraRequisicao compraRequisicao = listaCompraRequisicao[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${ compraRequisicao.id ?? ''}'), onTap: () {
          detalharCompraRequisicao(compraRequisicao, context);
        }),
		DataCell(Text('${compraRequisicao.compraTipoRequisicao?.nome ?? ''}'), onTap: () {
			detalharCompraRequisicao(compraRequisicao, context);
		}),
		DataCell(Text('${compraRequisicao.colaborador?.pessoa?.nome ?? ''}'), onTap: () {
			detalharCompraRequisicao(compraRequisicao, context);
		}),
		DataCell(Text('${compraRequisicao.descricao ?? ''}'), onTap: () {
			detalharCompraRequisicao(compraRequisicao, context);
		}),
		DataCell(Text('${compraRequisicao.dataRequisicao != null ? DateFormat('dd/MM/yyyy').format(compraRequisicao.dataRequisicao) : ''}'), onTap: () {
			detalharCompraRequisicao(compraRequisicao, context);
		}),
		DataCell(Text('${compraRequisicao.observacao ?? ''}'), onTap: () {
			detalharCompraRequisicao(compraRequisicao, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaCompraRequisicao.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharCompraRequisicao(CompraRequisicao compraRequisicao, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/compraRequisicaoDetalhe',
    arguments: compraRequisicao,
  );
}
