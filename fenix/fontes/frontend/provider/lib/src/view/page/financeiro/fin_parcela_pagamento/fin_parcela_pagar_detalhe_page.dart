/*
Title: T2Ti ERP Fenix                                                                
Description: DetalhePage relacionada à tabela [FIN_PARCELA_PAGAR] 
                                                                                
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
import 'fin_parcela_pagar_persiste_page.dart';

class FinParcelaPagarDetalhePage extends StatelessWidget {
  final FinParcelaPagar finParcelaPagar;

  const FinParcelaPagarDetalhePage({Key key, this.finParcelaPagar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var finParcelaPagarProvider = Provider.of<FinParcelaPagarViewModel>(context);

    if (finParcelaPagarProvider.objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Pagamento Parcela'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<FinParcelaPagarViewModel>(context).objetoJsonErro),
      );
    } else {
      return Theme(
          data: ViewUtilLib.getThemeDataDetalhePage(context),
          child: Scaffold(
            appBar: AppBar(title: Text('Pagamento Parcela'), actions: <Widget>[
              IconButton(
                icon: ViewUtilLib.getIconBotaoExcluir(),
                onPressed: () {
                  return ViewUtilLib.gerarDialogBoxExclusao(context, () {
                    finParcelaPagarProvider.excluir(finParcelaPagar.id);
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  });
                },
              ),
              IconButton(
                icon: ViewUtilLib.getIconBotaoAlterar(),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => FinParcelaPagarPersistePage(
                          finParcelaPagar: finParcelaPagar,
                          title: 'Pagamento Parcela - Editando',
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
                    ViewUtilLib.getPaddingDetalhePage('Detalhes do Pagamento'),
                    Card(
                      color: Colors.white,
                      elevation: 2.0,
                      child: Column(
                        children: <Widget>[
                        ViewUtilLib.getListTileDataDetalhePageId(
                            finParcelaPagar.id?.toString() ?? '', 'Id'),
                        ViewUtilLib.getListTileDataDetalhePage(
                          finParcelaPagar.finStatusParcela?.descricao?.toString() ?? '', 'Status Parcela'),
                        ViewUtilLib.getListTileDataDetalhePage(
                          finParcelaPagar.finTipoPagamento?.descricao?.toString() ?? '', 'Tipo Pagamento'),
                        ViewUtilLib.getListTileDataDetalhePage(
                          finParcelaPagar.finChequeEmitido?.cheque?.numero?.toString() ?? '', 'Cheque'),
                        ViewUtilLib.getListTileDataDetalhePage(
                          finParcelaPagar.numeroParcela?.toString() ?? '', 'Número da Parcela'),
                        ViewUtilLib.getListTileDataDetalhePage(
                          finParcelaPagar.dataEmissao != null ? DateFormat('dd/MM/yyyy').format(finParcelaPagar.dataEmissao) : '', 'Data de Emissão'),
                        ViewUtilLib.getListTileDataDetalhePage(
                          finParcelaPagar.dataVencimento != null ? DateFormat('dd/MM/yyyy').format(finParcelaPagar.dataVencimento) : '', 'Data de Vencimento'),
                        ViewUtilLib.getListTileDataDetalhePage(
                          finParcelaPagar.descontoAte != null ? DateFormat('dd/MM/yyyy').format(finParcelaPagar.descontoAte) : '', 'Desconto Até'),
                        ViewUtilLib.getListTileDataDetalhePage(
                          finParcelaPagar.valor != null ? Constantes.formatoDecimalValor.format(finParcelaPagar.valor) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor'),
                        ViewUtilLib.getListTileDataDetalhePage(
                          finParcelaPagar.taxaJuro != null ? Constantes.formatoDecimalTaxa.format(finParcelaPagar.taxaJuro) : 0.toStringAsFixed(Constantes.decimaisTaxa), 'Taxa Juros'),
                        ViewUtilLib.getListTileDataDetalhePage(
                          finParcelaPagar.taxaMulta != null ? Constantes.formatoDecimalTaxa.format(finParcelaPagar.taxaMulta) : 0.toStringAsFixed(Constantes.decimaisTaxa), 'Taxa Multa'),
                        ViewUtilLib.getListTileDataDetalhePage(
                          finParcelaPagar.taxaDesconto != null ? Constantes.formatoDecimalTaxa.format(finParcelaPagar.taxaDesconto) : 0.toStringAsFixed(Constantes.decimaisTaxa), 'Taxa Desconto'),
                        ViewUtilLib.getListTileDataDetalhePage(
                          finParcelaPagar.valorJuro != null ? Constantes.formatoDecimalValor.format(finParcelaPagar.valorJuro) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Juros'),
                        ViewUtilLib.getListTileDataDetalhePage(
                          finParcelaPagar.valorMulta != null ? Constantes.formatoDecimalValor.format(finParcelaPagar.valorMulta) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Multa'),
                        ViewUtilLib.getListTileDataDetalhePage(
                          finParcelaPagar.valorDesconto != null ? Constantes.formatoDecimalValor.format(finParcelaPagar.valorDesconto) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Desconto'),
                        ViewUtilLib.getListTileDataDetalhePage(
                          finParcelaPagar.valorPago != null ? Constantes.formatoDecimalValor.format(finParcelaPagar.valorPago) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Pago'),
                        ViewUtilLib.getListTileDataDetalhePage(
                          finParcelaPagar.historico ?? '', 'Histórico'),
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