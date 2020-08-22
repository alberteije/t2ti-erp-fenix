/*
Title: T2Ti ERP Fenix                                                                
Description: AbaMestre DetalhePage relacionada à tabela [VENDA_ORCAMENTO_CABECALHO] 
                                                                                
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
import 'package:fenix/src/view/shared/erro_page.dart';
import 'package:fenix/src/view/shared/view_util_lib.dart';
import 'package:fenix/src/infra/constantes.dart';
import 'package:intl/intl.dart';
import 'venda_orcamento_cabecalho_page.dart';

class VendaOrcamentoCabecalhoDetalhePage extends StatelessWidget {
  final VendaOrcamentoCabecalho vendaOrcamentoCabecalho;

  const VendaOrcamentoCabecalhoDetalhePage({Key key, this.vendaOrcamentoCabecalho}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vendaOrcamentoCabecalhoProvider = Provider.of<VendaOrcamentoCabecalhoViewModel>(context);

    if (vendaOrcamentoCabecalhoProvider.objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Venda Orcamento Cabecalho'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<VendaOrcamentoCabecalhoViewModel>(context).objetoJsonErro),
      );
    } else {
      return Theme(
          data: ViewUtilLib.getThemeDataDetalhePage(context),
          child: Scaffold(
            appBar: AppBar(title: Text('Venda Orcamento Cabecalho'), actions: <Widget>[
              IconButton(
                icon: ViewUtilLib.getIconBotaoExcluir(),
                onPressed: () {
                  return ViewUtilLib.gerarDialogBoxExclusao(context, () {
                    vendaOrcamentoCabecalhoProvider.excluir(vendaOrcamentoCabecalho.id);
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  });
                },
              ),
              IconButton(
                icon: ViewUtilLib.getIconBotaoAlterar(),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => VendaOrcamentoCabecalhoPage(
                          vendaOrcamentoCabecalho: vendaOrcamentoCabecalho,
                          title: 'Venda Orcamento Cabecalho - Editando',
                          operacao: 'A')));
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
                        ViewUtilLib.getListTileDataDetalhePageId(
                            vendaOrcamentoCabecalho.id?.toString() ?? '', 'Id'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaOrcamentoCabecalho.vendaCondicoesPagamento?.nome?.toString() ?? '', 'Condição  Pagamento'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaOrcamentoCabecalho.vendedor?.colaborador?.pessoa?.nome?.toString() ?? '', 'Vendedor'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaOrcamentoCabecalho.cliente?.pessoa?.nome?.toString() ?? '', 'Cliente'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaOrcamentoCabecalho.transportadora?.pessoa?.nome?.toString() ?? '', 'Transportadora'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaOrcamentoCabecalho.codigo ?? '', 'Código do Orçamento'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaOrcamentoCabecalho.dataCadastro != null ? DateFormat('dd/MM/yyyy').format(vendaOrcamentoCabecalho.dataCadastro) : '', 'Data de Cadastro'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaOrcamentoCabecalho.dataEntrega != null ? DateFormat('dd/MM/yyyy').format(vendaOrcamentoCabecalho.dataEntrega) : '', 'Data de Entrega'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaOrcamentoCabecalho.validade != null ? DateFormat('dd/MM/yyyy').format(vendaOrcamentoCabecalho.validade) : '', 'Data de Validade'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaOrcamentoCabecalho.tipoFrete ?? '', 'Tipo do Frete'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaOrcamentoCabecalho.valorSubtotal != null ? Constantes.formatoDecimalValor.format(vendaOrcamentoCabecalho.valorSubtotal) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Subtotal'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaOrcamentoCabecalho.valorFrete != null ? Constantes.formatoDecimalValor.format(vendaOrcamentoCabecalho.valorFrete) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Frete'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaOrcamentoCabecalho.taxaComissao != null ? Constantes.formatoDecimalTaxa.format(vendaOrcamentoCabecalho.taxaComissao) : 0.toStringAsFixed(Constantes.decimaisTaxa), 'Taxa Comissão'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaOrcamentoCabecalho.valorComissao != null ? Constantes.formatoDecimalValor.format(vendaOrcamentoCabecalho.valorComissao) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Comissão'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaOrcamentoCabecalho.taxaDesconto != null ? Constantes.formatoDecimalTaxa.format(vendaOrcamentoCabecalho.taxaDesconto) : 0.toStringAsFixed(Constantes.decimaisTaxa), 'Taxa Desconto'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaOrcamentoCabecalho.valorDesconto != null ? Constantes.formatoDecimalValor.format(vendaOrcamentoCabecalho.valorDesconto) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Desconto'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaOrcamentoCabecalho.valorTotal != null ? Constantes.formatoDecimalValor.format(vendaOrcamentoCabecalho.valorTotal) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Total'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaOrcamentoCabecalho.observacao ?? '', 'Observação'),
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
}