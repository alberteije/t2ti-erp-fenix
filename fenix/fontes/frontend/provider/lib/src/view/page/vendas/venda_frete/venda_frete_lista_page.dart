/*
Title: T2Ti ERP Fenix                                                                
Description: ListaPage relacionada à tabela [VENDA_FRETE] 
                                                                                
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
import 'venda_frete_persiste_page.dart';

class VendaFreteListaPage extends StatefulWidget {
  @override
  _VendaFreteListaPageState createState() => _VendaFreteListaPageState();
}

class _VendaFreteListaPageState extends State<VendaFreteListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<VendaFreteViewModel>(context).listaVendaFrete == null && Provider.of<VendaFreteViewModel>(context).objetoJsonErro == null) {
      Provider.of<VendaFreteViewModel>(context).consultarLista();
    }
    var listaVendaFrete = Provider.of<VendaFreteViewModel>(context).listaVendaFrete;
    var colunas = VendaFrete.colunas;
    var campos = VendaFrete.campos;

    final VendaFreteDataSource _vendaFreteDataSource =
        VendaFreteDataSource(listaVendaFrete, context);

    void _sort<T>(Comparable<T> getField(VendaFrete vendaFrete), int columnIndex, bool ascending) {
      _vendaFreteDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<VendaFreteViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Venda Frete'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<VendaFreteViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Venda Frete'),
          actions: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) => 
					  VendaFretePersistePage(vendaFrete: VendaFrete(), title: 'Venda Frete - Inserindo', operacao: 'I')))
                  .then((_) {
                Provider.of<VendaFreteViewModel>(context).consultarLista();
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
                          title: 'Venda Frete - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<VendaFreteViewModel>(context)
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
            child: listaVendaFrete == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Venda Frete'),
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
									_sort<num>((VendaFrete vendaFrete) => vendaFrete.id,
										columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Id'),
								tooltip: 'Id',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((VendaFrete vendaFrete) => vendaFrete.id,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Venda'),
								tooltip: 'Venda',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((VendaFrete vendaFrete) => vendaFrete.vendaCabecalho?.id,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Transportadora'),
								tooltip: 'Transportadora',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((VendaFrete vendaFrete) => vendaFrete.transportadora?.pessoa?.nome,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Conhecimento'),
								tooltip: 'Conhecimento',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((VendaFrete vendaFrete) => vendaFrete.conhecimento,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Responsável'),
								tooltip: 'Responsável',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((VendaFrete vendaFrete) => vendaFrete.responsavel,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Placa'),
								tooltip: 'Placa',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((VendaFrete vendaFrete) => vendaFrete.placa,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('UF'),
								tooltip: 'UF',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((VendaFrete vendaFrete) => vendaFrete.ufPlaca,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Selo Fiscal'),
								tooltip: 'Selo Fiscal',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((VendaFrete vendaFrete) => vendaFrete.seloFiscal,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Quantidade de Volumes'),
								tooltip: 'Quantidade de Volumes',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((VendaFrete vendaFrete) => vendaFrete.quantidadeVolume,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Marca Volume'),
								tooltip: 'Marca Volume',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((VendaFrete vendaFrete) => vendaFrete.marcaVolume,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Espécie do Volume'),
								tooltip: 'Espécie do Volume',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((VendaFrete vendaFrete) => vendaFrete.especieVolume,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Peso Bruto'),
								tooltip: 'Peso Bruto',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((VendaFrete vendaFrete) => vendaFrete.pesoBruto,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Peso Líquido'),
								tooltip: 'Peso Líquido',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((VendaFrete vendaFrete) => vendaFrete.pesoLiquido,
									columnIndex, ascending),
							),
                        ],
                        source: _vendaFreteDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future _refrescarTela() async {
    await Provider.of<VendaFreteViewModel>(context).consultarLista();
  }
}

/// codigo referente a fonte de dados
class VendaFreteDataSource extends DataTableSource {
  final List<VendaFrete> listaVendaFrete;
  final BuildContext context;

  VendaFreteDataSource(this.listaVendaFrete, this.context);

  void _sort<T>(Comparable<T> getField(VendaFrete vendaFrete), bool ascending) {
    listaVendaFrete.sort((VendaFrete a, VendaFrete b) {
      if (!ascending) {
        final VendaFrete c = a;
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
    if (index >= listaVendaFrete.length) return null;
    final VendaFrete vendaFrete = listaVendaFrete[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${ vendaFrete.id ?? ''}'), onTap: () {
          detalharVendaFrete(vendaFrete, context);
        }),
		DataCell(Text('${vendaFrete.id ?? ''}'), onTap: () {
			detalharVendaFrete(vendaFrete, context);
		}),
		DataCell(Text('${vendaFrete.vendaCabecalho?.id ?? ''}'), onTap: () {
			detalharVendaFrete(vendaFrete, context);
		}),
		DataCell(Text('${vendaFrete.transportadora?.pessoa?.nome ?? ''}'), onTap: () {
			detalharVendaFrete(vendaFrete, context);
		}),
		DataCell(Text('${vendaFrete.conhecimento ?? ''}'), onTap: () {
			detalharVendaFrete(vendaFrete, context);
		}),
		DataCell(Text('${vendaFrete.responsavel ?? ''}'), onTap: () {
			detalharVendaFrete(vendaFrete, context);
		}),
		DataCell(Text('${vendaFrete.placa ?? ''}'), onTap: () {
			detalharVendaFrete(vendaFrete, context);
		}),
		DataCell(Text('${vendaFrete.ufPlaca ?? ''}'), onTap: () {
			detalharVendaFrete(vendaFrete, context);
		}),
		DataCell(Text('${vendaFrete.seloFiscal ?? ''}'), onTap: () {
			detalharVendaFrete(vendaFrete, context);
		}),
		DataCell(Text('${vendaFrete.quantidadeVolume != null ? Constantes.formatoDecimalQuantidade.format(vendaFrete.quantidadeVolume) : 0.toStringAsFixed(Constantes.decimaisQuantidade)}'), onTap: () {
			detalharVendaFrete(vendaFrete, context);
		}),
		DataCell(Text('${vendaFrete.marcaVolume ?? ''}'), onTap: () {
			detalharVendaFrete(vendaFrete, context);
		}),
		DataCell(Text('${vendaFrete.especieVolume ?? ''}'), onTap: () {
			detalharVendaFrete(vendaFrete, context);
		}),
		DataCell(Text('${vendaFrete.pesoBruto != null ? Constantes.formatoDecimalQuantidade.format(vendaFrete.pesoBruto) : 0.toStringAsFixed(Constantes.decimaisQuantidade)}'), onTap: () {
			detalharVendaFrete(vendaFrete, context);
		}),
		DataCell(Text('${vendaFrete.pesoLiquido != null ? Constantes.formatoDecimalQuantidade.format(vendaFrete.pesoLiquido) : 0.toStringAsFixed(Constantes.decimaisQuantidade)}'), onTap: () {
			detalharVendaFrete(vendaFrete, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaVendaFrete.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharVendaFrete(VendaFrete vendaFrete, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/vendaFreteDetalhe',
    arguments: vendaFrete,
  );
}