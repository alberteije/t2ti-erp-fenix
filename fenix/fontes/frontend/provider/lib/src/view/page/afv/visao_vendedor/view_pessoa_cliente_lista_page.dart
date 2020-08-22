/*
Title: T2Ti ERP Fenix                                                                
Description: AbaMestre ListaPage relacionada à tabela [VIEW_PESSOA_CLIENTE] 
                                                                                
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
import 'package:intl/intl.dart';

class ViewPessoaClienteListaPage extends StatefulWidget {
  @override
  _ViewPessoaClienteListaPageState createState() => _ViewPessoaClienteListaPageState();
}

class _ViewPessoaClienteListaPageState extends State<ViewPessoaClienteListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<ViewPessoaClienteViewModel>(context).listaViewPessoaCliente == null && Provider.of<ViewPessoaClienteViewModel>(context).objetoJsonErro == null) {
      Provider.of<ViewPessoaClienteViewModel>(context).consultarLista();
    }     
    var viewPessoaClienteProvider = Provider.of<ViewPessoaClienteViewModel>(context);
    var listaViewPessoaCliente = viewPessoaClienteProvider.listaViewPessoaCliente;
    var colunas = ViewPessoaCliente.colunas;
    var campos = ViewPessoaCliente.campos;

    final ViewPessoaClienteDataSource _viewPessoaClienteDataSource =
        ViewPessoaClienteDataSource(listaViewPessoaCliente, context);

    void _sort<T>(Comparable<T> getField(ViewPessoaCliente viewPessoaCliente), int columnIndex, bool ascending) {
      _viewPessoaClienteDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<ViewPessoaClienteViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('AFV - Visão Vendedor'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<ViewPessoaClienteViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        // appBar: AppBar(
        //   title: const Text('AFV - Visão Vendedor'),
        //   actions: <Widget>[],
        // ),
        // floatingActionButton: FloatingActionButton(
        //     backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
        //     child: ViewUtilLib.getIconBotaoInserir(),
        //     onPressed: () {
        //       Navigator.of(context)
        //           .push(MaterialPageRoute(
        //               builder: (BuildContext context) =>
        //               ViewPessoaClientePage(viewPessoaCliente: ViewPessoaCliente(), title: 'View Pessoa Cliente - Inserindo', operacao: 'I')))
        //           .then((_) {
        //         Provider.of<ViewPessoaClienteViewModel>(context).consultarLista();
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
                          title: 'AFV - Visão Vendedor - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<ViewPessoaClienteViewModel>(context)
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
            child: listaViewPessoaCliente == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Clientes'),
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
									_sort<num>((ViewPessoaCliente viewPessoaCliente) => viewPessoaCliente.id,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Nome'),
								tooltip: 'Nome',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((ViewPessoaCliente viewPessoaCliente) => viewPessoaCliente.nome,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Tipo'),
								tooltip: 'Tipo',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((ViewPessoaCliente viewPessoaCliente) => viewPessoaCliente.tipo,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Email'),
								tooltip: 'Email',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((ViewPessoaCliente viewPessoaCliente) => viewPessoaCliente.email,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Site'),
								tooltip: 'Site',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((ViewPessoaCliente viewPessoaCliente) => viewPessoaCliente.site,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Cpf Cnpj'),
								tooltip: 'Cpf Cnpj',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((ViewPessoaCliente viewPessoaCliente) => viewPessoaCliente.cpfCnpj,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Rg Ie'),
								tooltip: 'Rg Ie',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((ViewPessoaCliente viewPessoaCliente) => viewPessoaCliente.rgIe,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Desde'),
								tooltip: 'Desde',
								onSort: (int columnIndex, bool ascending) =>
									_sort<DateTime>((ViewPessoaCliente viewPessoaCliente) => viewPessoaCliente.desde,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Taxa Desconto'),
								tooltip: 'Taxa Desconto',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((ViewPessoaCliente viewPessoaCliente) => viewPessoaCliente.taxaDesconto,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Limite Credito'),
								tooltip: 'Limite Credito',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((ViewPessoaCliente viewPessoaCliente) => viewPessoaCliente.limiteCredito,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Data Cadastro'),
								tooltip: 'Data Cadastro',
								onSort: (int columnIndex, bool ascending) =>
									_sort<DateTime>((ViewPessoaCliente viewPessoaCliente) => viewPessoaCliente.dataCadastro,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Observacao'),
								tooltip: 'Observacao',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((ViewPessoaCliente viewPessoaCliente) => viewPessoaCliente.observacao,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Id Pessoa'),
								tooltip: 'Id Pessoa',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((ViewPessoaCliente viewPessoaCliente) => viewPessoaCliente.idPessoa,
									columnIndex, ascending),
							),
                        ],
                        source: _viewPessoaClienteDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future _refrescarTela() async {
    await Provider.of<ViewPessoaClienteViewModel>(context).consultarLista();
  }
}

/// codigo referente a fonte de dados
class ViewPessoaClienteDataSource extends DataTableSource {
  final List<ViewPessoaCliente> listaViewPessoaCliente;
  final BuildContext context;

  ViewPessoaClienteDataSource(this.listaViewPessoaCliente, this.context);

  void _sort<T>(Comparable<T> getField(ViewPessoaCliente viewPessoaCliente), bool ascending) {
    listaViewPessoaCliente.sort((ViewPessoaCliente a, ViewPessoaCliente b) {
      if (!ascending) {
        final ViewPessoaCliente c = a;
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
    if (index >= listaViewPessoaCliente.length) return null;
    final ViewPessoaCliente viewPessoaCliente = listaViewPessoaCliente[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
		DataCell(Text('${viewPessoaCliente.id ?? ''}'), onTap: () {
			detalharViewPessoaCliente(viewPessoaCliente, context);
		}),
		DataCell(Text('${viewPessoaCliente.nome ?? ''}'), onTap: () {
			detalharViewPessoaCliente(viewPessoaCliente, context);
		}),
		DataCell(Text('${viewPessoaCliente.tipo ?? ''}'), onTap: () {
			detalharViewPessoaCliente(viewPessoaCliente, context);
		}),
		DataCell(Text('${viewPessoaCliente.email ?? ''}'), onTap: () {
			detalharViewPessoaCliente(viewPessoaCliente, context);
		}),
		DataCell(Text('${viewPessoaCliente.site ?? ''}'), onTap: () {
			detalharViewPessoaCliente(viewPessoaCliente, context);
		}),
		DataCell(Text('${viewPessoaCliente.cpfCnpj ?? ''}'), onTap: () {
			detalharViewPessoaCliente(viewPessoaCliente, context);
		}),
		DataCell(Text('${viewPessoaCliente.rgIe ?? ''}'), onTap: () {
			detalharViewPessoaCliente(viewPessoaCliente, context);
		}),
		DataCell(Text('${viewPessoaCliente.desde != null ? DateFormat('dd/MM/yyyy').format(viewPessoaCliente.desde) : ''}'), onTap: () {
			detalharViewPessoaCliente(viewPessoaCliente, context);
		}),
		DataCell(Text('${viewPessoaCliente.taxaDesconto != null ? Constantes.formatoDecimalValor.format(viewPessoaCliente.taxaDesconto) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharViewPessoaCliente(viewPessoaCliente, context);
		}),
		DataCell(Text('${viewPessoaCliente.limiteCredito != null ? Constantes.formatoDecimalValor.format(viewPessoaCliente.limiteCredito) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharViewPessoaCliente(viewPessoaCliente, context);
		}),
		DataCell(Text('${viewPessoaCliente.dataCadastro != null ? DateFormat('dd/MM/yyyy').format(viewPessoaCliente.dataCadastro) : ''}'), onTap: () {
			detalharViewPessoaCliente(viewPessoaCliente, context);
		}),
		DataCell(Text('${viewPessoaCliente.observacao ?? ''}'), onTap: () {
			detalharViewPessoaCliente(viewPessoaCliente, context);
		}),
		DataCell(Text('${viewPessoaCliente.idPessoa ?? ''}'), onTap: () {
			detalharViewPessoaCliente(viewPessoaCliente, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaViewPessoaCliente.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharViewPessoaCliente(ViewPessoaCliente viewPessoaCliente, BuildContext context) {
  ViewUtilLib.gerarDialogBoxInformacao(context, 'Exercício: Detalhe os dados do cliente', () {
    Navigator.of(context).pop();
  });      
}
