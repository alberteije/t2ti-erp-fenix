/*
Title: T2Ti ERP Fenix                                                                
Description: AbaMestre ListaPage relacionada à tabela [OS_ABERTURA] 
                                                                                
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
import 'package:intl/intl.dart';
import 'os_abertura_page.dart';

class OsAberturaListaPage extends StatefulWidget {
  @override
  _OsAberturaListaPageState createState() => _OsAberturaListaPageState();
}

class _OsAberturaListaPageState extends State<OsAberturaListaPage> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    if (Provider.of<OsAberturaViewModel>(context).listaOsAbertura == null && Provider.of<OsAberturaViewModel>(context).objetoJsonErro == null) {
      Provider.of<OsAberturaViewModel>(context).consultarLista();
    }     
    var osAberturaProvider = Provider.of<OsAberturaViewModel>(context);
    var listaOsAbertura = osAberturaProvider.listaOsAbertura;
    var colunas = OsAbertura.colunas;
    var campos = OsAbertura.campos;

    final OsAberturaDataSource _osAberturaDataSource =
        OsAberturaDataSource(listaOsAbertura, context);

    void _sort<T>(Comparable<T> getField(OsAbertura osAbertura), int columnIndex, bool ascending) {
      _osAberturaDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    if (Provider.of<OsAberturaViewModel>(context).objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Os Abertura'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<OsAberturaViewModel>(context).objetoJsonErro),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro - Os Abertura'),
          actions: <Widget>[],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
            child: ViewUtilLib.getIconBotaoInserir(),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                      OsAberturaPage(osAbertura: OsAbertura(), title: 'Os Abertura - Inserindo', operacao: 'I')))
                  .then((_) {
                Provider.of<OsAberturaViewModel>(context).consultarLista();
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
                          title: 'Os Abertura - Filtro',
                          colunas: colunas,
                          filtroPadrao: true,
                        ),
                        fullscreenDialog: true,
                      ));
                  if (filtro != null) {
                    if (filtro.campo != null) {
                      filtro.campo = campos[int.parse(filtro.campo)];
                      await Provider.of<OsAberturaViewModel>(context)
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
            child: listaOsAbertura == null
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.all(8.0),
                    children: <Widget>[
                      PaginatedDataTable(
                        header: const Text('Relação - Os Abertura'),
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
									_sort<num>((OsAbertura osAbertura) => osAbertura.id,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Status'),
								tooltip: 'Status',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((OsAbertura osAbertura) => osAbertura.osStatus?.nome,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Cliente'),
								tooltip: 'Cliente',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((OsAbertura osAbertura) => osAbertura.cliente?.pessoa?.nome,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Colaborador'),
								tooltip: 'Colaborador',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((OsAbertura osAbertura) => osAbertura.colaborador?.pessoa?.nome,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Número'),
								tooltip: 'Número',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((OsAbertura osAbertura) => osAbertura.numero,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Data Inicial'),
								tooltip: 'Data Inicial',
								onSort: (int columnIndex, bool ascending) =>
									_sort<DateTime>((OsAbertura osAbertura) => osAbertura.dataInicio,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Hora Inicial'),
								tooltip: 'Hora Inicial',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((OsAbertura osAbertura) => osAbertura.horaInicio,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Data Prevista'),
								tooltip: 'Data Prevista',
								onSort: (int columnIndex, bool ascending) =>
									_sort<DateTime>((OsAbertura osAbertura) => osAbertura.dataPrevisao,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Hora Prevista'),
								tooltip: 'Hora Prevista',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((OsAbertura osAbertura) => osAbertura.horaPrevisao,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Data Final'),
								tooltip: 'Data Final',
								onSort: (int columnIndex, bool ascending) =>
									_sort<DateTime>((OsAbertura osAbertura) => osAbertura.dataFim,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Hora Final'),
								tooltip: 'Hora Final',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((OsAbertura osAbertura) => osAbertura.horaFim,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Nome do Contato'),
								tooltip: 'Nome do Contato',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((OsAbertura osAbertura) => osAbertura.nomeContato,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Telefone do Contato'),
								tooltip: 'Telefone do Contato',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((OsAbertura osAbertura) => osAbertura.foneContato,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Observação Cliente'),
								tooltip: 'Observação Cliente',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((OsAbertura osAbertura) => osAbertura.observacaoCliente,
									columnIndex, ascending),
							),
							DataColumn(
								label: const Text('Observação Abertura'),
								tooltip: 'Observação Abertura',
								onSort: (int columnIndex, bool ascending) =>
									_sort<String>((OsAbertura osAbertura) => osAbertura.observacaoAbertura,
									columnIndex, ascending),
							),
                        ],
                        source: _osAberturaDataSource,
                      ),
                    ],
                  ),
          ),
        ),
      );
    }
  }

  Future _refrescarTela() async {
    await Provider.of<OsAberturaViewModel>(context).consultarLista();
  }
}

/// codigo referente a fonte de dados
class OsAberturaDataSource extends DataTableSource {
  final List<OsAbertura> listaOsAbertura;
  final BuildContext context;

  OsAberturaDataSource(this.listaOsAbertura, this.context);

  void _sort<T>(Comparable<T> getField(OsAbertura osAbertura), bool ascending) {
    listaOsAbertura.sort((OsAbertura a, OsAbertura b) {
      if (!ascending) {
        final OsAbertura c = a;
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
    if (index >= listaOsAbertura.length) return null;
    final OsAbertura osAbertura = listaOsAbertura[index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
		DataCell(Text('${osAbertura.id ?? ''}'), onTap: () {
			detalharOsAbertura(osAbertura, context);
		}),
		DataCell(Text('${osAbertura.osStatus?.nome ?? ''}'), onTap: () {
			detalharOsAbertura(osAbertura, context);
		}),
		DataCell(Text('${osAbertura.cliente?.pessoa?.nome ?? ''}'), onTap: () {
			detalharOsAbertura(osAbertura, context);
		}),
		DataCell(Text('${osAbertura.colaborador?.pessoa?.nome ?? ''}'), onTap: () {
			detalharOsAbertura(osAbertura, context);
		}),
		DataCell(Text('${osAbertura.numero ?? ''}'), onTap: () {
			detalharOsAbertura(osAbertura, context);
		}),
		DataCell(Text('${osAbertura.dataInicio != null ? DateFormat('dd/MM/yyyy').format(osAbertura.dataInicio) : ''}'), onTap: () {
			detalharOsAbertura(osAbertura, context);
		}),
		DataCell(Text('${osAbertura.horaInicio ?? ''}'), onTap: () {
			detalharOsAbertura(osAbertura, context);
		}),
		DataCell(Text('${osAbertura.dataPrevisao != null ? DateFormat('dd/MM/yyyy').format(osAbertura.dataPrevisao) : ''}'), onTap: () {
			detalharOsAbertura(osAbertura, context);
		}),
		DataCell(Text('${osAbertura.horaPrevisao ?? ''}'), onTap: () {
			detalharOsAbertura(osAbertura, context);
		}),
		DataCell(Text('${osAbertura.dataFim != null ? DateFormat('dd/MM/yyyy').format(osAbertura.dataFim) : ''}'), onTap: () {
			detalharOsAbertura(osAbertura, context);
		}),
		DataCell(Text('${osAbertura.horaFim ?? ''}'), onTap: () {
			detalharOsAbertura(osAbertura, context);
		}),
		DataCell(Text('${osAbertura.nomeContato ?? ''}'), onTap: () {
			detalharOsAbertura(osAbertura, context);
		}),
		DataCell(Text('${osAbertura.foneContato ?? ''}'), onTap: () {
			detalharOsAbertura(osAbertura, context);
		}),
		DataCell(Text('${osAbertura.observacaoCliente ?? ''}'), onTap: () {
			detalharOsAbertura(osAbertura, context);
		}),
		DataCell(Text('${osAbertura.observacaoAbertura ?? ''}'), onTap: () {
			detalharOsAbertura(osAbertura, context);
		}),
      ],
    );
  }

  @override
  int get rowCount => listaOsAbertura.length ?? 0;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

detalharOsAbertura(OsAbertura osAbertura, BuildContext context) {
  Navigator.pushNamed(
    context,
    '/osAberturaDetalhe',
    arguments: osAbertura,
  );
}
