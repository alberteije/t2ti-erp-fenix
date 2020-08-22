/*
Title: T2Ti ERP Fenix                                                                
Description: AbaMestre ListaPage relacionada à tabela [REQUISICAO_INTERNA_CABECALHO] 
                                                                                
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
import 'requisicao_interna_cabecalho_page.dart';

class RequisicaoInternaCabecalhoListaPage extends StatefulWidget {
  @override
  _RequisicaoInternaCabecalhoListaPageState createState() => _RequisicaoInternaCabecalhoListaPageState();
}

class _RequisicaoInternaCabecalhoListaPageState extends State<RequisicaoInternaCabecalhoListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<RequisicaoInternaCabecalhoViewModel>(context).listaRequisicaoInternaCabecalho == null && Provider.of<RequisicaoInternaCabecalhoViewModel>(context).objetoJsonErro == null) {
      Provider.of<RequisicaoInternaCabecalhoViewModel>(context).consultarLista();
    }     
    var requisicaoInternaCabecalhoProvider = Provider.of<RequisicaoInternaCabecalhoViewModel>(context);
    var listaRequisicaoInternaCabecalho = requisicaoInternaCabecalhoProvider.listaRequisicaoInternaCabecalho;
    var colunas = RequisicaoInternaCabecalho.colunas;
    var campos = RequisicaoInternaCabecalho.campos;

    final RequisicaoInternaCabecalhoDataSource _requisicaoInternaCabecalhoDataSource =
        RequisicaoInternaCabecalhoDataSource(listaRequisicaoInternaCabecalho, context);

    void _sort<T>(Comparable<T> getField(RequisicaoInternaCabecalho requisicaoInternaCabecalho), int columnIndex, bool ascending) {
      _requisicaoInternaCabecalhoDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<RequisicaoInternaCabecalhoViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Requisicao Interna Cabecalho'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<RequisicaoInternaCabecalhoViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Requisicao Interna Cabecalho'),
          actions: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                      RequisicaoInternaCabecalhoPage(requisicaoInternaCabecalho: RequisicaoInternaCabecalho(), title: 'Requisicao Interna Cabecalho - Inserindo', operacao: 'I')))
                  .then((_) {
                Provider.of<RequisicaoInternaCabecalhoViewModel>(context).consultarLista();
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
                          title: 'Requisicao Interna Cabecalho - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<RequisicaoInternaCabecalhoViewModel>(context)
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
            child: listaRequisicaoInternaCabecalho == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Requisicao Interna Cabecalho'),
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
                                  _sort<num>((RequisicaoInternaCabecalho requisicaoInternaCabecalho) => requisicaoInternaCabecalho.id,
                                      columnIndex, ascending),
                            ),
							DataColumn(
								label: const Text('Colaborador'),
								tooltip: 'Colaborador',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((RequisicaoInternaCabecalho requisicaoInternaCabecalho) => requisicaoInternaCabecalho.colaborador?.pessoa?.nome,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Data da Requisição'),
								tooltip: 'Data da Requisição',
								onSort: (int columnIndex, bool ascending) =>
									_sort<DateTime>((RequisicaoInternaCabecalho requisicaoInternaCabecalho) => requisicaoInternaCabecalho.dataRequisicao,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Situação da Requisição'),
								tooltip: 'Situação da Requisição',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((RequisicaoInternaCabecalho requisicaoInternaCabecalho) => requisicaoInternaCabecalho.situacao,
									columnIndex, ascending),
							),
                        ],
                        source: _requisicaoInternaCabecalhoDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future _refrescarTela() async {
    await Provider.of<RequisicaoInternaCabecalhoViewModel>(context).consultarLista();
  }
}

/// codigo referente a fonte de dados
class RequisicaoInternaCabecalhoDataSource extends DataTableSource {
  final List<RequisicaoInternaCabecalho> listaRequisicaoInternaCabecalho;
  final BuildContext context;

  RequisicaoInternaCabecalhoDataSource(this.listaRequisicaoInternaCabecalho, this.context);

  void _sort<T>(Comparable<T> getField(RequisicaoInternaCabecalho requisicaoInternaCabecalho), bool ascending) {
    listaRequisicaoInternaCabecalho.sort((RequisicaoInternaCabecalho a, RequisicaoInternaCabecalho b) {
      if (!ascending) {
        final RequisicaoInternaCabecalho c = a;
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
    if (index >= listaRequisicaoInternaCabecalho.length) return null;
    final RequisicaoInternaCabecalho requisicaoInternaCabecalho = listaRequisicaoInternaCabecalho[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${ requisicaoInternaCabecalho.id ?? ''}'), onTap: () {
          detalharRequisicaoInternaCabecalho(requisicaoInternaCabecalho, context);
        }),
		DataCell(Text('${requisicaoInternaCabecalho.colaborador?.pessoa?.nome ?? ''}'), onTap: () {
			detalharRequisicaoInternaCabecalho(requisicaoInternaCabecalho, context);
		}),
		DataCell(Text('${requisicaoInternaCabecalho.dataRequisicao != null ? DateFormat('dd/MM/yyyy').format(requisicaoInternaCabecalho.dataRequisicao) : ''}'), onTap: () {
			detalharRequisicaoInternaCabecalho(requisicaoInternaCabecalho, context);
		}),
		DataCell(Text('${requisicaoInternaCabecalho.situacao ?? ''}'), onTap: () {
			detalharRequisicaoInternaCabecalho(requisicaoInternaCabecalho, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaRequisicaoInternaCabecalho.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharRequisicaoInternaCabecalho(RequisicaoInternaCabecalho requisicaoInternaCabecalho, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/requisicaoInternaCabecalhoDetalhe',
    arguments: requisicaoInternaCabecalho,
  );
}
