/*
Title: T2Ti ERP Fenix                                                                
Description: AbaDetalhe ListaPage relacionada à tabela [COMPRA_PEDIDO_DETALHE] 
                                                                                
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
import 'compra_pedido_detalhe_detalhe_page.dart';
import 'compra_pedido_detalhe_persiste_page.dart';

class CompraPedidoDetalheListaPage extends StatefulWidget {
  final CompraPedido compraPedido;

  const CompraPedidoDetalheListaPage({Key key, this.compraPedido}) : super(key: key);

  @override
  _CompraPedidoDetalheListaPageState createState() => _CompraPedidoDetalheListaPageState();
}

class _CompraPedidoDetalheListaPageState extends State<CompraPedidoDetalheListaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
          child: ViewUtilLib.getIconBotaoInserir(),
          onPressed: () {
            var compraPedidoDetalhe = new CompraPedidoDetalhe();
            widget.compraPedido.listaCompraPedidoDetalhe.add(compraPedidoDetalhe);
            Navigator.of(context)
                .push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        CompraPedidoDetalhePersistePage(
                            compraPedido: widget.compraPedido,
                            compraPedidoDetalhe: compraPedidoDetalhe,
                            title: 'Compra Pedido Detalhe - Inserindo',
                            operacao: 'I')))
                .then((_) {
              setState(() {
                if (compraPedidoDetalhe.quantidade == null || compraPedidoDetalhe.quantidade.toString() == "") { // se esse atributo estiver vazio, o objeto será removido
                  widget.compraPedido.listaCompraPedidoDetalhe.remove(compraPedidoDetalhe);
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
	lista.add(DataColumn(numeric: true, label: Text('Quantidade')));
	lista.add(DataColumn(numeric: true, label: Text('Valor Unitário')));
	lista.add(DataColumn(numeric: true, label: Text('Valor Subtotal')));
	lista.add(DataColumn(numeric: true, label: Text('Taxa Desconto')));
	lista.add(DataColumn(numeric: true, label: Text('Valor Desconto')));
	lista.add(DataColumn(numeric: true, label: Text('Valor Total')));
	lista.add(DataColumn(label: Text('CST')));
	lista.add(DataColumn(label: Text('CSOSN')));
	lista.add(DataColumn(numeric: true, label: Text('CFOP')));
	lista.add(DataColumn(numeric: true, label: Text('Valor do ICMS')));
	lista.add(DataColumn(numeric: true, label: Text('Valor do IPI')));
	lista.add(DataColumn(numeric: true, label: Text('Alíquota do ICMS')));
	lista.add(DataColumn(numeric: true, label: Text('Alíquota do IPI')));
    return lista;
  }

  List<DataRow> getRows() {
    if (widget.compraPedido.listaCompraPedidoDetalhe == null) {
      widget.compraPedido.listaCompraPedidoDetalhe = [];
    }
    List<DataRow> lista = [];
    for (var compraPedidoDetalhe in widget.compraPedido.listaCompraPedidoDetalhe) {
      List<DataCell> celulas = new List<DataCell>();

      celulas = [
        DataCell(Text('${ compraPedidoDetalhe.id ?? ''}'), onTap: () {
          detalharCompraPedidoDetalhe(widget.compraPedido, compraPedidoDetalhe, context);
        }),
		DataCell(Text('${compraPedidoDetalhe.produto?.nome ?? ''}'), onTap: () {
			detalharCompraPedidoDetalhe(widget.compraPedido, compraPedidoDetalhe, context);
		}),
		DataCell(Text('${compraPedidoDetalhe.quantidade != null ? Constantes.formatoDecimalQuantidade.format(compraPedidoDetalhe.quantidade) : 0.toStringAsFixed(Constantes.decimaisQuantidade)}'), onTap: () {
			detalharCompraPedidoDetalhe(widget.compraPedido, compraPedidoDetalhe, context);
		}),
		DataCell(Text('${compraPedidoDetalhe.valorUnitario != null ? Constantes.formatoDecimalValor.format(compraPedidoDetalhe.valorUnitario) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharCompraPedidoDetalhe(widget.compraPedido, compraPedidoDetalhe, context);
		}),
		DataCell(Text('${compraPedidoDetalhe.valorSubtotal != null ? Constantes.formatoDecimalValor.format(compraPedidoDetalhe.valorSubtotal) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharCompraPedidoDetalhe(widget.compraPedido, compraPedidoDetalhe, context);
		}),
		DataCell(Text('${compraPedidoDetalhe.taxaDesconto != null ? Constantes.formatoDecimalTaxa.format(compraPedidoDetalhe.taxaDesconto) : 0.toStringAsFixed(Constantes.decimaisTaxa)}'), onTap: () {
			detalharCompraPedidoDetalhe(widget.compraPedido, compraPedidoDetalhe, context);
		}),
		DataCell(Text('${compraPedidoDetalhe.valorDesconto != null ? Constantes.formatoDecimalValor.format(compraPedidoDetalhe.valorDesconto) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharCompraPedidoDetalhe(widget.compraPedido, compraPedidoDetalhe, context);
		}),
		DataCell(Text('${compraPedidoDetalhe.valorTotal != null ? Constantes.formatoDecimalValor.format(compraPedidoDetalhe.valorTotal) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharCompraPedidoDetalhe(widget.compraPedido, compraPedidoDetalhe, context);
		}),
		DataCell(Text('${compraPedidoDetalhe.cst ?? ''}'), onTap: () {
			detalharCompraPedidoDetalhe(widget.compraPedido, compraPedidoDetalhe, context);
		}),
		DataCell(Text('${compraPedidoDetalhe.csosn ?? ''}'), onTap: () {
			detalharCompraPedidoDetalhe(widget.compraPedido, compraPedidoDetalhe, context);
		}),
		DataCell(Text('${compraPedidoDetalhe.cfop ?? ''}'), onTap: () {
			detalharCompraPedidoDetalhe(widget.compraPedido, compraPedidoDetalhe, context);
		}),
		DataCell(Text('${compraPedidoDetalhe.valorIcms != null ? Constantes.formatoDecimalValor.format(compraPedidoDetalhe.valorIcms) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharCompraPedidoDetalhe(widget.compraPedido, compraPedidoDetalhe, context);
		}),
		DataCell(Text('${compraPedidoDetalhe.valorIpi != null ? Constantes.formatoDecimalValor.format(compraPedidoDetalhe.valorIpi) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharCompraPedidoDetalhe(widget.compraPedido, compraPedidoDetalhe, context);
		}),
		DataCell(Text('${compraPedidoDetalhe.aliquotaIcms != null ? Constantes.formatoDecimalTaxa.format(compraPedidoDetalhe.aliquotaIcms) : 0.toStringAsFixed(Constantes.decimaisTaxa)}'), onTap: () {
			detalharCompraPedidoDetalhe(widget.compraPedido, compraPedidoDetalhe, context);
		}),
		DataCell(Text('${compraPedidoDetalhe.aliquotaIpi != null ? Constantes.formatoDecimalTaxa.format(compraPedidoDetalhe.aliquotaIpi) : 0.toStringAsFixed(Constantes.decimaisTaxa)}'), onTap: () {
			detalharCompraPedidoDetalhe(widget.compraPedido, compraPedidoDetalhe, context);
		}),
      ];

      lista.add(DataRow(cells: celulas));
    }
    return lista;
  }

  detalharCompraPedidoDetalhe(
      CompraPedido compraPedido, CompraPedidoDetalhe compraPedidoDetalhe, BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (BuildContext context) => CompraPedidoDetalheDetalhePage(
                  compraPedido: compraPedido,
                  compraPedidoDetalhe: compraPedidoDetalhe,
                ))).then((_) {
				  setState(() {
					getRows();
				  });
				});
  }
}