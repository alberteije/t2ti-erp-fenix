/*
Title: T2Ti ERP Fenix                                                                
Description: AbaDetalhe DetalhePage relacionada à tabela [VENDA_CONDICOES_PARCELAS] 
                                                                                
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
import 'venda_condicoes_parcelas_persiste_page.dart';

class VendaCondicoesParcelasDetalhePage extends StatefulWidget {
  final VendaCondicoesPagamento vendaCondicoesPagamento;
  final VendaCondicoesParcelas vendaCondicoesParcelas;

  const VendaCondicoesParcelasDetalhePage({Key key, this.vendaCondicoesPagamento, this.vendaCondicoesParcelas})
      : super(key: key);

  @override
  _VendaCondicoesParcelasDetalhePageState createState() =>
      _VendaCondicoesParcelasDetalhePageState();
}

class _VendaCondicoesParcelasDetalhePageState extends State<VendaCondicoesParcelasDetalhePage> {
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ViewUtilLib.getThemeDataDetalhePage(context),
        child: Scaffold(
          appBar: AppBar(title: Text('Venda Condicoes Parcelas'), actions: <Widget>[
            IconButton(
              icon: ViewUtilLib.getIconBotaoExcluir(),
              onPressed: () {
                return ViewUtilLib.gerarDialogBoxExclusao(context, () {
                  widget.vendaCondicoesPagamento.listaVendaCondicoesParcelas.remove(widget.vendaCondicoesParcelas);
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
                            VendaCondicoesParcelasPersistePage(
                                vendaCondicoesPagamento: widget.vendaCondicoesPagamento,
                                vendaCondicoesParcelas: widget.vendaCondicoesParcelas,
                                title: 'Venda Condicoes Parcelas - Editando',
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
				  ViewUtilLib.getPaddingDetalhePage('Detalhes de VendaCondicoesPagamento'),
                  Card(
                    color: Colors.white,
                    elevation: 2.0,
                    child: Column(
                      children: <Widget>[
						ViewUtilLib.getListTileDataDetalhePage(
							widget.vendaCondicoesParcelas.parcela?.toString() ?? '', 'Número da Parcela'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.vendaCondicoesParcelas.dias?.toString() ?? '', 'Dias'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.vendaCondicoesParcelas.taxa != null ? Constantes.formatoDecimalTaxa.format(widget.vendaCondicoesParcelas.taxa) : 0.toStringAsFixed(Constantes.decimaisTaxa), 'Taxa da Parcela'),
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