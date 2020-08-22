/*
Title: T2Ti ERP Fenix                                                                
Description: AbaDetalhe DetalhePage relacionada à tabela [VENDA_ORCAMENTO_DETALHE] 
                                                                                
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
import 'venda_orcamento_detalhe_persiste_page.dart';

class VendaOrcamentoDetalheDetalhePage extends StatefulWidget {
  final VendaOrcamentoCabecalho vendaOrcamentoCabecalho;
  final VendaOrcamentoDetalhe vendaOrcamentoDetalhe;

  const VendaOrcamentoDetalheDetalhePage({Key key, this.vendaOrcamentoCabecalho, this.vendaOrcamentoDetalhe})
      : super(key: key);

  @override
  _VendaOrcamentoDetalheDetalhePageState createState() =>
      _VendaOrcamentoDetalheDetalhePageState();
}

class _VendaOrcamentoDetalheDetalhePageState extends State<VendaOrcamentoDetalheDetalhePage> {
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ViewUtilLib.getThemeDataDetalhePage(context),
        child: Scaffold(
          appBar: AppBar(title: Text('Venda Orcamento Detalhe'), actions: <Widget>[
            IconButton(
              icon: ViewUtilLib.getIconBotaoExcluir(),
              onPressed: () {
                return ViewUtilLib.gerarDialogBoxExclusao(context, () {
                  widget.vendaOrcamentoCabecalho.listaVendaOrcamentoDetalhe.remove(widget.vendaOrcamentoDetalhe);
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                });
              },
            ),
            IconButton(
              icon: ViewUtilLib.getIconBotaoAlterar(),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            VendaOrcamentoDetalhePersistePage(
                                vendaOrcamentoCabecalho: widget.vendaOrcamentoCabecalho,
                                vendaOrcamentoDetalhe: widget.vendaOrcamentoDetalhe,
                                title: 'Venda Orcamento Detalhe - Editando',
                                operacao: 'A')))
                    .then((_) {
                  setState(() {});
                });
              },
            ),
          ]),
          body: SingleChildScrollView(
            child: Theme(
              data: ThemeData(fontFamily: 'Raleway'),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
				  ViewUtilLib.getPaddingDetalhePage('Detalhes de Venda Orcamento Cabecalho'),
                  Card(
                    color: Colors.white,
                    elevation: 2.0,
                    child: Column(
                      children: <Widget>[
						ViewUtilLib.getListTileDataDetalhePage(
							widget.vendaOrcamentoDetalhe.produto?.nome?.toString() ?? '', 'Produto'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.vendaOrcamentoDetalhe.quantidade != null ? Constantes.formatoDecimalQuantidade.format(widget.vendaOrcamentoDetalhe.quantidade) : 0.toStringAsFixed(Constantes.decimaisQuantidade), 'Quantidade'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.vendaOrcamentoDetalhe.valorUnitario != null ? Constantes.formatoDecimalValor.format(widget.vendaOrcamentoDetalhe.valorUnitario) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Unitário'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.vendaOrcamentoDetalhe.valorSubtotal != null ? Constantes.formatoDecimalValor.format(widget.vendaOrcamentoDetalhe.valorSubtotal) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Subtotal'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.vendaOrcamentoDetalhe.taxaDesconto != null ? Constantes.formatoDecimalTaxa.format(widget.vendaOrcamentoDetalhe.taxaDesconto) : 0.toStringAsFixed(Constantes.decimaisTaxa), 'Taxa Desconto'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.vendaOrcamentoDetalhe.valorDesconto != null ? Constantes.formatoDecimalValor.format(widget.vendaOrcamentoDetalhe.valorDesconto) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Desconto'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.vendaOrcamentoDetalhe.valorTotal != null ? Constantes.formatoDecimalValor.format(widget.vendaOrcamentoDetalhe.valorTotal) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Total'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
