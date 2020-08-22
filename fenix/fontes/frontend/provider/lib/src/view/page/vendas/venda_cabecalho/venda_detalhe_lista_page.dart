/*
Title: T2Ti ERP Fenix                                                                
Description: AbaDetalhe ListaPage relacionada à tabela [VENDA_DETALHE] 
                                                                                
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
import 'package:fenix/src/infra/biblioteca.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:fenix/src/model/model.dart';
import 'package:fenix/src/view/shared/view_util_lib.dart';
import 'package:fenix/src/infra/constantes.dart';
import 'venda_detalhe_detalhe_page.dart';
import 'venda_detalhe_persiste_page.dart';

class VendaDetalheListaPage extends StatefulWidget {
  final VendaCabecalho vendaCabecalho;

  const VendaDetalheListaPage({Key key, this.vendaCabecalho}) : super(key: key);

  @override
  _VendaDetalheListaPageState createState() => _VendaDetalheListaPageState();
}

class _VendaDetalheListaPageState extends State<VendaDetalheListaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
          child: ViewUtilLib.getIconBotaoInserir(),
          onPressed: () {
            var vendaDetalhe = new VendaDetalhe();
            widget.vendaCabecalho.listaVendaDetalhe.add(vendaDetalhe);
            Navigator.of(context)
                .push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        VendaDetalhePersistePage(
                            vendaCabecalho: widget.vendaCabecalho,
                            vendaDetalhe: vendaDetalhe,
                            title: 'Venda Detalhe - Inserindo',
                            operacao: 'I')))
                .then((_) {
              setState(() {
                if (vendaDetalhe.quantidade == null || vendaDetalhe.quantidade.toString() == "") { // se esse atributo estiver vazio, o objeto será removido
                  widget.vendaCabecalho.listaVendaDetalhe.remove(vendaDetalhe);
                }
                getRows();
              });
            });
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

      bottomNavigationBar: BottomAppBar(
        color: ViewUtilLib.getBottomAppBarColor(),
        child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.monetization_on),
            onPressed: () {
              showModalBottomSheet<Null>(
                context: context,
                builder: (BuildContext context) => getTotaisDrawer(),
              );
            },
          ),
        ],
      )),

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

  Widget getTotaisDrawer() {
    return Drawer(      
      child: Column(
        children: <Widget>[
          getResumoTotais(),
        ],
      ),
    );
  }

  Widget getResumoTotais() {
    return Scrollbar(
    child: SingleChildScrollView(
      dragStartBehavior: DragStartBehavior.down,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Card(
        color: ViewUtilLib.getBackgroundColorBarraTelaDetalhe(),
        elevation: 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 10.0),
            Card(
              color: Colors.blue.shade100,
              elevation: 10,
              child: Container (
                padding: const EdgeInsets.all(8.0),
                height: 35,
                child: Text(
                'Subtotal: ' + Constantes.formatoDecimalValor.format(widget.vendaCabecalho.valorSubtotal),
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontFamily: Constantes.ralewayFont,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Card(
              color: Colors.blue.shade100,
              elevation: 10,
              child: Container (
                padding: const EdgeInsets.all(8.0),
                height: 35,
                child: Text(
                'Frete: ' + Constantes.formatoDecimalValor.format(widget.vendaCabecalho.valorFrete),
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontFamily: Constantes.ralewayFont,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Card(
              color: Colors.blue.shade100,
              elevation: 10,
              child: Container (
                padding: const EdgeInsets.all(8.0),
                height: 35,
                child: Text(
                'Seguro: ' + Constantes.formatoDecimalValor.format(widget.vendaCabecalho.valorSeguro),
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontFamily: Constantes.ralewayFont,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Card(
              color: Colors.red.shade100,
              elevation: 10,
              child: Container (
                padding: const EdgeInsets.all(8.0),
                height: 35,
                child: Text(
                'Desconto: ' + Constantes.formatoDecimalValor.format(widget.vendaCabecalho.valorDesconto),
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontFamily: Constantes.ralewayFont,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Card(
              color: Colors.green.shade100,
              elevation: 10,
              child: Container (
                padding: const EdgeInsets.all(8.0),
                height: 35,
                child: Text(
                'Total: ' + Constantes.formatoDecimalValor.format(widget.vendaCabecalho.valorTotal),
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontFamily: Constantes.ralewayFont,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
          ],),
        ),
      ),
    );    
  }  

  List<DataColumn> getColumns() {
    List<DataColumn> lista = [];
	lista.add(DataColumn(numeric: true, label: Text('Id')));
	lista.add(DataColumn(label: Text('Produto')));
	lista.add(DataColumn(numeric: true, label: Text('Quantidade')));
	lista.add(DataColumn(numeric: true, label: Text('Valor Unitário')));
	lista.add(DataColumn(numeric: true, label: Text('Valor Subtotal')));
	lista.add(DataColumn(numeric: true, label: Text('Taxa Desconto')));
	lista.add(DataColumn(numeric: true, label: Text('Valor Desconto')));
	lista.add(DataColumn(numeric: true, label: Text('Valor Total')));
    return lista;
  }

  List<DataRow> getRows() {
    if (widget.vendaCabecalho.listaVendaDetalhe == null) {
      widget.vendaCabecalho.listaVendaDetalhe = [];
    }
    List<DataRow> lista = [];
    for (var vendaDetalhe in widget.vendaCabecalho.listaVendaDetalhe) {
      List<DataCell> celulas = new List<DataCell>();

      celulas = [
        DataCell(Text('${ vendaDetalhe.id ?? ''}'), onTap: () {
          detalharVendaDetalhe(widget.vendaCabecalho, vendaDetalhe, context);
        }),
		DataCell(Text('${vendaDetalhe.produto?.nome ?? ''}'), onTap: () {
			detalharVendaDetalhe(widget.vendaCabecalho, vendaDetalhe, context);
		}),
		DataCell(Text('${vendaDetalhe.quantidade != null ? Constantes.formatoDecimalQuantidade.format(vendaDetalhe.quantidade) : 0.toStringAsFixed(Constantes.decimaisQuantidade)}'), onTap: () {
			detalharVendaDetalhe(widget.vendaCabecalho, vendaDetalhe, context);
		}),
		DataCell(Text('${vendaDetalhe.valorUnitario != null ? Constantes.formatoDecimalValor.format(vendaDetalhe.valorUnitario) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharVendaDetalhe(widget.vendaCabecalho, vendaDetalhe, context);
		}),
		DataCell(Text('${vendaDetalhe.valorSubtotal != null ? Constantes.formatoDecimalValor.format(vendaDetalhe.valorSubtotal) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharVendaDetalhe(widget.vendaCabecalho, vendaDetalhe, context);
		}),
		DataCell(Text('${vendaDetalhe.taxaDesconto != null ? Constantes.formatoDecimalTaxa.format(vendaDetalhe.taxaDesconto) : 0.toStringAsFixed(Constantes.decimaisTaxa)}'), onTap: () {
			detalharVendaDetalhe(widget.vendaCabecalho, vendaDetalhe, context);
		}),
		DataCell(Text('${vendaDetalhe.valorDesconto != null ? Constantes.formatoDecimalValor.format(vendaDetalhe.valorDesconto) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharVendaDetalhe(widget.vendaCabecalho, vendaDetalhe, context);
		}),
		DataCell(Text('${vendaDetalhe.valorTotal != null ? Constantes.formatoDecimalValor.format(vendaDetalhe.valorTotal) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharVendaDetalhe(widget.vendaCabecalho, vendaDetalhe, context);
		}),
      ];

      lista.add(DataRow(cells: celulas));
    }
    atualizarTotais();
    return lista;
  }

  detalharVendaDetalhe(
      VendaCabecalho vendaCabecalho, VendaDetalhe vendaDetalhe, BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (BuildContext context) => VendaDetalheDetalhePage(
                  vendaCabecalho: vendaCabecalho,
                  vendaDetalhe: vendaDetalhe,
                ))).then((_) {
				  setState(() {
					getRows();
				  });
				});
  }

  atualizarTotais() {
    setState(() {
      try {
        double subTotal = 0;        
        for (VendaDetalhe vendaDetalhe in widget.vendaCabecalho.listaVendaDetalhe) {
          subTotal = subTotal + vendaDetalhe.valorTotal;
        }     
        widget.vendaCabecalho.valorSubtotal = subTotal;
        widget.vendaCabecalho.valorDesconto = Biblioteca.calcularDesconto(widget.vendaCabecalho.valorSubtotal, widget.vendaCabecalho.taxaDesconto);
        widget.vendaCabecalho.valorComissao = Biblioteca.calcularComissao(widget.vendaCabecalho.valorSubtotal - widget.vendaCabecalho.valorDesconto, widget.vendaCabecalho.taxaComissao);
        widget.vendaCabecalho.valorTotal = widget.vendaCabecalho.valorSubtotal + 
                                            widget.vendaCabecalho.valorFrete + 
                                            widget.vendaCabecalho.valorSeguro - 
                                            widget.vendaCabecalho.valorDesconto;
      } catch (e) {
        print(e.toString());
      }
    });
  }
}