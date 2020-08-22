/*
Title: T2Ti ERP Fenix                                                                
Description: ListaPage relacionada à tabela [COMISSAO_PERFIL] 
                                                                                
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
import 'comissao_perfil_persiste_page.dart';

class ComissaoPerfilListaPage extends StatefulWidget {
  @override
  _ComissaoPerfilListaPageState createState() => _ComissaoPerfilListaPageState();
}

class _ComissaoPerfilListaPageState extends State<ComissaoPerfilListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<ComissaoPerfilViewModel>(context).listaComissaoPerfil == null && Provider.of<ComissaoPerfilViewModel>(context).objetoJsonErro == null) {
      Provider.of<ComissaoPerfilViewModel>(context).consultarLista();
    }
    var listaComissaoPerfil = Provider.of<ComissaoPerfilViewModel>(context).listaComissaoPerfil;
    var colunas = ComissaoPerfil.colunas;
    var campos = ComissaoPerfil.campos;

    final ComissaoPerfilDataSource _comissaoPerfilDataSource =
        ComissaoPerfilDataSource(listaComissaoPerfil, context);

    void _sort<T>(Comparable<T> getField(ComissaoPerfil comissaoPerfil), int columnIndex, bool ascending) {
      _comissaoPerfilDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<ComissaoPerfilViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Comissao Perfil'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<ComissaoPerfilViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Comissao Perfil'),
          actions: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) => 
					  ComissaoPerfilPersistePage(comissaoPerfil: ComissaoPerfil(), title: 'Comissao Perfil - Inserindo', operacao: 'I')))
                  .then((_) {
                Provider.of<ComissaoPerfilViewModel>(context).consultarLista();
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
                          title: 'Comissao Perfil - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<ComissaoPerfilViewModel>(context)
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
            child: listaComissaoPerfil == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Comissao Perfil'),
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
									_sort<num>((ComissaoPerfil comissaoPerfil) => comissaoPerfil.id,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Código'),
								tooltip: 'Código',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((ComissaoPerfil comissaoPerfil) => comissaoPerfil.codigo,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Nome'),
								tooltip: 'Nome',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((ComissaoPerfil comissaoPerfil) => comissaoPerfil.nome,
									columnIndex, ascending),
							),
                        ],
                        source: _comissaoPerfilDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future _refrescarTela() async {
    await Provider.of<ComissaoPerfilViewModel>(context).consultarLista();
  }
}

/// codigo referente a fonte de dados
class ComissaoPerfilDataSource extends DataTableSource {
  final List<ComissaoPerfil> listaComissaoPerfil;
  final BuildContext context;

  ComissaoPerfilDataSource(this.listaComissaoPerfil, this.context);

  void _sort<T>(Comparable<T> getField(ComissaoPerfil comissaoPerfil), bool ascending) {
    listaComissaoPerfil.sort((ComissaoPerfil a, ComissaoPerfil b) {
      if (!ascending) {
        final ComissaoPerfil c = a;
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
    if (index >= listaComissaoPerfil.length) return null;
    final ComissaoPerfil comissaoPerfil = listaComissaoPerfil[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
		DataCell(Text('${comissaoPerfil.id ?? ''}'), onTap: () {
			detalharComissaoPerfil(comissaoPerfil, context);
		}),
		DataCell(Text('${comissaoPerfil.codigo ?? ''}'), onTap: () {
			detalharComissaoPerfil(comissaoPerfil, context);
		}),
		DataCell(Text('${comissaoPerfil.nome ?? ''}'), onTap: () {
			detalharComissaoPerfil(comissaoPerfil, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaComissaoPerfil.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharComissaoPerfil(ComissaoPerfil comissaoPerfil, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/comissaoPerfilDetalhe',
    arguments: comissaoPerfil,
  );
}