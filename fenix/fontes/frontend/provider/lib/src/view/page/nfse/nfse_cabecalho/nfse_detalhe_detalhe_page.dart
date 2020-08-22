/*
Title: T2Ti ERP Fenix                                                                
Description: AbaDetalhe DetalhePage relacionada à tabela [NFSE_DETALHE] 
                                                                                
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
import 'nfse_detalhe_persiste_page.dart';

class NfseDetalheDetalhePage extends StatefulWidget {
  final NfseCabecalho nfseCabecalho;
  final NfseDetalhe nfseDetalhe;

  const NfseDetalheDetalhePage({Key key, this.nfseCabecalho, this.nfseDetalhe})
      : super(key: key);

  @override
  _NfseDetalheDetalhePageState createState() =>
      _NfseDetalheDetalhePageState();
}

class _NfseDetalheDetalhePageState extends State<NfseDetalheDetalhePage> {
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ViewUtilLib.getThemeDataDetalhePage(context),
        child: Scaffold(
          appBar: AppBar(title: Text('Nfse Detalhe'), actions: <Widget>[
            IconButton(
              icon: ViewUtilLib.getIconBotaoExcluir(),
              onPressed: () {
                return ViewUtilLib.gerarDialogBoxExclusao(context, () {
                  widget.nfseCabecalho.listaNfseDetalhe.remove(widget.nfseDetalhe);
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
                            NfseDetalhePersistePage(
                                nfseCabecalho: widget.nfseCabecalho,
                                nfseDetalhe: widget.nfseDetalhe,
                                title: 'Nfse Detalhe - Editando',
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
				  ViewUtilLib.getPaddingDetalhePage('Detalhes de NfseCabecalho'),
                  Card(
                    color: Colors.white,
                    elevation: 2.0,
                    child: Column(
                      children: <Widget>[
						ViewUtilLib.getListTileDataDetalhePage(
							widget.nfseDetalhe.nfseListaServico?.descricao?.toString() ?? '', 'Lista Serviço'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.nfseDetalhe.valorServicos != null ? Constantes.formatoDecimalValor.format(widget.nfseDetalhe.valorServicos) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor dos Serviços'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.nfseDetalhe.valorDeducoes != null ? Constantes.formatoDecimalValor.format(widget.nfseDetalhe.valorDeducoes) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor das Deduções'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.nfseDetalhe.valorPis != null ? Constantes.formatoDecimalValor.format(widget.nfseDetalhe.valorPis) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor do PIS'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.nfseDetalhe.valorCofins != null ? Constantes.formatoDecimalValor.format(widget.nfseDetalhe.valorCofins) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor do COFINS'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.nfseDetalhe.valorInss != null ? Constantes.formatoDecimalValor.format(widget.nfseDetalhe.valorInss) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor do INSS'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.nfseDetalhe.valorIr != null ? Constantes.formatoDecimalValor.format(widget.nfseDetalhe.valorIr) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor do IR'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.nfseDetalhe.valorCsll != null ? Constantes.formatoDecimalValor.format(widget.nfseDetalhe.valorCsll) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor do CSLL'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.nfseDetalhe.codigoCnae ?? '', 'CNAE'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.nfseDetalhe.codigoTributacaoMunicipio ?? '', 'Código Tributação Município'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.nfseDetalhe.valorBaseCalculo != null ? Constantes.formatoDecimalValor.format(widget.nfseDetalhe.valorBaseCalculo) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Base Cálculo'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.nfseDetalhe.aliquota != null ? Constantes.formatoDecimalTaxa.format(widget.nfseDetalhe.aliquota) : 0.toStringAsFixed(Constantes.decimaisTaxa), 'Alíquota'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.nfseDetalhe.valorIss != null ? Constantes.formatoDecimalValor.format(widget.nfseDetalhe.valorIss) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor do ISS'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.nfseDetalhe.valorLiquido != null ? Constantes.formatoDecimalValor.format(widget.nfseDetalhe.valorLiquido) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Líquido'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.nfseDetalhe.outrasRetencoes != null ? Constantes.formatoDecimalValor.format(widget.nfseDetalhe.outrasRetencoes) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Outras Retenções'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.nfseDetalhe.valorCredito != null ? Constantes.formatoDecimalValor.format(widget.nfseDetalhe.valorCredito) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Crédito'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.nfseDetalhe.issRetido ?? '', 'ISS Retido'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.nfseDetalhe.valorIssRetido != null ? Constantes.formatoDecimalValor.format(widget.nfseDetalhe.valorIssRetido) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor ISS Retido'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.nfseDetalhe.valorDescontoCondicionado != null ? Constantes.formatoDecimalValor.format(widget.nfseDetalhe.valorDescontoCondicionado) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Desconto Condicionado'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.nfseDetalhe.valorDescontoIncondicionado != null ? Constantes.formatoDecimalValor.format(widget.nfseDetalhe.valorDescontoIncondicionado) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Desconto Incondicionado'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.nfseDetalhe.discriminacao ?? '', 'Discriminação'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.nfseDetalhe.municipioPrestacao?.toString() ?? '', 'Município IBGE'),
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
