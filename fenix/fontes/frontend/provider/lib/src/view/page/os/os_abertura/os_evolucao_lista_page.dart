/*
Title: T2Ti ERP Fenix                                                                
Description: AbaDetalhe ListaPage relacionada à tabela [OS_EVOLUCAO] 
                                                                                
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

import 'package:fenix/src/model/model.dart';
import 'package:fenix/src/view/shared/view_util_lib.dart';
import 'package:intl/intl.dart';
import 'os_evolucao_detalhe_page.dart';
import 'os_evolucao_persiste_page.dart';

class OsEvolucaoListaPage extends StatefulWidget {
  final OsAbertura osAbertura;

  const OsEvolucaoListaPage({Key key, this.osAbertura}) : super(key: key);

  @override
  _OsEvolucaoListaPageState createState() => _OsEvolucaoListaPageState();
}

class _OsEvolucaoListaPageState extends State<OsEvolucaoListaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
          child: ViewUtilLib.getIconBotaoInserir(),
          onPressed: () {
            var osEvolucao = new OsEvolucao();
            widget.osAbertura.listaOsEvolucao.add(osEvolucao);
            Navigator.of(context)
                .push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        OsEvolucaoPersistePage(
                            osAbertura: widget.osAbertura,
                            osEvolucao: osEvolucao,
                            title: 'Os Evolucao - Inserindo',
                            operacao: 'I')))
                .then((_) {
              setState(() {
                if (osEvolucao.horaRegistro == null || osEvolucao.horaRegistro == "") { // se esse atributo estiver vazio, o objeto será removido
                  widget.osAbertura.listaOsEvolucao.remove(osEvolucao);
                }
                getRows();
              });
            });
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: Scrollbar(
        child: ListView(
          padding: const EdgeInsets.all(2.0),
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Card(
                color: Colors.white,
                elevation: 2.0,
                child: DataTable(columns: getColumns(), rows: getRows()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<DataColumn> getColumns() {
    List<DataColumn> lista = [];
	lista.add(DataColumn(numeric: true, label: Text('Id')));
	lista.add(DataColumn(label: Text('Data do Registro')));
	lista.add(DataColumn(label: Text('Hora do Registro')));
	lista.add(DataColumn(label: Text('Observação')));
	lista.add(DataColumn(label: Text('Enviar E-mail')));
    return lista;
  }

  List<DataRow> getRows() {
    if (widget.osAbertura.listaOsEvolucao == null) {
      widget.osAbertura.listaOsEvolucao = [];
    }
    List<DataRow> lista = [];
    for (var osEvolucao in widget.osAbertura.listaOsEvolucao) {
      List<DataCell> celulas = new List<DataCell>();

      celulas = [
        DataCell(Text('${ osEvolucao.id ?? ''}'), onTap: () {
          detalharOsEvolucao(widget.osAbertura, osEvolucao, context);
        }),
		DataCell(Text('${osEvolucao.dataRegistro != null ? DateFormat('dd/MM/yyyy').format(osEvolucao.dataRegistro) : ''}'), onTap: () {
			detalharOsEvolucao(widget.osAbertura, osEvolucao, context);
		}),
		DataCell(Text('${osEvolucao.horaRegistro ?? ''}'), onTap: () {
			detalharOsEvolucao(widget.osAbertura, osEvolucao, context);
		}),
		DataCell(Text('${osEvolucao.observacao ?? ''}'), onTap: () {
			detalharOsEvolucao(widget.osAbertura, osEvolucao, context);
		}),
		DataCell(Text('${osEvolucao.enviarEmail ?? ''}'), onTap: () {
			detalharOsEvolucao(widget.osAbertura, osEvolucao, context);
		}),
      ];

      lista.add(DataRow(cells: celulas));
    }
    return lista;
  }

  detalharOsEvolucao(
      OsAbertura osAbertura, OsEvolucao osEvolucao, BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (BuildContext context) => OsEvolucaoDetalhePage(
                  osAbertura: osAbertura,
                  osEvolucao: osEvolucao,
                ))).then((_) {
				  setState(() {
					getRows();
				  });
				});
  }
}