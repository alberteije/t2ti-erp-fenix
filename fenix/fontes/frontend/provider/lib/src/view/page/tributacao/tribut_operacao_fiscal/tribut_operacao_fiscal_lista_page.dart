/*
Title: T2Ti ERP Fenix                                                                
Description: ListaPage relacionada à tabela [TRIBUT_OPERACAO_FISCAL] 
                                                                                
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
import 'tribut_operacao_fiscal_persiste_page.dart';

class TributOperacaoFiscalListaPage extends StatefulWidget {
  @override
  _TributOperacaoFiscalListaPageState createState() => _TributOperacaoFiscalListaPageState();
}

class _TributOperacaoFiscalListaPageState extends State<TributOperacaoFiscalListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<TributOperacaoFiscalViewModel>(context).listaTributOperacaoFiscal == null && Provider.of<TributOperacaoFiscalViewModel>(context).objetoJsonErro == null) {
      Provider.of<TributOperacaoFiscalViewModel>(context).consultarLista();
    }
    var listaTributOperacaoFiscal = Provider.of<TributOperacaoFiscalViewModel>(context).listaTributOperacaoFiscal;
    var colunas = TributOperacaoFiscal.colunas;
    var campos = TributOperacaoFiscal.campos;

    final TributOperacaoFiscalDataSource _tributOperacaoFiscalDataSource =
        TributOperacaoFiscalDataSource(listaTributOperacaoFiscal, context);

    void _sort<T>(Comparable<T> getField(TributOperacaoFiscal tributOperacaoFiscal), int columnIndex, bool ascending) {
      _tributOperacaoFiscalDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<TributOperacaoFiscalViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Tribut Operacao Fiscal'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<TributOperacaoFiscalViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Tribut Operacao Fiscal'),
          actions: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) => 
					  TributOperacaoFiscalPersistePage(tributOperacaoFiscal: TributOperacaoFiscal(), title: 'Tribut Operacao Fiscal - Inserindo', operacao: 'I')))
                  .then((_) {
                Provider.of<TributOperacaoFiscalViewModel>(context).consultarLista();
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
                          title: 'Tribut Operacao Fiscal - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<TributOperacaoFiscalViewModel>(context)
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
            child: listaTributOperacaoFiscal == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Tribut Operacao Fiscal'),
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
									_sort<num>((TributOperacaoFiscal tributOperacaoFiscal) => tributOperacaoFiscal.id,
										columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Id'),
								tooltip: 'Id',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((TributOperacaoFiscal tributOperacaoFiscal) => tributOperacaoFiscal.id,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Descrição'),
								tooltip: 'Descrição',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((TributOperacaoFiscal tributOperacaoFiscal) => tributOperacaoFiscal.descricao,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Descrição na NF'),
								tooltip: 'Descrição na NF',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((TributOperacaoFiscal tributOperacaoFiscal) => tributOperacaoFiscal.descricaoNaNf,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('CFOP'),
								tooltip: 'CFOP',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((TributOperacaoFiscal tributOperacaoFiscal) => tributOperacaoFiscal.cfop,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Observação'),
								tooltip: 'Observação',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((TributOperacaoFiscal tributOperacaoFiscal) => tributOperacaoFiscal.observacao,
									columnIndex, ascending),
							),
                        ],
                        source: _tributOperacaoFiscalDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future _refrescarTela() async {
    await Provider.of<TributOperacaoFiscalViewModel>(context).consultarLista();
  }
}

/// codigo referente a fonte de dados
class TributOperacaoFiscalDataSource extends DataTableSource {
  final List<TributOperacaoFiscal> listaTributOperacaoFiscal;
  final BuildContext context;

  TributOperacaoFiscalDataSource(this.listaTributOperacaoFiscal, this.context);

  void _sort<T>(Comparable<T> getField(TributOperacaoFiscal tributOperacaoFiscal), bool ascending) {
    listaTributOperacaoFiscal.sort((TributOperacaoFiscal a, TributOperacaoFiscal b) {
      if (!ascending) {
        final TributOperacaoFiscal c = a;
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
    if (index >= listaTributOperacaoFiscal.length) return null;
    final TributOperacaoFiscal tributOperacaoFiscal = listaTributOperacaoFiscal[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${ tributOperacaoFiscal.id ?? ''}'), onTap: () {
          detalharTributOperacaoFiscal(tributOperacaoFiscal, context);
        }),
		DataCell(Text('${tributOperacaoFiscal.id ?? ''}'), onTap: () {
			detalharTributOperacaoFiscal(tributOperacaoFiscal, context);
		}),
		DataCell(Text('${tributOperacaoFiscal.descricao ?? ''}'), onTap: () {
			detalharTributOperacaoFiscal(tributOperacaoFiscal, context);
		}),
		DataCell(Text('${tributOperacaoFiscal.descricaoNaNf ?? ''}'), onTap: () {
			detalharTributOperacaoFiscal(tributOperacaoFiscal, context);
		}),
		DataCell(Text('${tributOperacaoFiscal.cfop ?? ''}'), onTap: () {
			detalharTributOperacaoFiscal(tributOperacaoFiscal, context);
		}),
		DataCell(Text('${tributOperacaoFiscal.observacao ?? ''}'), onTap: () {
			detalharTributOperacaoFiscal(tributOperacaoFiscal, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaTributOperacaoFiscal.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharTributOperacaoFiscal(TributOperacaoFiscal tributOperacaoFiscal, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/tributOperacaoFiscalDetalhe',
    arguments: tributOperacaoFiscal,
  );
}