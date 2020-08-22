/*
Title: T2Ti ERP Fenix                                                                
Description: AbaMestre DetalhePage relacionada à tabela [VENDA_CABECALHO] 
                                                                                
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
import 'venda_cabecalho_page.dart';

class VendaCabecalhoDetalhePage extends StatelessWidget {
  final VendaCabecalho vendaCabecalho;

  const VendaCabecalhoDetalhePage({Key key, this.vendaCabecalho}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vendaCabecalhoProvider = Provider.of<VendaCabecalhoViewModel>(context);

    if (vendaCabecalhoProvider.objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Venda Cabecalho'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<VendaCabecalhoViewModel>(context).objetoJsonErro),
      );
    } else {
      return Theme(
          data: ViewUtilLib.getThemeDataDetalhePage(context),
          child: Scaffold(
            appBar: AppBar(title: Text('Venda Cabecalho'), actions: <Widget>[
              IconButton(
                icon: ViewUtilLib.getIconBotaoExcluir(),
                onPressed: () {
                  return ViewUtilLib.gerarDialogBoxExclusao(context, () {
                    vendaCabecalhoProvider.excluir(vendaCabecalho.id);
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  });
                },
              ),
              IconButton(
                icon: ViewUtilLib.getIconBotaoAlterar(),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => VendaCabecalhoPage(
                          vendaCabecalho: vendaCabecalho,
                          title: 'Venda Cabecalho - Editando',
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
                    ViewUtilLib.getPaddingDetalhePage('Detalhes de Venda Cabecalho'),
                    Card(
                      color: Colors.white,
                      elevation: 2.0,
                      child: Column(
                        children: <Widget>[
                        ViewUtilLib.getListTileDataDetalhePageId(
                            vendaCabecalho.id?.toString() ?? '', 'Id'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaCabecalho.vendaOrcamentoCabecalho?.codigo?.toString() ?? '', 'Orçamento'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaCabecalho.vendaCondicoesPagamento?.descricao?.toString() ?? '', 'Condição Pagamento'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaCabecalho.notaFiscalTipo?.nome?.toString() ?? '', 'Tipo Nota Fiscal'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaCabecalho.cliente?.pessoa?.nome?.toString() ?? '', 'Cliente'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaCabecalho.transportadora?.pessoa?.nome?.toString() ?? '', 'Transportadora'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaCabecalho.vendedor?.colaborador?.pessoa?.nome?.toString() ?? '', 'Vendedor'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaCabecalho.dataVenda != null ? DateFormat('dd/MM/yyyy').format(vendaCabecalho.dataVenda) : '', 'Data da Venda'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaCabecalho.dataSaida != null ? DateFormat('dd/MM/yyyy').format(vendaCabecalho.dataSaida) : '', 'Data da Saída'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaCabecalho.horaSaida ?? '', 'Hora da Saída'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaCabecalho.numeroFatura?.toString() ?? '', 'Número da Fatura'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaCabecalho.localEntrega ?? '', 'Local de Entrega'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaCabecalho.localCobranca ?? '', 'Local de Cobrança'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaCabecalho.valorSubtotal != null ? Constantes.formatoDecimalValor.format(vendaCabecalho.valorSubtotal) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Subtotal'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaCabecalho.taxaComissao != null ? Constantes.formatoDecimalTaxa.format(vendaCabecalho.taxaComissao) : 0.toStringAsFixed(Constantes.decimaisTaxa), 'Taxa Comissão'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaCabecalho.valorComissao != null ? Constantes.formatoDecimalValor.format(vendaCabecalho.valorComissao) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Comissão'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaCabecalho.taxaDesconto != null ? Constantes.formatoDecimalTaxa.format(vendaCabecalho.taxaDesconto) : 0.toStringAsFixed(Constantes.decimaisTaxa), 'Taxa Desconto'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaCabecalho.valorDesconto != null ? Constantes.formatoDecimalValor.format(vendaCabecalho.valorDesconto) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Desconto'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaCabecalho.valorTotal != null ? Constantes.formatoDecimalValor.format(vendaCabecalho.valorTotal) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Total'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaCabecalho.tipoFrete ?? '', 'Tipo do Frete'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaCabecalho.formaPagamento ?? '', 'Forma de Pagamento'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaCabecalho.valorFrete != null ? Constantes.formatoDecimalValor.format(vendaCabecalho.valorFrete) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Frete'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaCabecalho.valorSeguro != null ? Constantes.formatoDecimalValor.format(vendaCabecalho.valorSeguro) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Seguro'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaCabecalho.observacao ?? '', 'Observação'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaCabecalho.situacao ?? '', 'Situação'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaCabecalho.diaFixoParcela ?? '', 'Dia Fixo da Parcela'),
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