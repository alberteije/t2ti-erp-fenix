/*
Title: T2Ti ERP Fenix                                                                
Description: AbaDetalhe ListaPage relacionada à tabela [ESTOQUE_REAJUSTE_DETALHE] 
                                                                                
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
import 'package:fenix/src/view_model/view_model.dart';
import 'package:flutter/material.dart';

import 'package:fenix/src/model/model.dart';
import 'package:fenix/src/view/shared/view_util_lib.dart';
import 'package:fenix/src/infra/constantes.dart';
import 'package:provider/provider.dart';
import 'estoque_reajuste_detalhe_detalhe_page.dart';
import 'estoque_reajuste_detalhe_persiste_page.dart';

class EstoqueReajusteDetalheListaPage extends StatefulWidget {
  final EstoqueReajusteCabecalho estoqueReajusteCabecalho;

  const EstoqueReajusteDetalheListaPage({Key key, this.estoqueReajusteCabecalho}) : super(key: key);

  @override
  _EstoqueReajusteDetalheListaPageState createState() => _EstoqueReajusteDetalheListaPageState();
}

class _EstoqueReajusteDetalheListaPageState extends State<EstoqueReajusteDetalheListaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          title: Text('Opções'), 
          backgroundColor: ViewUtilLib.getBackgroundColorBarraTelaDetalhe(),
          leading: new Container(),
          actions: <Widget>[
            IconButton(
              tooltip: 'Selecionar Itens',
              icon: Icon(Icons.search, color: Colors.yellow),
              onPressed: () {
                selecionarItens();
              },
            ),
            IconButton(
              tooltip: 'Realizar Cálculos',
              icon: Icon(Icons.chrome_reader_mode, color: Colors.yellow),
              onPressed: () {
                realizarCalculos();
              },
            ),
        ]),

      floatingActionButton: FloatingActionButton(
          backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
          child: ViewUtilLib.getIconBotaoInserir(),
          onPressed: () {
            var estoqueReajusteDetalhe = new EstoqueReajusteDetalhe();
            widget.estoqueReajusteCabecalho.listaEstoqueReajusteDetalhe.add(estoqueReajusteDetalhe);
            Navigator.of(context)
                .push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        EstoqueReajusteDetalhePersistePage(
                            estoqueReajusteCabecalho: widget.estoqueReajusteCabecalho,
                            estoqueReajusteDetalhe: estoqueReajusteDetalhe,
                            title: 'Estoque Reajuste Detalhe - Inserindo',
                            operacao: 'I')))
                .then((_) {
              setState(() {
                // if (estoqueReajusteDetalhe.nome == null || estoqueReajusteDetalhe.nome == "") { // se esse atributo estiver vazio, o objeto será removido
                //   widget.estoqueReajusteCabecalho.listaEstoqueReajusteDetalhe.remove(estoqueReajusteDetalhe);
                // }
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

  selecionarItens() {
    ViewUtilLib.gerarDialogBoxConfirmacao(context, 'Deseja Carregar os Produtos?', () async {
      try {
        await Provider.of<ProdutoViewModel>(context).consultarLista();
        List<Produto> listaProduto = Provider.of<ProdutoViewModel>(context).listaProduto;

        widget.estoqueReajusteCabecalho.listaEstoqueReajusteDetalhe.clear();

        for (Produto produto in listaProduto) {
          EstoqueReajusteDetalhe detalhe = EstoqueReajusteDetalhe();
          detalhe.produto = new Produto( id: produto.id, nome: produto.nome );  
          detalhe.idProduto = produto.id;
          detalhe.valorOriginal = produto.valorVenda;
          widget.estoqueReajusteCabecalho.listaEstoqueReajusteDetalhe.add(detalhe);
        }
        
      } catch (e) {
        print(e);
      }

      Navigator.of(context).pop();

      setState(() {
        getRows();
      });
     });
  }

  realizarCalculos() {
    //TODO: verifique se os valores dos itens estão estourando a quantidade de casas decimais - corrija
    ViewUtilLib.gerarDialogBoxConfirmacao(context, 'Deseja Realizar o Cálculo do Reajuste?', () {

      try {
        for (var estoqueReajusteDetalhe in widget.estoqueReajusteCabecalho.listaEstoqueReajusteDetalhe) {
          if (widget.estoqueReajusteCabecalho.tipoReajuste == 'Aumentar') {
            estoqueReajusteDetalhe.valorReajuste = estoqueReajusteDetalhe.valorOriginal * (1 + (widget.estoqueReajusteCabecalho.taxa / 100));    
          } else {
            estoqueReajusteDetalhe.valorReajuste = estoqueReajusteDetalhe.valorOriginal * (1 - (widget.estoqueReajusteCabecalho.taxa / 100));    
          }
        }        
      } catch (e) {
        print(e);
      }

      Navigator.of(context).pop();

      setState(() {
        getRows();
      });
     });

  }

  List<DataColumn> getColumns() {
    List<DataColumn> lista = [];
	lista.add(DataColumn(numeric: true, label: Text('Id')));
	lista.add(DataColumn(label: Text('Produto')));
	lista.add(DataColumn(numeric: true, label: Text('Valor Original')));
	lista.add(DataColumn(numeric: true, label: Text('Valor Reajustado')));
    return lista;
  }

  List<DataRow> getRows() {
    if (widget.estoqueReajusteCabecalho.listaEstoqueReajusteDetalhe == null) {
      widget.estoqueReajusteCabecalho.listaEstoqueReajusteDetalhe = [];
    }
    List<DataRow> lista = [];
    for (var estoqueReajusteDetalhe in widget.estoqueReajusteCabecalho.listaEstoqueReajusteDetalhe) {
      List<DataCell> celulas = new List<DataCell>();

      celulas = [
        DataCell(Text('${ estoqueReajusteDetalhe.id ?? ''}'), onTap: () {
          detalharEstoqueReajusteDetalhe(widget.estoqueReajusteCabecalho, estoqueReajusteDetalhe, context);
        }),
		DataCell(Text('${estoqueReajusteDetalhe.produto?.nome ?? ''}'), onTap: () {
			detalharEstoqueReajusteDetalhe(widget.estoqueReajusteCabecalho, estoqueReajusteDetalhe, context);
		}),
		DataCell(Text('${estoqueReajusteDetalhe.valorOriginal != null ? Constantes.formatoDecimalValor.format(estoqueReajusteDetalhe.valorOriginal) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharEstoqueReajusteDetalhe(widget.estoqueReajusteCabecalho, estoqueReajusteDetalhe, context);
		}),
		DataCell(Text('${estoqueReajusteDetalhe.valorReajuste != null ? Constantes.formatoDecimalValor.format(estoqueReajusteDetalhe.valorReajuste) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharEstoqueReajusteDetalhe(widget.estoqueReajusteCabecalho, estoqueReajusteDetalhe, context);
		}),
      ];

      lista.add(DataRow(cells: celulas));
    }
    return lista;
  }

  detalharEstoqueReajusteDetalhe(
      EstoqueReajusteCabecalho estoqueReajusteCabecalho, EstoqueReajusteDetalhe estoqueReajusteDetalhe, BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (BuildContext context) => EstoqueReajusteDetalheDetalhePage(
                  estoqueReajusteCabecalho: estoqueReajusteCabecalho,
                  estoqueReajusteDetalhe: estoqueReajusteDetalhe,
                ))).then((_) {
				  setState(() {
					getRows();
				  });
				});
  }
}