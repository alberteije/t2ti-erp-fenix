/*
Title: T2Ti ERP Fenix                                                                
Description: AbaDetalhe DetalhePage relacionada à tabela [OS_PRODUTO_SERVICO] 
                                                                                
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
import 'os_produto_servico_persiste_page.dart';

class OsProdutoServicoDetalhePage extends StatefulWidget {
  final OsAbertura osAbertura;
  final OsProdutoServico osProdutoServico;

  const OsProdutoServicoDetalhePage({Key key, this.osAbertura, this.osProdutoServico})
      : super(key: key);

  @override
  _OsProdutoServicoDetalhePageState createState() =>
      _OsProdutoServicoDetalhePageState();
}

class _OsProdutoServicoDetalhePageState extends State<OsProdutoServicoDetalhePage> {
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ViewUtilLib.getThemeDataDetalhePage(context),
        child: Scaffold(
          appBar: AppBar(title: Text('Os Produto Servico'), actions: <Widget>[
            IconButton(
              icon: ViewUtilLib.getIconBotaoExcluir(),
              onPressed: () {
                return ViewUtilLib.gerarDialogBoxExclusao(context, () {
                  widget.osAbertura.listaOsProdutoServico.remove(widget.osProdutoServico);
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
                            OsProdutoServicoPersistePage(
                                osAbertura: widget.osAbertura,
                                osProdutoServico: widget.osProdutoServico,
                                title: 'Os Produto Servico - Editando',
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
				  ViewUtilLib.getPaddingDetalhePage('Detalhes de OsAbertura'),
                  Card(
                    color: Colors.white,
                    elevation: 2.0,
                    child: Column(
                      children: <Widget>[
						ViewUtilLib.getListTileDataDetalhePage(
							widget.osProdutoServico.produto?.nome?.toString() ?? '', 'Produto'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.osProdutoServico.tipo ?? '', 'Tipo'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.osProdutoServico.complemento ?? '', 'Complemento'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.osProdutoServico.quantidade != null ? Constantes.formatoDecimalQuantidade.format(widget.osProdutoServico.quantidade) : 0.toStringAsFixed(Constantes.decimaisQuantidade), 'Quantidade'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.osProdutoServico.valorUnitario != null ? Constantes.formatoDecimalValor.format(widget.osProdutoServico.valorUnitario) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Unitário'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.osProdutoServico.valorSubtotal != null ? Constantes.formatoDecimalValor.format(widget.osProdutoServico.valorSubtotal) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Subtotal'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.osProdutoServico.taxaDesconto != null ? Constantes.formatoDecimalTaxa.format(widget.osProdutoServico.taxaDesconto) : 0.toStringAsFixed(Constantes.decimaisTaxa), 'Taxa Desconto'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.osProdutoServico.valorDesconto != null ? Constantes.formatoDecimalValor.format(widget.osProdutoServico.valorDesconto) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Desconto'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.osProdutoServico.valorTotal != null ? Constantes.formatoDecimalValor.format(widget.osProdutoServico.valorTotal) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Total'),
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
