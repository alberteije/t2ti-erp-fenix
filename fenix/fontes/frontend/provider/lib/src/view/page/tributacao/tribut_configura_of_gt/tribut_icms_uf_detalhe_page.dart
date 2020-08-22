/*
Title: T2Ti ERP Fenix                                                                
Description: AbaDetalhe DetalhePage relacionada à tabela [TRIBUT_ICMS_UF] 
                                                                                
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
import 'tribut_icms_uf_persiste_page.dart';

class TributIcmsUfDetalhePage extends StatefulWidget {
  final TributConfiguraOfGt tributConfiguraOfGt;
  final TributIcmsUf tributIcmsUf;

  const TributIcmsUfDetalhePage({Key key, this.tributConfiguraOfGt, this.tributIcmsUf})
      : super(key: key);

  @override
  _TributIcmsUfDetalhePageState createState() =>
      _TributIcmsUfDetalhePageState();
}

class _TributIcmsUfDetalhePageState extends State<TributIcmsUfDetalhePage> {
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ViewUtilLib.getThemeDataDetalhePage(context),
        child: Scaffold(
          appBar: AppBar(title: Text('Tribut Icms Uf'), actions: <Widget>[
            IconButton(
              icon: ViewUtilLib.getIconBotaoExcluir(),
              onPressed: () {
                return ViewUtilLib.gerarDialogBoxExclusao(context, () {
                  widget.tributConfiguraOfGt.listaTributIcmsUf.remove(widget.tributIcmsUf);
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
                            TributIcmsUfPersistePage(
                                tributConfiguraOfGt: widget.tributConfiguraOfGt,
                                tributIcmsUf: widget.tributIcmsUf,
                                title: 'Tribut Icms Uf - Editando',
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
				  ViewUtilLib.getPaddingDetalhePage('Detalhes de TributConfiguraOfGt'),
                  Card(
                    color: Colors.white,
                    elevation: 2.0,
                    child: Column(
                      children: <Widget>[
						ViewUtilLib.getListTileDataDetalhePage(
							widget.tributIcmsUf.ufDestino ?? '', 'UF'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.tributIcmsUf.cfop?.toString() ?? '', 'CFOP'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.tributIcmsUf.csosn ?? '', 'CSOSN'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.tributIcmsUf.cst ?? '', 'CST'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.tributIcmsUf.modalidadeBc ?? '', 'Modalidade Base Cálculo'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.tributIcmsUf.aliquota != null ? Constantes.formatoDecimalTaxa.format(widget.tributIcmsUf.aliquota) : 0.toStringAsFixed(Constantes.decimaisTaxa), 'Alíquota'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.tributIcmsUf.valorPauta != null ? Constantes.formatoDecimalValor.format(widget.tributIcmsUf.valorPauta) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Pauta'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.tributIcmsUf.valorPrecoMaximo != null ? Constantes.formatoDecimalValor.format(widget.tributIcmsUf.valorPrecoMaximo) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Preço Máximo'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.tributIcmsUf.mva != null ? Constantes.formatoDecimalValor.format(widget.tributIcmsUf.mva) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor MVA'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.tributIcmsUf.porcentoBc != null ? Constantes.formatoDecimalTaxa.format(widget.tributIcmsUf.porcentoBc) : 0.toStringAsFixed(Constantes.decimaisTaxa), 'Porcento Base Cálculo'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.tributIcmsUf.modalidadeBcSt ?? '', 'Modalidade Base Cálculo ST'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.tributIcmsUf.aliquotaInternaSt != null ? Constantes.formatoDecimalTaxa.format(widget.tributIcmsUf.aliquotaInternaSt) : 0.toStringAsFixed(Constantes.decimaisTaxa), 'Alíquota Interna ST'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.tributIcmsUf.aliquotaInterestadualSt != null ? Constantes.formatoDecimalTaxa.format(widget.tributIcmsUf.aliquotaInterestadualSt) : 0.toStringAsFixed(Constantes.decimaisTaxa), 'Alíquota Interestadual ST'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.tributIcmsUf.porcentoBcSt != null ? Constantes.formatoDecimalTaxa.format(widget.tributIcmsUf.porcentoBcSt) : 0.toStringAsFixed(Constantes.decimaisTaxa), 'Porcento Base Cálculo ST'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.tributIcmsUf.aliquotaIcmsSt != null ? Constantes.formatoDecimalTaxa.format(widget.tributIcmsUf.aliquotaIcmsSt) : 0.toStringAsFixed(Constantes.decimaisTaxa), 'Alíquota ICMS ST'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.tributIcmsUf.valorPautaSt != null ? Constantes.formatoDecimalValor.format(widget.tributIcmsUf.valorPautaSt) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Pauta ST'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.tributIcmsUf.valorPrecoMaximoSt != null ? Constantes.formatoDecimalValor.format(widget.tributIcmsUf.valorPrecoMaximoSt) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Preço Máximo ST'),
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
