/*
Title: T2Ti ERP Fenix                                                                
Description: AbaDetalhe ListaPage relacionada à tabela [VENDA_ORCAMENTO_DETALHE] 
                                                                                
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
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:fenix/src/infra/biblioteca.dart';
import 'package:fenix/src/model/model.dart';
import 'package:fenix/src/view/shared/view_util_lib.dart';
import 'package:fenix/src/infra/constantes.dart';
import 'venda_orcamento_detalhe_detalhe_page.dart';
import 'venda_orcamento_detalhe_persiste_page.dart';

class VendaOrcamentoDetalheListaPage extends StatefulWidget {
  final VendaOrcamentoCabecalho vendaOrcamentoCabecalho;

  const VendaOrcamentoDetalheListaPage({Key key, this.vendaOrcamentoCabecalho}) : super(key: key);

  @override
  _VendaOrcamentoDetalheListaPageState createState() => _VendaOrcamentoDetalheListaPageState();
}

class _VendaOrcamentoDetalheListaPageState extends State<VendaOrcamentoDetalheListaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
          child: ViewUtilLib.getIconBotaoInserir(),
          onPressed: () {
            var vendaOrcamentoDetalhe = new VendaOrcamentoDetalhe();
            widget.vendaOrcamentoCabecalho.listaVendaOrcamentoDetalhe.add(vendaOrcamentoDetalhe);
            Navigator.of(context)
                .push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        VendaOrcamentoDetalhePersistePage(
                            vendaOrcamentoCabecalho: widget.vendaOrcamentoCabecalho,
                            vendaOrcamentoDetalhe: vendaOrcamentoDetalhe,
                            title: 'Venda Orcamento Detalhe - Inserindo',
                            operacao: 'I')))
                .then((_) {
              setState(() {
                if (vendaOrcamentoDetalhe.quantidade == null || vendaOrcamentoDetalhe.quantidade.toString() == "") { // se esse atributo estiver vazio, o objeto será removido
                  widget.vendaOrcamentoCabecalho.listaVendaOrcamentoDetalhe.remove(vendaOrcamentoDetalhe);
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
                'Subtotal: ' + Constantes.formatoDecimalValor.format(widget.vendaOrcamentoCabecalho.valorSubtotal),
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
                'Frete: ' + Constantes.formatoDecimalValor.format(widget.vendaOrcamentoCabecalho.valorFrete),
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
                'Desconto: ' + Constantes.formatoDecimalValor.format(widget.vendaOrcamentoCabecalho.valorDesconto),
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
                'Total: ' + Constantes.formatoDecimalValor.format(widget.vendaOrcamentoCabecalho.valorTotal),
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
    if (widget.vendaOrcamentoCabecalho.listaVendaOrcamentoDetalhe == null) {
      widget.vendaOrcamentoCabecalho.listaVendaOrcamentoDetalhe = [];
    }
    List<DataRow> lista = [];
    for (var vendaOrcamentoDetalhe in widget.vendaOrcamentoCabecalho.listaVendaOrcamentoDetalhe) {
      List<DataCell> celulas = new List<DataCell>();

      celulas = [
        DataCell(Text('${ vendaOrcamentoDetalhe.id ?? ''}'), onTap: () {
          detalharVendaOrcamentoDetalhe(widget.vendaOrcamentoCabecalho, vendaOrcamentoDetalhe, context);
        }),
		DataCell(Text('${vendaOrcamentoDetalhe.produto?.nome ?? ''}'), onTap: () {
			detalharVendaOrcamentoDetalhe(widget.vendaOrcamentoCabecalho, vendaOrcamentoDetalhe, context);
		}),
		DataCell(Text('${vendaOrcamentoDetalhe.quantidade != null ? Constantes.formatoDecimalQuantidade.format(vendaOrcamentoDetalhe.quantidade) : 0.toStringAsFixed(Constantes.decimaisQuantidade)}'), onTap: () {
			detalharVendaOrcamentoDetalhe(widget.vendaOrcamentoCabecalho, vendaOrcamentoDetalhe, context);
		}),
		DataCell(Text('${vendaOrcamentoDetalhe.valorUnitario != null ? Constantes.formatoDecimalValor.format(vendaOrcamentoDetalhe.valorUnitario) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharVendaOrcamentoDetalhe(widget.vendaOrcamentoCabecalho, vendaOrcamentoDetalhe, context);
		}),
		DataCell(Text('${vendaOrcamentoDetalhe.valorSubtotal != null ? Constantes.formatoDecimalValor.format(vendaOrcamentoDetalhe.valorSubtotal) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharVendaOrcamentoDetalhe(widget.vendaOrcamentoCabecalho, vendaOrcamentoDetalhe, context);
		}),
		DataCell(Text('${vendaOrcamentoDetalhe.taxaDesconto != null ? Constantes.formatoDecimalTaxa.format(vendaOrcamentoDetalhe.taxaDesconto) : 0.toStringAsFixed(Constantes.decimaisTaxa)}'), onTap: () {
			detalharVendaOrcamentoDetalhe(widget.vendaOrcamentoCabecalho, vendaOrcamentoDetalhe, context);
		}),
		DataCell(Text('${vendaOrcamentoDetalhe.valorDesconto != null ? Constantes.formatoDecimalValor.format(vendaOrcamentoDetalhe.valorDesconto) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharVendaOrcamentoDetalhe(widget.vendaOrcamentoCabecalho, vendaOrcamentoDetalhe, context);
		}),
		DataCell(Text('${vendaOrcamentoDetalhe.valorTotal != null ? Constantes.formatoDecimalValor.format(vendaOrcamentoDetalhe.valorTotal) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharVendaOrcamentoDetalhe(widget.vendaOrcamentoCabecalho, vendaOrcamentoDetalhe, context);
		}),
      ];

      lista.add(DataRow(cells: celulas));
    }
    atualizarTotais();
    return lista;
  }

  detalharVendaOrcamentoDetalhe(
    VendaOrcamentoCabecalho vendaOrcamentoCabecalho, VendaOrcamentoDetalhe vendaOrcamentoDetalhe, BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (BuildContext context) => VendaOrcamentoDetalheDetalhePage(
                  vendaOrcamentoCabecalho: vendaOrcamentoCabecalho,
                  vendaOrcamentoDetalhe: vendaOrcamentoDetalhe,
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
        for (VendaOrcamentoDetalhe orcamentoDetalhe in widget.vendaOrcamentoCabecalho.listaVendaOrcamentoDetalhe) {
          subTotal = subTotal + orcamentoDetalhe.valorTotal;
        }     
        widget.vendaOrcamentoCabecalho.valorSubtotal = subTotal;
        widget.vendaOrcamentoCabecalho.valorDesconto = Biblioteca.calcularDesconto(widget.vendaOrcamentoCabecalho.valorSubtotal, widget.vendaOrcamentoCabecalho.taxaDesconto);
        widget.vendaOrcamentoCabecalho.valorComissao = Biblioteca.calcularComissao(widget.vendaOrcamentoCabecalho.valorSubtotal - widget.vendaOrcamentoCabecalho.valorDesconto, widget.vendaOrcamentoCabecalho.taxaComissao);
        widget.vendaOrcamentoCabecalho.valorTotal = widget.vendaOrcamentoCabecalho.valorSubtotal + 
                                                    widget.vendaOrcamentoCabecalho.valorFrete - 
                                                    widget.vendaOrcamentoCabecalho.valorDesconto;
      } catch (e) {
        print(e.toString());
      }
    });
  }

}