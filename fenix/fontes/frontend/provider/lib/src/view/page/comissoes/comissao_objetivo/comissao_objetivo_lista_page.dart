/*
Title: T2Ti ERP Fenix                                                                
Description: ListaPage relacionada à tabela [COMISSAO_OBJETIVO] 
                                                                                
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
import 'comissao_objetivo_persiste_page.dart';

class ComissaoObjetivoListaPage extends StatefulWidget {
  @override
  _ComissaoObjetivoListaPageState createState() => _ComissaoObjetivoListaPageState();
}

class _ComissaoObjetivoListaPageState extends State<ComissaoObjetivoListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<ComissaoObjetivoViewModel>(context).listaComissaoObjetivo == null && Provider.of<ComissaoObjetivoViewModel>(context).objetoJsonErro == null) {
      Provider.of<ComissaoObjetivoViewModel>(context).consultarLista();
    }
    var listaComissaoObjetivo = Provider.of<ComissaoObjetivoViewModel>(context).listaComissaoObjetivo;
    var colunas = ComissaoObjetivo.colunas;
    var campos = ComissaoObjetivo.campos;

    final ComissaoObjetivoDataSource _comissaoObjetivoDataSource =
        ComissaoObjetivoDataSource(listaComissaoObjetivo, context);

    void _sort<T>(Comparable<T> getField(ComissaoObjetivo comissaoObjetivo), int columnIndex, bool ascending) {
      _comissaoObjetivoDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<ComissaoObjetivoViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Comissao Objetivo'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<ComissaoObjetivoViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Comissao Objetivo'),
          actions: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) => 
					  ComissaoObjetivoPersistePage(comissaoObjetivo: ComissaoObjetivo(), title: 'Comissao Objetivo - Inserindo', operacao: 'I')))
                  .then((_) {
                Provider.of<ComissaoObjetivoViewModel>(context).consultarLista();
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
                          title: 'Comissao Objetivo - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<ComissaoObjetivoViewModel>(context)
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
            child: listaComissaoObjetivo == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Comissao Objetivo'),
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
									_sort<num>((ComissaoObjetivo comissaoObjetivo) => comissaoObjetivo.id,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text(''),
								tooltip: '',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((ComissaoObjetivo comissaoObjetivo) => comissaoObjetivo.idComissaoPerfil,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Produto'),
								tooltip: 'Produto',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((ComissaoObjetivo comissaoObjetivo) => comissaoObjetivo.produto?.nome,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Código'),
								tooltip: 'Código',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((ComissaoObjetivo comissaoObjetivo) => comissaoObjetivo.codigo,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Nome'),
								tooltip: 'Nome',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((ComissaoObjetivo comissaoObjetivo) => comissaoObjetivo.nome,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Descrição'),
								tooltip: 'Descrição',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((ComissaoObjetivo comissaoObjetivo) => comissaoObjetivo.descricao,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Forma de Pagamento'),
								tooltip: 'Forma de Pagamento',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((ComissaoObjetivo comissaoObjetivo) => comissaoObjetivo.formaPagamento,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Taxa Pagamento'),
								tooltip: 'Taxa Pagamento',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((ComissaoObjetivo comissaoObjetivo) => comissaoObjetivo.taxaPagamento,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Valor Pagamento'),
								tooltip: 'Valor Pagamento',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((ComissaoObjetivo comissaoObjetivo) => comissaoObjetivo.valorPagamento,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Valor Meta'),
								tooltip: 'Valor Meta',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((ComissaoObjetivo comissaoObjetivo) => comissaoObjetivo.valorMeta,
									columnIndex, ascending),
							),
							DataColumn(
								numeric: true,
								label: const Text('Quantidade'),
								tooltip: 'Quantidade',
								onSort: (int columnIndex, bool ascending) =>
									_sort<num>((ComissaoObjetivo comissaoObjetivo) => comissaoObjetivo.quantidade,
									columnIndex, ascending),
							),
                        ],
                        source: _comissaoObjetivoDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future _refrescarTela() async {
    await Provider.of<ComissaoObjetivoViewModel>(context).consultarLista();
  }
}

/// codigo referente a fonte de dados
class ComissaoObjetivoDataSource extends DataTableSource {
  final List<ComissaoObjetivo> listaComissaoObjetivo;
  final BuildContext context;

  ComissaoObjetivoDataSource(this.listaComissaoObjetivo, this.context);

  void _sort<T>(Comparable<T> getField(ComissaoObjetivo comissaoObjetivo), bool ascending) {
    listaComissaoObjetivo.sort((ComissaoObjetivo a, ComissaoObjetivo b) {
      if (!ascending) {
        final ComissaoObjetivo c = a;
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
    if (index >= listaComissaoObjetivo.length) return null;
    final ComissaoObjetivo comissaoObjetivo = listaComissaoObjetivo[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
		DataCell(Text('${comissaoObjetivo.id ?? ''}'), onTap: () {
			detalharComissaoObjetivo(comissaoObjetivo, context);
		}),
		DataCell(Text('${comissaoObjetivo.idComissaoPerfil ?? ''}'), onTap: () {
			detalharComissaoObjetivo(comissaoObjetivo, context);
		}),
		DataCell(Text('${comissaoObjetivo.produto?.nome ?? ''}'), onTap: () {
			detalharComissaoObjetivo(comissaoObjetivo, context);
		}),
		DataCell(Text('${comissaoObjetivo.codigo ?? ''}'), onTap: () {
			detalharComissaoObjetivo(comissaoObjetivo, context);
		}),
		DataCell(Text('${comissaoObjetivo.nome ?? ''}'), onTap: () {
			detalharComissaoObjetivo(comissaoObjetivo, context);
		}),
		DataCell(Text('${comissaoObjetivo.descricao ?? ''}'), onTap: () {
			detalharComissaoObjetivo(comissaoObjetivo, context);
		}),
		DataCell(Text('${comissaoObjetivo.formaPagamento ?? ''}'), onTap: () {
			detalharComissaoObjetivo(comissaoObjetivo, context);
		}),
		DataCell(Text('${comissaoObjetivo.taxaPagamento != null ? Constantes.formatoDecimalTaxa.format(comissaoObjetivo.taxaPagamento) : 0.toStringAsFixed(Constantes.decimaisTaxa)}'), onTap: () {
			detalharComissaoObjetivo(comissaoObjetivo, context);
		}),
		DataCell(Text('${comissaoObjetivo.valorPagamento != null ? Constantes.formatoDecimalValor.format(comissaoObjetivo.valorPagamento) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharComissaoObjetivo(comissaoObjetivo, context);
		}),
		DataCell(Text('${comissaoObjetivo.valorMeta != null ? Constantes.formatoDecimalValor.format(comissaoObjetivo.valorMeta) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharComissaoObjetivo(comissaoObjetivo, context);
		}),
		DataCell(Text('${comissaoObjetivo.quantidade != null ? Constantes.formatoDecimalQuantidade.format(comissaoObjetivo.quantidade) : 0.toStringAsFixed(Constantes.decimaisQuantidade)}'), onTap: () {
			detalharComissaoObjetivo(comissaoObjetivo, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaComissaoObjetivo.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharComissaoObjetivo(ComissaoObjetivo comissaoObjetivo, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/comissaoObjetivoDetalhe',
    arguments: comissaoObjetivo,
  );
}