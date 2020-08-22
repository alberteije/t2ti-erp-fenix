/*
Title: T2Ti ERP Fenix                                                                
Description: ListaPage relacionada à tabela [OS_EQUIPAMENTO] 
                                                                                
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
import 'os_equipamento_persiste_page.dart';

class OsEquipamentoListaPage extends StatefulWidget {
  @override
  _OsEquipamentoListaPageState createState() => _OsEquipamentoListaPageState();
}

class _OsEquipamentoListaPageState extends State<OsEquipamentoListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<OsEquipamentoViewModel>(context).listaOsEquipamento == null && Provider.of<OsEquipamentoViewModel>(context).objetoJsonErro == null) {
      Provider.of<OsEquipamentoViewModel>(context).consultarLista();
    }
    var listaOsEquipamento = Provider.of<OsEquipamentoViewModel>(context).listaOsEquipamento;
    var colunas = OsEquipamento.colunas;
    var campos = OsEquipamento.campos;

    final OsEquipamentoDataSource _osEquipamentoDataSource =
        OsEquipamentoDataSource(listaOsEquipamento, context);

    void _sort<T>(Comparable<T> getField(OsEquipamento osEquipamento), int columnIndex, bool ascending) {
      _osEquipamentoDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<OsEquipamentoViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Os Equipamento'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<OsEquipamentoViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Os Equipamento'),
          actions: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) => 
					  OsEquipamentoPersistePage(osEquipamento: OsEquipamento(), title: 'Os Equipamento - Inserindo', operacao: 'I')))
                  .then((_) {
                Provider.of<OsEquipamentoViewModel>(context).consultarLista();
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
                          title: 'Os Equipamento - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<OsEquipamentoViewModel>(context)
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
            child: listaOsEquipamento == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Os Equipamento'),
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
								numeric: true,
								label: const Text('Id'),
								tooltip: 'Id',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((OsEquipamento osEquipamento) => osEquipamento.id,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Nome'),
								tooltip: 'Nome',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((OsEquipamento osEquipamento) => osEquipamento.nome,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Descrição'),
								tooltip: 'Descrição',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((OsEquipamento osEquipamento) => osEquipamento.descricao,
									columnIndex, ascending),
							),
                        ],
                        source: _osEquipamentoDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future _refrescarTela() async {
    await Provider.of<OsEquipamentoViewModel>(context).consultarLista();
  }
}

/// codigo referente a fonte de dados
class OsEquipamentoDataSource extends DataTableSource {
  final List<OsEquipamento> listaOsEquipamento;
  final BuildContext context;

  OsEquipamentoDataSource(this.listaOsEquipamento, this.context);

  void _sort<T>(Comparable<T> getField(OsEquipamento osEquipamento), bool ascending) {
    listaOsEquipamento.sort((OsEquipamento a, OsEquipamento b) {
      if (!ascending) {
        final OsEquipamento c = a;
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
    if (index >= listaOsEquipamento.length) return null;
    final OsEquipamento osEquipamento = listaOsEquipamento[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
		DataCell(Text('${osEquipamento.id ?? ''}'), onTap: () {
			detalharOsEquipamento(osEquipamento, context);
		}),
		DataCell(Text('${osEquipamento.nome ?? ''}'), onTap: () {
			detalharOsEquipamento(osEquipamento, context);
		}),
		DataCell(Text('${osEquipamento.descricao ?? ''}'), onTap: () {
			detalharOsEquipamento(osEquipamento, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaOsEquipamento.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharOsEquipamento(OsEquipamento osEquipamento, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/osEquipamentoDetalhe',
    arguments: osEquipamento,
  );
}