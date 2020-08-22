/*
Title: T2Ti ERP Fenix                                                                
Description: AbaMestre DetalhePage relacionada à tabela [COMPRA_PEDIDO] 
                                                                                
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
import 'compra_pedido_page.dart';

class CompraPedidoDetalhePage extends StatelessWidget {
  final CompraPedido compraPedido;

  const CompraPedidoDetalhePage({Key key, this.compraPedido}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var compraPedidoProvider = Provider.of<CompraPedidoViewModel>(context);

    if (compraPedidoProvider.objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Compra Pedido'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<CompraPedidoViewModel>(context).objetoJsonErro),
      );
    } else {
      return Theme(
          data: ViewUtilLib.getThemeDataDetalhePage(context),
          child: Scaffold(
            appBar: AppBar(title: Text('Compra Pedido'), actions: <Widget>[
              IconButton(
                icon: ViewUtilLib.getIconBotaoExcluir(),
                onPressed: () {
                  return ViewUtilLib.gerarDialogBoxExclusao(context, () {
                    compraPedidoProvider.excluir(compraPedido.id);
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  });
                },
              ),
              IconButton(
                icon: ViewUtilLib.getIconBotaoAlterar(),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => CompraPedidoPage(
                          compraPedido: compraPedido,
                          title: 'Compra Pedido - Editando',
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
                    ViewUtilLib.getPaddingDetalhePage('Detalhes de Compra Pedido'),
                    Card(
                      color: Colors.white,
                      elevation: 2.0,
                      child: Column(
                        children: <Widget>[
                        ViewUtilLib.getListTileDataDetalhePageId(
                            compraPedido.id?.toString() ?? '', 'Id'),
						ViewUtilLib.getListTileDataDetalhePage(
							compraPedido.compraTipoPedido?.nome?.toString() ?? '', 'Tipo Pedido'),
						ViewUtilLib.getListTileDataDetalhePage(
							compraPedido.fornecedor?.pessoa?.nome?.toString() ?? '', 'Fornecedor'),
						ViewUtilLib.getListTileDataDetalhePage(
							compraPedido.colaborador?.pessoa?.nome?.toString() ?? '', 'Colaborador'),
						ViewUtilLib.getListTileDataDetalhePage(
							compraPedido.dataPedido != null ? DateFormat('dd/MM/yyyy').format(compraPedido.dataPedido) : '', 'Data do Pedido'),
						ViewUtilLib.getListTileDataDetalhePage(
							compraPedido.dataPrevistaEntrega != null ? DateFormat('dd/MM/yyyy').format(compraPedido.dataPrevistaEntrega) : '', 'Data Prevista para Entrega'),
						ViewUtilLib.getListTileDataDetalhePage(
							compraPedido.dataPrevisaoPagamento != null ? DateFormat('dd/MM/yyyy').format(compraPedido.dataPrevisaoPagamento) : '', 'Data Previsão Pagamento'),
						ViewUtilLib.getListTileDataDetalhePage(
							compraPedido.localEntrega ?? '', 'Local de Entrega'),
						ViewUtilLib.getListTileDataDetalhePage(
							compraPedido.localCobranca ?? '', 'Local de Cobrança'),
						ViewUtilLib.getListTileDataDetalhePage(
							compraPedido.contato ?? '', 'Nome do Contato'),
						ViewUtilLib.getListTileDataDetalhePage(
							compraPedido.valorSubtotal != null ? Constantes.formatoDecimalValor.format(compraPedido.valorSubtotal) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Subtotal'),
						ViewUtilLib.getListTileDataDetalhePage(
							compraPedido.taxaDesconto != null ? Constantes.formatoDecimalTaxa.format(compraPedido.taxaDesconto) : 0.toStringAsFixed(Constantes.decimaisTaxa), 'Taxa Desconto'),
						ViewUtilLib.getListTileDataDetalhePage(
							compraPedido.valorDesconto != null ? Constantes.formatoDecimalValor.format(compraPedido.valorDesconto) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Desconto'),
						ViewUtilLib.getListTileDataDetalhePage(
							compraPedido.valorTotal != null ? Constantes.formatoDecimalValor.format(compraPedido.valorTotal) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Total'),
						ViewUtilLib.getListTileDataDetalhePage(
							compraPedido.tipoFrete ?? '', 'Tipo do Frete'),
						ViewUtilLib.getListTileDataDetalhePage(
							compraPedido.formaPagamento ?? '', 'Forma de Pagamento'),
						ViewUtilLib.getListTileDataDetalhePage(
							compraPedido.baseCalculoIcms != null ? Constantes.formatoDecimalValor.format(compraPedido.baseCalculoIcms) : 0.toStringAsFixed(Constantes.decimaisValor), 'Base Cálculo ICMS'),
						ViewUtilLib.getListTileDataDetalhePage(
							compraPedido.valorIcms != null ? Constantes.formatoDecimalValor.format(compraPedido.valorIcms) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor do ICMS'),
						ViewUtilLib.getListTileDataDetalhePage(
							compraPedido.baseCalculoIcmsSt != null ? Constantes.formatoDecimalValor.format(compraPedido.baseCalculoIcmsSt) : 0.toStringAsFixed(Constantes.decimaisValor), 'Base Cálculo ICMS ST'),
						ViewUtilLib.getListTileDataDetalhePage(
							compraPedido.valorIcmsSt != null ? Constantes.formatoDecimalValor.format(compraPedido.valorIcmsSt) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor do ICMS ST'),
						ViewUtilLib.getListTileDataDetalhePage(
							compraPedido.valorTotalProdutos != null ? Constantes.formatoDecimalValor.format(compraPedido.valorTotalProdutos) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Total Produtos'),
						ViewUtilLib.getListTileDataDetalhePage(
							compraPedido.valorFrete != null ? Constantes.formatoDecimalValor.format(compraPedido.valorFrete) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Frete'),
						ViewUtilLib.getListTileDataDetalhePage(
							compraPedido.valorSeguro != null ? Constantes.formatoDecimalValor.format(compraPedido.valorSeguro) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Seguro'),
						ViewUtilLib.getListTileDataDetalhePage(
							compraPedido.valorOutrasDespesas != null ? Constantes.formatoDecimalValor.format(compraPedido.valorOutrasDespesas) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Outras Despesas'),
						ViewUtilLib.getListTileDataDetalhePage(
							compraPedido.valorIpi != null ? Constantes.formatoDecimalValor.format(compraPedido.valorIpi) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor do IPI'),
						ViewUtilLib.getListTileDataDetalhePage(
							compraPedido.valorTotalNf != null ? Constantes.formatoDecimalValor.format(compraPedido.valorTotalNf) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Total NF'),
						ViewUtilLib.getListTileDataDetalhePage(
							compraPedido.quantidadeParcelas?.toString() ?? '', 'Quantidade de Parcelas'),
						ViewUtilLib.getListTileDataDetalhePage(
							compraPedido.diaPrimeiroVencimento ?? '', 'Dia Primeiro Vencimento'),
						ViewUtilLib.getListTileDataDetalhePage(
							compraPedido.intervaloEntreParcelas?.toString() ?? '', 'Intervalo entre Parcelas'),
						ViewUtilLib.getListTileDataDetalhePage(
							compraPedido.diaFixoParcela ?? '', 'Dia Fixo da Parcela'),
						ViewUtilLib.getListTileDataDetalhePage(
							compraPedido.codigoCotacao ?? '', 'Código da Cotação'),
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