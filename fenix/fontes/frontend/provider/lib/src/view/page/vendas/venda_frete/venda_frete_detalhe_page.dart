/*
Title: T2Ti ERP Fenix                                                                
Description: DetalhePage relacionada à tabela [VENDA_FRETE] 
                                                                                
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
import 'venda_frete_persiste_page.dart';

class VendaFreteDetalhePage extends StatelessWidget {
  final VendaFrete vendaFrete;

  const VendaFreteDetalhePage({Key key, this.vendaFrete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var vendaFreteProvider = Provider.of<VendaFreteViewModel>(context);

    if (vendaFreteProvider.objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Venda Frete'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<VendaFreteViewModel>(context).objetoJsonErro),
      );
    } else {
      return Theme(
          data: ViewUtilLib.getThemeDataDetalhePage(context),
          child: Scaffold(
            appBar: AppBar(title: Text('Venda Frete'), actions: <Widget>[
              IconButton(
                icon: ViewUtilLib.getIconBotaoExcluir(),
                onPressed: () {
                  return ViewUtilLib.gerarDialogBoxExclusao(context, () {
                    vendaFreteProvider.excluir(vendaFrete.id);
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  });
                },
              ),
              IconButton(
                icon: ViewUtilLib.getIconBotaoAlterar(),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => VendaFretePersistePage(
                          vendaFrete: vendaFrete,
                          title: 'Venda Frete - Editando',
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
                    ViewUtilLib.getPaddingDetalhePage('Detalhes de Venda Frete'),
                    Card(
                      color: Colors.white,
                      elevation: 2.0,
                      child: Column(
                        children: <Widget>[
                        ViewUtilLib.getListTileDataDetalhePageId(
                            vendaFrete.id?.toString() ?? '', 'Id'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaFrete.vendaCabecalho?.id?.toString() ?? '', 'Venda'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaFrete.transportadora?.pessoa?.nome?.toString() ?? '', 'Transportadora'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaFrete.conhecimento?.toString() ?? '', 'Conhecimento'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaFrete.responsavel ?? '', 'Responsável'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaFrete.placa ?? '', 'Placa'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaFrete.ufPlaca ?? '', 'UF'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaFrete.seloFiscal?.toString() ?? '', 'Selo Fiscal'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaFrete.quantidadeVolume != null ? Constantes.formatoDecimalQuantidade.format(vendaFrete.quantidadeVolume) : 0.toStringAsFixed(Constantes.decimaisQuantidade), 'Quantidade de Volumes'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaFrete.marcaVolume ?? '', 'Marca Volume'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaFrete.especieVolume ?? '', 'Espécie do Volume'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaFrete.pesoBruto != null ? Constantes.formatoDecimalQuantidade.format(vendaFrete.pesoBruto) : 0.toStringAsFixed(Constantes.decimaisQuantidade), 'Peso Bruto'),
						ViewUtilLib.getListTileDataDetalhePage(
							vendaFrete.pesoLiquido != null ? Constantes.formatoDecimalQuantidade.format(vendaFrete.pesoLiquido) : 0.toStringAsFixed(Constantes.decimaisQuantidade), 'Peso Líquido'),
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