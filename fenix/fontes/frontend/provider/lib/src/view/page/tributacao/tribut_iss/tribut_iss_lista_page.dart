/*
Title: T2Ti ERP Fenix                                                                
Description: ListaPage relacionada à tabela [TRIBUT_ISS] 
                                                                                
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
import 'tribut_iss_persiste_page.dart';

class TributIssListaPage extends StatefulWidget {
  @override
  _TributIssListaPageState createState() => _TributIssListaPageState();
}

class _TributIssListaPageState extends State<TributIssListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<TributIssViewModel>(context).listaTributIss == null && Provider.of<TributIssViewModel>(context).objetoJsonErro == null) {
      Provider.of<TributIssViewModel>(context).consultarLista();
    }
    var listaTributIss = Provider.of<TributIssViewModel>(context).listaTributIss;
    var colunas = TributIss.colunas;
    var campos = TributIss.campos;

    final TributIssDataSource _tributIssDataSource =
        TributIssDataSource(listaTributIss, context);

    void _sort<T>(Comparable<T> getField(TributIss tributIss), int columnIndex, bool ascending) {
      _tributIssDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<TributIssViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Tribut Iss'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<TributIssViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Tribut Iss'),
          actions: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) => 
					  TributIssPersistePage(tributIss: TributIss(), title: 'Tribut Iss - Inserindo', operacao: 'I')))
                  .then((_) {
                Provider.of<TributIssViewModel>(context).consultarLista();
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
                          title: 'Tribut Iss - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<TributIssViewModel>(context)
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
            child: listaTributIss == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Tribut Iss'),
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
									_sort<num>((TributIss tributIss) => tributIss.id,
										columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Id'),
								tooltip: 'Id',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((TributIss tributIss) => tributIss.id,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Operação Fiscal'),
								tooltip: 'Operação Fiscal',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((TributIss tributIss) => tributIss.tributOperacaoFiscal?.descricao,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Modalidade Base Cálculo'),
								tooltip: 'Modalidade Base Cálculo',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((TributIss tributIss) => tributIss.modalidadeBaseCalculo,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Porcento Base Cálculo'),
								tooltip: 'Porcento Base Cálculo',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((TributIss tributIss) => tributIss.porcentoBaseCalculo,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Alíquota Porcento'),
								tooltip: 'Alíquota Porcento',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((TributIss tributIss) => tributIss.aliquotaPorcento,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Alíquota Unidade'),
								tooltip: 'Alíquota Unidade',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((TributIss tributIss) => tributIss.aliquotaUnidade,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Valor Preço Máximo'),
								tooltip: 'Valor Preço Máximo',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((TributIss tributIss) => tributIss.valorPrecoMaximo,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Valor Pauta Fiscal'),
								tooltip: 'Valor Pauta Fiscal',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((TributIss tributIss) => tributIss.valorPautaFiscal,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Item Lista Serviço'),
								tooltip: 'Item Lista Serviço',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((TributIss tributIss) => tributIss.itemListaServico,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Código Tributação'),
								tooltip: 'Código Tributação',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((TributIss tributIss) => tributIss.codigoTributacao,
									columnIndex, ascending),
							),
                        ],
                        source: _tributIssDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future _refrescarTela() async {
    await Provider.of<TributIssViewModel>(context).consultarLista();
  }
}

/// codigo referente a fonte de dados
class TributIssDataSource extends DataTableSource {
  final List<TributIss> listaTributIss;
  final BuildContext context;

  TributIssDataSource(this.listaTributIss, this.context);

  void _sort<T>(Comparable<T> getField(TributIss tributIss), bool ascending) {
    listaTributIss.sort((TributIss a, TributIss b) {
      if (!ascending) {
        final TributIss c = a;
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
    if (index >= listaTributIss.length) return null;
    final TributIss tributIss = listaTributIss[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text('${ tributIss.id ?? ''}'), onTap: () {
          detalharTributIss(tributIss, context);
        }),
		DataCell(Text('${tributIss.id ?? ''}'), onTap: () {
			detalharTributIss(tributIss, context);
		}),
		DataCell(Text('${tributIss.tributOperacaoFiscal?.descricao ?? ''}'), onTap: () {
			detalharTributIss(tributIss, context);
		}),
		DataCell(Text('${tributIss.modalidadeBaseCalculo ?? ''}'), onTap: () {
			detalharTributIss(tributIss, context);
		}),
		DataCell(Text('${tributIss.porcentoBaseCalculo != null ? Constantes.formatoDecimalTaxa.format(tributIss.porcentoBaseCalculo) : 0.toStringAsFixed(Constantes.decimaisTaxa)}'), onTap: () {
			detalharTributIss(tributIss, context);
		}),
		DataCell(Text('${tributIss.aliquotaPorcento != null ? Constantes.formatoDecimalTaxa.format(tributIss.aliquotaPorcento) : 0.toStringAsFixed(Constantes.decimaisTaxa)}'), onTap: () {
			detalharTributIss(tributIss, context);
		}),
		DataCell(Text('${tributIss.aliquotaUnidade != null ? Constantes.formatoDecimalTaxa.format(tributIss.aliquotaUnidade) : 0.toStringAsFixed(Constantes.decimaisTaxa)}'), onTap: () {
			detalharTributIss(tributIss, context);
		}),
		DataCell(Text('${tributIss.valorPrecoMaximo != null ? Constantes.formatoDecimalValor.format(tributIss.valorPrecoMaximo) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharTributIss(tributIss, context);
		}),
		DataCell(Text('${tributIss.valorPautaFiscal != null ? Constantes.formatoDecimalValor.format(tributIss.valorPautaFiscal) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharTributIss(tributIss, context);
		}),
		DataCell(Text('${tributIss.itemListaServico ?? ''}'), onTap: () {
			detalharTributIss(tributIss, context);
		}),
		DataCell(Text('${tributIss.codigoTributacao ?? ''}'), onTap: () {
			detalharTributIss(tributIss, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaTributIss.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharTributIss(TributIss tributIss, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/tributIssDetalhe',
    arguments: tributIss,
  );
}