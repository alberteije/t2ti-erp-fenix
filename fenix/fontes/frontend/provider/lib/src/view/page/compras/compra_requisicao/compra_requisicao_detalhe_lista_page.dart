/*
Title: T2Ti ERP Fenix                                                                
Description: AbaDetalhe ListaPage relacionada à tabela [COMPRA_REQUISICAO_DETALHE] 
                                                                                
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
import 'compra_requisicao_detalhe_detalhe_page.dart';
import 'compra_requisicao_detalhe_persiste_page.dart';

class CompraRequisicaoDetalheListaPage extends StatefulWidget {
  final CompraRequisicao compraRequisicao;

  const CompraRequisicaoDetalheListaPage({Key key, this.compraRequisicao}) : super(key: key);

  @override
  _CompraRequisicaoDetalheListaPageState createState() => _CompraRequisicaoDetalheListaPageState();
}

class _CompraRequisicaoDetalheListaPageState extends State<CompraRequisicaoDetalheListaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
          child: ViewUtilLib.getIconBotaoInserir(),
          onPressed: () {
            var compraRequisicaoDetalhe = new CompraRequisicaoDetalhe();
            widget.compraRequisicao.listaCompraRequisicaoDetalhe.add(compraRequisicaoDetalhe);
            Navigator.of(context)
                .push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        CompraRequisicaoDetalhePersistePage(
                            compraRequisicao: widget.compraRequisicao,
                            compraRequisicaoDetalhe: compraRequisicaoDetalhe,
                            title: 'Compra Requisicao Detalhe - Inserindo',
                            operacao: 'I')))
                .then((_) {
              setState(() {
                if (compraRequisicaoDetalhe.quantidade == null || compraRequisicaoDetalhe.quantidade.toString() == "") { // se esse atributo estiver vazio, o objeto será removido
                  widget.compraRequisicao.listaCompraRequisicaoDetalhe.remove(compraRequisicaoDetalhe);
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
    return lista;
  }

  List<DataRow> getRows() {
    if (widget.compraRequisicao.listaCompraRequisicaoDetalhe == null) {
      widget.compraRequisicao.listaCompraRequisicaoDetalhe = [];
    }
    List<DataRow> lista = [];
    for (var compraRequisicaoDetalhe in widget.compraRequisicao.listaCompraRequisicaoDetalhe) {
      List<DataCell> celulas = new List<DataCell>();

      celulas = [
        DataCell(Text('${ compraRequisicaoDetalhe.id ?? ''}'), onTap: () {
          detalharCompraRequisicaoDetalhe(widget.compraRequisicao, compraRequisicaoDetalhe, context);
        }),
		DataCell(Text('${compraRequisicaoDetalhe.produto?.nome ?? ''}'), onTap: () {
			detalharCompraRequisicaoDetalhe(widget.compraRequisicao, compraRequisicaoDetalhe, context);
		}),
		DataCell(Text('${compraRequisicaoDetalhe.quantidade != null ? Constantes.formatoDecimalQuantidade.format(compraRequisicaoDetalhe.quantidade) : 0.toStringAsFixed(Constantes.decimaisQuantidade)}'), onTap: () {
			detalharCompraRequisicaoDetalhe(widget.compraRequisicao, compraRequisicaoDetalhe, context);
		}),
      ];

      lista.add(DataRow(cells: celulas));
    }
    return lista;
  }

  detalharCompraRequisicaoDetalhe(
      CompraRequisicao compraRequisicao, CompraRequisicaoDetalhe compraRequisicaoDetalhe, BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (BuildContext context) => CompraRequisicaoDetalheDetalhePage(
                  compraRequisicao: compraRequisicao,
                  compraRequisicaoDetalhe: compraRequisicaoDetalhe,
                ))).then((_) {
				  setState(() {
					getRows();
				  });
				});
  }
}