/*
Title: T2Ti ERP Fenix                                                                
Description: AbaMestre ListaPage relacionada à tabela [VENDA_ORCAMENTO_CABECALHO] 
                                                                                
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
import 'venda_orcamento_cabecalho_page.dart';

class VendaOrcamentoCabecalhoListaPage extends StatefulWidget {
  @override
  _VendaOrcamentoCabecalhoListaPageState createState() => _VendaOrcamentoCabecalhoListaPageState();
}

class _VendaOrcamentoCabecalhoListaPageState extends State<VendaOrcamentoCabecalhoListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<VendaOrcamentoCabecalhoViewModel>(context).listaVendaOrcamentoCabecalho == null && Provider.of<VendaOrcamentoCabecalhoViewModel>(context).objetoJsonErro == null) {
      Provider.of<VendaOrcamentoCabecalhoViewModel>(context).consultarLista();
    }     
    var vendaOrcamentoCabecalhoProvider = Provider.of<VendaOrcamentoCabecalhoViewModel>(context);
    var listaVendaOrcamentoCabecalho = vendaOrcamentoCabecalhoProvider.listaVendaOrcamentoCabecalho;
    var colunas = VendaOrcamentoCabecalho.colunas;
    var campos = VendaOrcamentoCabecalho.campos;

    final VendaOrcamentoCabecalhoDataSource _vendaOrcamentoCabecalhoDataSource =
        VendaOrcamentoCabecalhoDataSource(listaVendaOrcamentoCabecalho, context);

    void _sort<T>(Comparable<T> getField(VendaOrcamentoCabecalho vendaOrcamentoCabecalho), int columnIndex, bool ascending) {
      _vendaOrcamentoCabecalhoDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<VendaOrcamentoCabecalhoViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Venda Orcamento Cabecalho'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<VendaOrcamentoCabecalhoViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Venda Orcamento Cabecalho'),
          actions: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                      VendaOrcamentoCabecalhoPage(vendaOrcamentoCabecalho: VendaOrcamentoCabecalho(), title: 'Venda Orcamento Cabecalho - Inserindo', operacao: 'I')))
                  .then((_) {
                Provider.of<VendaOrcamentoCabecalhoViewModel>(context).consultarLista();
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
                          title: 'Venda Orcamento Cabecalho - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<VendaOrcamentoCabecalhoViewModel>(context)
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
            child: listaVendaOrcamentoCabecalho == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Venda Orcamento Cabecalho'),
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
                                  _sort<num>((VendaOrcamentoCabecalho vendaOrcamentoCabecalho) => vendaOrcamentoCabecalho.id,
                                      columnIndex, ascending),
                            ),
							DataColumn(
								label: const Text('Condição Pagamento'),
								tooltip: 'Condição Pagamento',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((VendaOrcamentoCabecalho vendaOrcamentoCabecalho) => vendaOrcamentoCabecalho.vendaCondicoesPagamento?.nome,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Vendedor'),
								tooltip: 'Vendedor',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((VendaOrcamentoCabecalho vendaOrcamentoCabecalho) => vendaOrcamentoCabecalho.vendedor?.colaborador?.pessoa?.nome,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Cliente'),
								tooltip: 'Cliente',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((VendaOrcamentoCabecalho vendaOrcamentoCabecalho) => vendaOrcamentoCabecalho.cliente?.pessoa?.nome,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Transportadora'),
								tooltip: 'Transportadora',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((VendaOrcamentoCabecalho vendaOrcamentoCabecalho) => vendaOrcamentoCabecalho.transportadora?.pessoa?.nome,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Código do Orçamento'),
								tooltip: 'Código do Orçamento',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((VendaOrcamentoCabecalho vendaOrcamentoCabecalho) => vendaOrcamentoCabecalho.codigo,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Data de Cadastro'),
								tooltip: 'Data de Cadastro',
								onSort: (int columnIndex, bool ascending) =>
									_sort<DateTime>((VendaOrcamentoCabecalho vendaOrcamentoCabecalho) => vendaOrcamentoCabecalho.dataCadastro,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Data de Entrega'),
								tooltip: 'Data de Entrega',
								onSort: (int columnIndex, bool ascending) =>
									_sort<DateTime>((VendaOrcamentoCabecalho vendaOrcamentoCabecalho) => vendaOrcamentoCabecalho.dataEntrega,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Data de Validade'),
								tooltip: 'Data de Validade',
								onSort: (int columnIndex, bool ascending) =>
									_sort<DateTime>((VendaOrcamentoCabecalho vendaOrcamentoCabecalho) => vendaOrcamentoCabecalho.validade,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Tipo do Frete'),
								tooltip: 'Tipo do Frete de Pessoa',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((VendaOrcamentoCabecalho vendaOrcamentoCabecalho) => vendaOrcamentoCabecalho.tipoFrete,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Valor Subtotal'),
								tooltip: 'Valor Subtotal',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((VendaOrcamentoCabecalho vendaOrcamentoCabecalho) => vendaOrcamentoCabecalho.valorSubtotal,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Valor Frete'),
								tooltip: 'Valor Frete',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((VendaOrcamentoCabecalho vendaOrcamentoCabecalho) => vendaOrcamentoCabecalho.valorFrete,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Taxa Comissão'),
								tooltip: 'Taxa Comissão',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((VendaOrcamentoCabecalho vendaOrcamentoCabecalho) => vendaOrcamentoCabecalho.taxaComissao,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Valor Comissão'),
								tooltip: 'Valor Comissão',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((VendaOrcamentoCabecalho vendaOrcamentoCabecalho) => vendaOrcamentoCabecalho.valorComissao,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Taxa Desconto'),
								tooltip: 'Taxa Desconto',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((VendaOrcamentoCabecalho vendaOrcamentoCabecalho) => vendaOrcamentoCabecalho.taxaDesconto,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Valor Desconto'),
								tooltip: 'Valor Desconto',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((VendaOrcamentoCabecalho vendaOrcamentoCabecalho) => vendaOrcamentoCabecalho.valorDesconto,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Valor Total'),
								tooltip: 'Valor Total',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((VendaOrcamentoCabecalho vendaOrcamentoCabecalho) => vendaOrcamentoCabecalho.valorTotal,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Observação'),
								tooltip: 'Observação',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((VendaOrcamentoCabecalho vendaOrcamentoCabecalho) => vendaOrcamentoCabecalho.observacao,
									columnIndex, ascending),
							),
                        ],
                        source: _vendaOrcamentoCabecalhoDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future _refrescarTela() async {
    await Provider.of<VendaOrcamentoCabecalhoViewModel>(context).consultarLista();
  }
}

/// codigo referente a fonte de dados
class VendaOrcamentoCabecalhoDataSource extends DataTableSource {
  final List<VendaOrcamentoCabecalho> listaVendaOrcamentoCabecalho;
  final BuildContext context;

  VendaOrcamentoCabecalhoDataSource(this.listaVendaOrcamentoCabecalho, this.context);

  void _sort<T>(Comparable<T> getField(VendaOrcamentoCabecalho vendaOrcamentoCabecalho), bool ascending) {
    listaVendaOrcamentoCabecalho.sort((VendaOrcamentoCabecalho a, VendaOrcamentoCabecalho b) {
      if (!ascending) {
        final VendaOrcamentoCabecalho c = a;
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
    if (index >= listaVendaOrcamentoCabecalho.length) return null;
    final VendaOrcamentoCabecalho vendaOrcamentoCabecalho = listaVendaOrcamentoCabecalho[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${ vendaOrcamentoCabecalho.id ?? ''}'), onTap: () {
          detalharVendaOrcamentoCabecalho(vendaOrcamentoCabecalho, context);
        }),
		DataCell(Text('${vendaOrcamentoCabecalho.vendaCondicoesPagamento?.nome ?? ''}'), onTap: () {
			detalharVendaOrcamentoCabecalho(vendaOrcamentoCabecalho, context);
		}),
		DataCell(Text('${vendaOrcamentoCabecalho.vendedor?.colaborador?.pessoa?.nome ?? ''}'), onTap: () {
			detalharVendaOrcamentoCabecalho(vendaOrcamentoCabecalho, context);
		}),
		DataCell(Text('${vendaOrcamentoCabecalho.cliente?.pessoa?.nome ?? ''}'), onTap: () {
			detalharVendaOrcamentoCabecalho(vendaOrcamentoCabecalho, context);
		}),
		DataCell(Text('${vendaOrcamentoCabecalho.transportadora?.pessoa?.nome ?? ''}'), onTap: () {
			detalharVendaOrcamentoCabecalho(vendaOrcamentoCabecalho, context);
		}),
		DataCell(Text('${vendaOrcamentoCabecalho.codigo ?? ''}'), onTap: () {
			detalharVendaOrcamentoCabecalho(vendaOrcamentoCabecalho, context);
		}),
		DataCell(Text('${vendaOrcamentoCabecalho.dataCadastro != null ? DateFormat('dd/MM/yyyy').format(vendaOrcamentoCabecalho.dataCadastro) : ''}'), onTap: () {
			detalharVendaOrcamentoCabecalho(vendaOrcamentoCabecalho, context);
		}),
		DataCell(Text('${vendaOrcamentoCabecalho.dataEntrega != null ? DateFormat('dd/MM/yyyy').format(vendaOrcamentoCabecalho.dataEntrega) : ''}'), onTap: () {
			detalharVendaOrcamentoCabecalho(vendaOrcamentoCabecalho, context);
		}),
		DataCell(Text('${vendaOrcamentoCabecalho.validade != null ? DateFormat('dd/MM/yyyy').format(vendaOrcamentoCabecalho.validade) : ''}'), onTap: () {
			detalharVendaOrcamentoCabecalho(vendaOrcamentoCabecalho, context);
		}),
		DataCell(Text('${vendaOrcamentoCabecalho.tipoFrete ?? ''}'), onTap: () {
			detalharVendaOrcamentoCabecalho(vendaOrcamentoCabecalho, context);
		}),
		DataCell(Text('${vendaOrcamentoCabecalho.valorSubtotal != null ? Constantes.formatoDecimalValor.format(vendaOrcamentoCabecalho.valorSubtotal) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharVendaOrcamentoCabecalho(vendaOrcamentoCabecalho, context);
		}),
		DataCell(Text('${vendaOrcamentoCabecalho.valorFrete != null ? Constantes.formatoDecimalValor.format(vendaOrcamentoCabecalho.valorFrete) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharVendaOrcamentoCabecalho(vendaOrcamentoCabecalho, context);
		}),
		DataCell(Text('${vendaOrcamentoCabecalho.taxaComissao != null ? Constantes.formatoDecimalTaxa.format(vendaOrcamentoCabecalho.taxaComissao) : 0.toStringAsFixed(Constantes.decimaisTaxa)}'), onTap: () {
			detalharVendaOrcamentoCabecalho(vendaOrcamentoCabecalho, context);
		}),
		DataCell(Text('${vendaOrcamentoCabecalho.valorComissao != null ? Constantes.formatoDecimalValor.format(vendaOrcamentoCabecalho.valorComissao) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharVendaOrcamentoCabecalho(vendaOrcamentoCabecalho, context);
		}),
		DataCell(Text('${vendaOrcamentoCabecalho.taxaDesconto != null ? Constantes.formatoDecimalTaxa.format(vendaOrcamentoCabecalho.taxaDesconto) : 0.toStringAsFixed(Constantes.decimaisTaxa)}'), onTap: () {
			detalharVendaOrcamentoCabecalho(vendaOrcamentoCabecalho, context);
		}),
		DataCell(Text('${vendaOrcamentoCabecalho.valorDesconto != null ? Constantes.formatoDecimalValor.format(vendaOrcamentoCabecalho.valorDesconto) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharVendaOrcamentoCabecalho(vendaOrcamentoCabecalho, context);
		}),
		DataCell(Text('${vendaOrcamentoCabecalho.valorTotal != null ? Constantes.formatoDecimalValor.format(vendaOrcamentoCabecalho.valorTotal) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharVendaOrcamentoCabecalho(vendaOrcamentoCabecalho, context);
		}),
		DataCell(Text('${vendaOrcamentoCabecalho.observacao ?? ''}'), onTap: () {
			detalharVendaOrcamentoCabecalho(vendaOrcamentoCabecalho, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaVendaOrcamentoCabecalho.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharVendaOrcamentoCabecalho(VendaOrcamentoCabecalho vendaOrcamentoCabecalho, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/vendaOrcamentoCabecalhoDetalhe',
    arguments: vendaOrcamentoCabecalho,
  );
}
