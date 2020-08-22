/*
Title: T2Ti ERP Fenix                                                                
Description: AbaMestre ListaPage relacionada à tabela [TRIBUT_ICMS_CUSTOM_CAB] 
                                                                                
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
import 'tribut_icms_custom_cab_page.dart';

class TributIcmsCustomCabListaPage extends StatefulWidget {
  @override
  _TributIcmsCustomCabListaPageState createState() => _TributIcmsCustomCabListaPageState();
}

class _TributIcmsCustomCabListaPageState extends State<TributIcmsCustomCabListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<TributIcmsCustomCabViewModel>(context).listaTributIcmsCustomCab == null && Provider.of<TributIcmsCustomCabViewModel>(context).objetoJsonErro == null) {
      Provider.of<TributIcmsCustomCabViewModel>(context).consultarLista();
    }     
    var tributIcmsCustomCabProvider = Provider.of<TributIcmsCustomCabViewModel>(context);
    var listaTributIcmsCustomCab = tributIcmsCustomCabProvider.listaTributIcmsCustomCab;
    var colunas = TributIcmsCustomCab.colunas;
    var campos = TributIcmsCustomCab.campos;

    final TributIcmsCustomCabDataSource _tributIcmsCustomCabDataSource =
        TributIcmsCustomCabDataSource(listaTributIcmsCustomCab, context);

    void _sort<T>(Comparable<T> getField(TributIcmsCustomCab tributIcmsCustomCab), int columnIndex, bool ascending) {
      _tributIcmsCustomCabDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<TributIcmsCustomCabViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Tribut Icms Custom Cab'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<TributIcmsCustomCabViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Tribut Icms Custom Cab'),
          actions: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                      TributIcmsCustomCabPage(tributIcmsCustomCab: TributIcmsCustomCab(), title: 'Tribut Icms Custom Cab - Inserindo', operacao: 'I')))
                  .then((_) {
                Provider.of<TributIcmsCustomCabViewModel>(context).consultarLista();
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
                          title: 'Tribut Icms Custom Cab - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<TributIcmsCustomCabViewModel>(context)
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
            child: listaTributIcmsCustomCab == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Tribut Icms Custom Cab'),
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
                                  _sort<num>((TributIcmsCustomCab tributIcmsCustomCab) => tributIcmsCustomCab.id,
                                      columnIndex, ascending),
                            ),
							DataColumn(
								label: const Text('Descrição'),
								tooltip: 'Descrição',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((TributIcmsCustomCab tributIcmsCustomCab) => tributIcmsCustomCab.descricao,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Origem da Mercadoria'),
								tooltip: 'Origem da Mercadoria',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((TributIcmsCustomCab tributIcmsCustomCab) => tributIcmsCustomCab.origemMercadoria,
									columnIndex, ascending),
							),
                        ],
                        source: _tributIcmsCustomCabDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future _refrescarTela() async {
    await Provider.of<TributIcmsCustomCabViewModel>(context).consultarLista();
  }
}

/// codigo referente a fonte de dados
class TributIcmsCustomCabDataSource extends DataTableSource {
  final List<TributIcmsCustomCab> listaTributIcmsCustomCab;
  final BuildContext context;

  TributIcmsCustomCabDataSource(this.listaTributIcmsCustomCab, this.context);

  void _sort<T>(Comparable<T> getField(TributIcmsCustomCab tributIcmsCustomCab), bool ascending) {
    listaTributIcmsCustomCab.sort((TributIcmsCustomCab a, TributIcmsCustomCab b) {
      if (!ascending) {
        final TributIcmsCustomCab c = a;
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
    if (index >= listaTributIcmsCustomCab.length) return null;
    final TributIcmsCustomCab tributIcmsCustomCab = listaTributIcmsCustomCab[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${ tributIcmsCustomCab.id ?? ''}'), onTap: () {
          detalharTributIcmsCustomCab(tributIcmsCustomCab, context);
        }),
		DataCell(Text('${tributIcmsCustomCab.descricao ?? ''}'), onTap: () {
			detalharTributIcmsCustomCab(tributIcmsCustomCab, context);
		}),
		DataCell(Text('${tributIcmsCustomCab.origemMercadoria ?? ''}'), onTap: () {
			detalharTributIcmsCustomCab(tributIcmsCustomCab, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaTributIcmsCustomCab.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharTributIcmsCustomCab(TributIcmsCustomCab tributIcmsCustomCab, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/tributIcmsCustomCabDetalhe',
    arguments: tributIcmsCustomCab,
  );
}
