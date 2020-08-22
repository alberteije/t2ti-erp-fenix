/*
Title: T2Ti ERP Fenix                                                                
Description: AbaDetalhe ListaPage relacionada à tabela [TABELA_PRECO_PRODUTO] 
                                                                                
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
import 'tabela_preco_produto_detalhe_page.dart';
import 'tabela_preco_produto_persiste_page.dart';

class TabelaPrecoProdutoListaPage extends StatefulWidget {
  final TabelaPreco tabelaPreco;

  const TabelaPrecoProdutoListaPage({Key key, this.tabelaPreco}) : super(key: key);

  @override
  _TabelaPrecoProdutoListaPageState createState() => _TabelaPrecoProdutoListaPageState();
}

class _TabelaPrecoProdutoListaPageState extends State<TabelaPrecoProdutoListaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
          child: ViewUtilLib.getIconBotaoInserir(),
          onPressed: () {
            var tabelaPrecoProduto = new TabelaPrecoProduto();
            widget.tabelaPreco.listaTabelaPrecoProduto.add(tabelaPrecoProduto);
            Navigator.of(context)
                .push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        TabelaPrecoProdutoPersistePage(
                            tabelaPreco: widget.tabelaPreco,
                            tabelaPrecoProduto: tabelaPrecoProduto,
                            title: 'Tabela Preco Produto - Inserindo',
                            operacao: 'I')))
                .then((_) {
              setState(() {
                if (tabelaPrecoProduto.preco == null) { // se esse atributo estiver vazio, o objeto será removido
                  widget.tabelaPreco.listaTabelaPrecoProduto.remove(tabelaPrecoProduto);
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
	lista.add(DataColumn(numeric: true, label: Text('Preço')));
    return lista;
  }

  List<DataRow> getRows() {
    if (widget.tabelaPreco.listaTabelaPrecoProduto == null) {
      widget.tabelaPreco.listaTabelaPrecoProduto = [];
    }
    List<DataRow> lista = [];
    for (var tabelaPrecoProduto in widget.tabelaPreco.listaTabelaPrecoProduto) {
      List<DataCell> celulas = new List<DataCell>();

      celulas = [
        DataCell(Text('${ tabelaPrecoProduto.id ?? ''}'), onTap: () {
          detalharTabelaPrecoProduto(widget.tabelaPreco, tabelaPrecoProduto, context);
        }),
		DataCell(Text('${tabelaPrecoProduto.produto?.nome ?? ''}'), onTap: () {
			detalharTabelaPrecoProduto(widget.tabelaPreco, tabelaPrecoProduto, context);
		}),
		DataCell(Text('${tabelaPrecoProduto.preco != null ? Constantes.formatoDecimalValor.format(tabelaPrecoProduto.preco) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharTabelaPrecoProduto(widget.tabelaPreco, tabelaPrecoProduto, context);
		}),
      ];

      lista.add(DataRow(cells: celulas));
    }
    return lista;
  }

  detalharTabelaPrecoProduto(
      TabelaPreco tabelaPreco, TabelaPrecoProduto tabelaPrecoProduto, BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (BuildContext context) => TabelaPrecoProdutoDetalhePage(
                  tabelaPreco: tabelaPreco,
                  tabelaPrecoProduto: tabelaPrecoProduto,
                ))).then((_) {
				  setState(() {
					getRows();
				  });
				});
  }
}