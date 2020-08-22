/*
Title: T2Ti ERP Fenix                                                                
Description: AbaMestre ListaPage relacionada à tabela [VENDA_CABECALHO] 
                                                                                
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
import 'venda_cabecalho_page.dart';

class VendaCabecalhoListaPage extends StatefulWidget {
  @override
  _VendaCabecalhoListaPageState createState() => _VendaCabecalhoListaPageState();
}

class _VendaCabecalhoListaPageState extends State<VendaCabecalhoListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<VendaCabecalhoViewModel>(context).listaVendaCabecalho == null && Provider.of<VendaCabecalhoViewModel>(context).objetoJsonErro == null) {
      Provider.of<VendaCabecalhoViewModel>(context).consultarLista();
    }     
    var vendaCabecalhoProvider = Provider.of<VendaCabecalhoViewModel>(context);
    var listaVendaCabecalho = vendaCabecalhoProvider.listaVendaCabecalho;
    var colunas = VendaCabecalho.colunas;
    var campos = VendaCabecalho.campos;

    final VendaCabecalhoDataSource _vendaCabecalhoDataSource =
        VendaCabecalhoDataSource(listaVendaCabecalho, context);

    void _sort<T>(Comparable<T> getField(VendaCabecalho vendaCabecalho), int columnIndex, bool ascending) {
      _vendaCabecalhoDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<VendaCabecalhoViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Venda Cabecalho'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<VendaCabecalhoViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Venda Cabecalho'),
          actions: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                      VendaCabecalhoPage(vendaCabecalho: VendaCabecalho(), title: 'Venda Cabecalho - Inserindo', operacao: 'I')))
                  .then((_) {
                Provider.of<VendaCabecalhoViewModel>(context).consultarLista();
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
                          title: 'Venda Cabecalho - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<VendaCabecalhoViewModel>(context)
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
            child: listaVendaCabecalho == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Venda Cabecalho'),
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
                                  _sort<num>((VendaCabecalho vendaCabecalho) => vendaCabecalho.id,
                                      columnIndex, ascending),
                            ),
							DataColumn(
								label: const Text('Orçamento'),
								tooltip: 'Orçamento',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((VendaCabecalho vendaCabecalho) => vendaCabecalho.vendaOrcamentoCabecalho?.codigo,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Condição Pagamento'),
								tooltip: 'Condição Pagamento',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((VendaCabecalho vendaCabecalho) => vendaCabecalho.vendaCondicoesPagamento?.descricao,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Tipo Nota Fiscal'),
								tooltip: 'Tipo Nota Fiscal',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((VendaCabecalho vendaCabecalho) => vendaCabecalho.notaFiscalTipo?.nome,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Cliente'),
								tooltip: 'Cliente',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((VendaCabecalho vendaCabecalho) => vendaCabecalho.cliente?.pessoa?.nome,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Transportadora'),
								tooltip: 'Transportadora',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((VendaCabecalho vendaCabecalho) => vendaCabecalho.transportadora?.pessoa?.nome,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Vendedor'),
								tooltip: 'Vendedor',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((VendaCabecalho vendaCabecalho) => vendaCabecalho.vendedor?.colaborador?.pessoa?.nome,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Data da Venda'),
								tooltip: 'Data da Venda',
								onSort: (int columnIndex, bool ascending) =>
									_sort<DateTime>((VendaCabecalho vendaCabecalho) => vendaCabecalho.dataVenda,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Data da Saída'),
								tooltip: 'Data da Saída',
								onSort: (int columnIndex, bool ascending) =>
									_sort<DateTime>((VendaCabecalho vendaCabecalho) => vendaCabecalho.dataSaida,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Hora da Saída'),
								tooltip: 'Hora da Saída',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((VendaCabecalho vendaCabecalho) => vendaCabecalho.horaSaida,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Número da Fatura'),
								tooltip: 'Número da Fatura',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((VendaCabecalho vendaCabecalho) => vendaCabecalho.numeroFatura,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Local de Entrega'),
								tooltip: 'Local de Entrega',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((VendaCabecalho vendaCabecalho) => vendaCabecalho.localEntrega,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Local de Cobrança'),
								tooltip: 'Local de Cobrança',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((VendaCabecalho vendaCabecalho) => vendaCabecalho.localCobranca,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Valor Subtotal'),
								tooltip: 'Valor Subtotal',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((VendaCabecalho vendaCabecalho) => vendaCabecalho.valorSubtotal,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Taxa Comissão'),
								tooltip: 'Taxa Comissão',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((VendaCabecalho vendaCabecalho) => vendaCabecalho.taxaComissao,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Valor Comissão'),
								tooltip: 'Valor Comissão',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((VendaCabecalho vendaCabecalho) => vendaCabecalho.valorComissao,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Taxa Desconto'),
								tooltip: 'Taxa Desconto',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((VendaCabecalho vendaCabecalho) => vendaCabecalho.taxaDesconto,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Valor Desconto'),
								tooltip: 'Valor Desconto',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((VendaCabecalho vendaCabecalho) => vendaCabecalho.valorDesconto,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Valor Total'),
								tooltip: 'Valor Total',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((VendaCabecalho vendaCabecalho) => vendaCabecalho.valorTotal,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Tipo do Frete'),
								tooltip: 'Tipo do Frete',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((VendaCabecalho vendaCabecalho) => vendaCabecalho.tipoFrete,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Forma de Pagamento'),
								tooltip: 'Forma de Pagamento de Pessoa',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((VendaCabecalho vendaCabecalho) => vendaCabecalho.formaPagamento,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Valor Frete'),
								tooltip: 'Valor Frete',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((VendaCabecalho vendaCabecalho) => vendaCabecalho.valorFrete,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Valor Seguro'),
								tooltip: 'Valor Seguro',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((VendaCabecalho vendaCabecalho) => vendaCabecalho.valorSeguro,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Observação'),
								tooltip: 'Observação',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((VendaCabecalho vendaCabecalho) => vendaCabecalho.observacao,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Situação'),
								tooltip: 'Situação',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((VendaCabecalho vendaCabecalho) => vendaCabecalho.situacao,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Dia Fixo da Parcela'),
								tooltip: 'Dia Fixo da Parcela',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((VendaCabecalho vendaCabecalho) => vendaCabecalho.diaFixoParcela,
									columnIndex, ascending),
							),
                        ],
                        source: _vendaCabecalhoDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future _refrescarTela() async {
    await Provider.of<VendaCabecalhoViewModel>(context).consultarLista();
  }
}

/// codigo referente a fonte de dados
class VendaCabecalhoDataSource extends DataTableSource {
  final List<VendaCabecalho> listaVendaCabecalho;
  final BuildContext context;

  VendaCabecalhoDataSource(this.listaVendaCabecalho, this.context);

  void _sort<T>(Comparable<T> getField(VendaCabecalho vendaCabecalho), bool ascending) {
    listaVendaCabecalho.sort((VendaCabecalho a, VendaCabecalho b) {
      if (!ascending) {
        final VendaCabecalho c = a;
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
    if (index >= listaVendaCabecalho.length) return null;
    final VendaCabecalho vendaCabecalho = listaVendaCabecalho[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${ vendaCabecalho.id ?? ''}'), onTap: () {
          detalharVendaCabecalho(vendaCabecalho, context);
        }),
		DataCell(Text('${vendaCabecalho.vendaOrcamentoCabecalho?.codigo ?? ''}'), onTap: () {
			detalharVendaCabecalho(vendaCabecalho, context);
		}),
		DataCell(Text('${vendaCabecalho.vendaCondicoesPagamento?.descricao ?? ''}'), onTap: () {
			detalharVendaCabecalho(vendaCabecalho, context);
		}),
		DataCell(Text('${vendaCabecalho.notaFiscalTipo?.nome ?? ''}'), onTap: () {
			detalharVendaCabecalho(vendaCabecalho, context);
		}),
		DataCell(Text('${vendaCabecalho.cliente?.pessoa?.nome ?? ''}'), onTap: () {
			detalharVendaCabecalho(vendaCabecalho, context);
		}),
		DataCell(Text('${vendaCabecalho.transportadora?.pessoa?.nome ?? ''}'), onTap: () {
			detalharVendaCabecalho(vendaCabecalho, context);
		}),
		DataCell(Text('${vendaCabecalho.vendedor?.colaborador?.pessoa?.nome ?? ''}'), onTap: () {
			detalharVendaCabecalho(vendaCabecalho, context);
		}),
		DataCell(Text('${vendaCabecalho.dataVenda != null ? DateFormat('dd/MM/yyyy').format(vendaCabecalho.dataVenda) : ''}'), onTap: () {
			detalharVendaCabecalho(vendaCabecalho, context);
		}),
		DataCell(Text('${vendaCabecalho.dataSaida != null ? DateFormat('dd/MM/yyyy').format(vendaCabecalho.dataSaida) : ''}'), onTap: () {
			detalharVendaCabecalho(vendaCabecalho, context);
		}),
		DataCell(Text('${vendaCabecalho.horaSaida ?? ''}'), onTap: () {
			detalharVendaCabecalho(vendaCabecalho, context);
		}),
		DataCell(Text('${vendaCabecalho.numeroFatura ?? ''}'), onTap: () {
			detalharVendaCabecalho(vendaCabecalho, context);
		}),
		DataCell(Text('${vendaCabecalho.localEntrega ?? ''}'), onTap: () {
			detalharVendaCabecalho(vendaCabecalho, context);
		}),
		DataCell(Text('${vendaCabecalho.localCobranca ?? ''}'), onTap: () {
			detalharVendaCabecalho(vendaCabecalho, context);
		}),
		DataCell(Text('${vendaCabecalho.valorSubtotal != null ? Constantes.formatoDecimalValor.format(vendaCabecalho.valorSubtotal) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharVendaCabecalho(vendaCabecalho, context);
		}),
		DataCell(Text('${vendaCabecalho.taxaComissao != null ? Constantes.formatoDecimalTaxa.format(vendaCabecalho.taxaComissao) : 0.toStringAsFixed(Constantes.decimaisTaxa)}'), onTap: () {
			detalharVendaCabecalho(vendaCabecalho, context);
		}),
		DataCell(Text('${vendaCabecalho.valorComissao != null ? Constantes.formatoDecimalValor.format(vendaCabecalho.valorComissao) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharVendaCabecalho(vendaCabecalho, context);
		}),
		DataCell(Text('${vendaCabecalho.taxaDesconto != null ? Constantes.formatoDecimalTaxa.format(vendaCabecalho.taxaDesconto) : 0.toStringAsFixed(Constantes.decimaisTaxa)}'), onTap: () {
			detalharVendaCabecalho(vendaCabecalho, context);
		}),
		DataCell(Text('${vendaCabecalho.valorDesconto != null ? Constantes.formatoDecimalValor.format(vendaCabecalho.valorDesconto) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharVendaCabecalho(vendaCabecalho, context);
		}),
		DataCell(Text('${vendaCabecalho.valorTotal != null ? Constantes.formatoDecimalValor.format(vendaCabecalho.valorTotal) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharVendaCabecalho(vendaCabecalho, context);
		}),
		DataCell(Text('${vendaCabecalho.tipoFrete ?? ''}'), onTap: () {
			detalharVendaCabecalho(vendaCabecalho, context);
		}),
		DataCell(Text('${vendaCabecalho.formaPagamento ?? ''}'), onTap: () {
			detalharVendaCabecalho(vendaCabecalho, context);
		}),
		DataCell(Text('${vendaCabecalho.valorFrete != null ? Constantes.formatoDecimalValor.format(vendaCabecalho.valorFrete) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharVendaCabecalho(vendaCabecalho, context);
		}),
		DataCell(Text('${vendaCabecalho.valorSeguro != null ? Constantes.formatoDecimalValor.format(vendaCabecalho.valorSeguro) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharVendaCabecalho(vendaCabecalho, context);
		}),
		DataCell(Text('${vendaCabecalho.observacao ?? ''}'), onTap: () {
			detalharVendaCabecalho(vendaCabecalho, context);
		}),
		DataCell(Text('${vendaCabecalho.situacao ?? ''}'), onTap: () {
			detalharVendaCabecalho(vendaCabecalho, context);
		}),
		DataCell(Text('${vendaCabecalho.diaFixoParcela ?? ''}'), onTap: () {
			detalharVendaCabecalho(vendaCabecalho, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaVendaCabecalho.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharVendaCabecalho(VendaCabecalho vendaCabecalho, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/vendaCabecalhoDetalhe',
    arguments: vendaCabecalho,
  );
}
