/*
Title: T2Ti ERP Fenix                                                                
Description: AbaDetalhe ListaPage relacionada à tabela [OS_PRODUTO_SERVICO] 
                                                                                
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
import 'package:fenix/src/infra/constantes.dart';
import 'os_produto_servico_detalhe_page.dart';
import 'os_produto_servico_persiste_page.dart';

class OsProdutoServicoListaPage extends StatefulWidget {
  final OsAbertura osAbertura;

  const OsProdutoServicoListaPage({Key key, this.osAbertura}) : super(key: key);

  @override
  _OsProdutoServicoListaPageState createState() => _OsProdutoServicoListaPageState();
}

class _OsProdutoServicoListaPageState extends State<OsProdutoServicoListaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
          child: ViewUtilLib.getIconBotaoInserir(),
          onPressed: () {
            var osProdutoServico = new OsProdutoServico();
            widget.osAbertura.listaOsProdutoServico.add(osProdutoServico);
            Navigator.of(context)
                .push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        OsProdutoServicoPersistePage(
                            osAbertura: widget.osAbertura,
                            osProdutoServico: osProdutoServico,
                            title: 'Os Produto Servico - Inserindo',
                            operacao: 'I')))
                .then((_) {
              setState(() {
                if (osProdutoServico.idProduto == null) { // se esse atributo estiver vazio, o objeto será removido
                  widget.osAbertura.listaOsProdutoServico.remove(osProdutoServico);
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
	lista.add(DataColumn(label: Text('Produto')));
	lista.add(DataColumn(label: Text('Tipo')));
	lista.add(DataColumn(label: Text('Complemento')));
	lista.add(DataColumn(numeric: true, label: Text('Quantidade')));
	lista.add(DataColumn(numeric: true, label: Text('Valor Unitário')));
	lista.add(DataColumn(numeric: true, label: Text('Valor Subtotal')));
	lista.add(DataColumn(numeric: true, label: Text('Taxa Desconto')));
	lista.add(DataColumn(numeric: true, label: Text('Valor Desconto')));
	lista.add(DataColumn(numeric: true, label: Text('Valor Total')));
    return lista;
  }

  List<DataRow> getRows() {
    if (widget.osAbertura.listaOsProdutoServico == null) {
      widget.osAbertura.listaOsProdutoServico = [];
    }
    List<DataRow> lista = [];
    for (var osProdutoServico in widget.osAbertura.listaOsProdutoServico) {
      List<DataCell> celulas = new List<DataCell>();

      celulas = [
        DataCell(Text('${ osProdutoServico.id ?? ''}'), onTap: () {
          detalharOsProdutoServico(widget.osAbertura, osProdutoServico, context);
        }),
		DataCell(Text('${osProdutoServico.produto?.nome ?? ''}'), onTap: () {
			detalharOsProdutoServico(widget.osAbertura, osProdutoServico, context);
		}),
		DataCell(Text('${osProdutoServico.tipo ?? ''}'), onTap: () {
			detalharOsProdutoServico(widget.osAbertura, osProdutoServico, context);
		}),
		DataCell(Text('${osProdutoServico.complemento ?? ''}'), onTap: () {
			detalharOsProdutoServico(widget.osAbertura, osProdutoServico, context);
		}),
		DataCell(Text('${osProdutoServico.quantidade != null ? Constantes.formatoDecimalQuantidade.format(osProdutoServico.quantidade) : 0.toStringAsFixed(Constantes.decimaisQuantidade)}'), onTap: () {
			detalharOsProdutoServico(widget.osAbertura, osProdutoServico, context);
		}),
		DataCell(Text('${osProdutoServico.valorUnitario != null ? Constantes.formatoDecimalValor.format(osProdutoServico.valorUnitario) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharOsProdutoServico(widget.osAbertura, osProdutoServico, context);
		}),
		DataCell(Text('${osProdutoServico.valorSubtotal != null ? Constantes.formatoDecimalValor.format(osProdutoServico.valorSubtotal) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharOsProdutoServico(widget.osAbertura, osProdutoServico, context);
		}),
		DataCell(Text('${osProdutoServico.taxaDesconto != null ? Constantes.formatoDecimalTaxa.format(osProdutoServico.taxaDesconto) : 0.toStringAsFixed(Constantes.decimaisTaxa)}'), onTap: () {
			detalharOsProdutoServico(widget.osAbertura, osProdutoServico, context);
		}),
		DataCell(Text('${osProdutoServico.valorDesconto != null ? Constantes.formatoDecimalValor.format(osProdutoServico.valorDesconto) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharOsProdutoServico(widget.osAbertura, osProdutoServico, context);
		}),
		DataCell(Text('${osProdutoServico.valorTotal != null ? Constantes.formatoDecimalValor.format(osProdutoServico.valorTotal) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharOsProdutoServico(widget.osAbertura, osProdutoServico, context);
		}),
      ];

      lista.add(DataRow(cells: celulas));
    }
    return lista;
  }

  detalharOsProdutoServico(
      OsAbertura osAbertura, OsProdutoServico osProdutoServico, BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (BuildContext context) => OsProdutoServicoDetalhePage(
                  osAbertura: osAbertura,
                  osProdutoServico: osProdutoServico,
                ))).then((_) {
				  setState(() {
					getRows();
				  });
				});
  }
}