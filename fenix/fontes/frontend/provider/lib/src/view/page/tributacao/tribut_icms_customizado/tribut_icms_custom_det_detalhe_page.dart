/*
Title: T2Ti ERP Fenix                                                                
Description: AbaDetalhe DetalhePage relacionada à tabela [TRIBUT_ICMS_CUSTOM_DET] 
                                                                                
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
import 'tribut_icms_custom_det_persiste_page.dart';

class TributIcmsCustomDetDetalhePage extends StatefulWidget {
  final TributIcmsCustomCab tributIcmsCustomCab;
  final TributIcmsCustomDet tributIcmsCustomDet;

  const TributIcmsCustomDetDetalhePage({Key key, this.tributIcmsCustomCab, this.tributIcmsCustomDet})
      : super(key: key);

  @override
  _TributIcmsCustomDetDetalhePageState createState() =>
      _TributIcmsCustomDetDetalhePageState();
}

class _TributIcmsCustomDetDetalhePageState extends State<TributIcmsCustomDetDetalhePage> {
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ViewUtilLib.getThemeDataDetalhePage(context),
        child: Scaffold(
          appBar: AppBar(title: Text('Tribut Icms Custom Det'), actions: <Widget>[
            IconButton(
              icon: ViewUtilLib.getIconBotaoExcluir(),
              onPressed: () {
                return ViewUtilLib.gerarDialogBoxExclusao(context, () {
                  widget.tributIcmsCustomCab.listaTributIcmsCustomDet.remove(widget.tributIcmsCustomDet);
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
                            TributIcmsCustomDetPersistePage(
                                tributIcmsCustomCab: widget.tributIcmsCustomCab,
                                tributIcmsCustomDet: widget.tributIcmsCustomDet,
                                title: 'Tribut Icms Custom Det - Editando',
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
				  ViewUtilLib.getPaddingDetalhePage('Detalhes de TributIcmsCustomCab'),
                  Card(
                    color: Colors.white,
                    elevation: 2.0,
                    child: Column(
                      children: <Widget>[
						ViewUtilLib.getListTileDataDetalhePage(
							widget.tributIcmsCustomDet.ufDestino ?? '', 'UF'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.tributIcmsCustomDet.cfop?.toString() ?? '', 'CFOP'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.tributIcmsCustomDet.csosn ?? '', 'CSOSN'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.tributIcmsCustomDet.cst ?? '', 'CST'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.tributIcmsCustomDet.modalidadeBc ?? '', 'Modalidade Base Cálculo'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.tributIcmsCustomDet.aliquota != null ? Constantes.formatoDecimalTaxa.format(widget.tributIcmsCustomDet.aliquota) : 0.toStringAsFixed(Constantes.decimaisTaxa), 'Alíquota'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.tributIcmsCustomDet.valorPauta != null ? Constantes.formatoDecimalValor.format(widget.tributIcmsCustomDet.valorPauta) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Pauta'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.tributIcmsCustomDet.valorPrecoMaximo != null ? Constantes.formatoDecimalValor.format(widget.tributIcmsCustomDet.valorPrecoMaximo) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Preço Máximo'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.tributIcmsCustomDet.mva != null ? Constantes.formatoDecimalValor.format(widget.tributIcmsCustomDet.mva) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor MVA'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.tributIcmsCustomDet.porcentoBc != null ? Constantes.formatoDecimalTaxa.format(widget.tributIcmsCustomDet.porcentoBc) : 0.toStringAsFixed(Constantes.decimaisTaxa), 'Porcento Base Cálculo'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.tributIcmsCustomDet.modalidadeBcSt ?? '', 'Modalidade Base Cálculo ST'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.tributIcmsCustomDet.aliquotaInternaSt != null ? Constantes.formatoDecimalTaxa.format(widget.tributIcmsCustomDet.aliquotaInternaSt) : 0.toStringAsFixed(Constantes.decimaisTaxa), 'Alíquota Interna ST'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.tributIcmsCustomDet.aliquotaInterestadualSt != null ? Constantes.formatoDecimalTaxa.format(widget.tributIcmsCustomDet.aliquotaInterestadualSt) : 0.toStringAsFixed(Constantes.decimaisTaxa), 'Alíquota Interestadual ST'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.tributIcmsCustomDet.porcentoBcSt != null ? Constantes.formatoDecimalTaxa.format(widget.tributIcmsCustomDet.porcentoBcSt) : 0.toStringAsFixed(Constantes.decimaisTaxa), 'Porcento Base Cálculo ST'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.tributIcmsCustomDet.aliquotaIcmsSt != null ? Constantes.formatoDecimalTaxa.format(widget.tributIcmsCustomDet.aliquotaIcmsSt) : 0.toStringAsFixed(Constantes.decimaisTaxa), 'Alíquota ICMS ST'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.tributIcmsCustomDet.valorPautaSt != null ? Constantes.formatoDecimalValor.format(widget.tributIcmsCustomDet.valorPautaSt) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Pauta ST'),
						ViewUtilLib.getListTileDataDetalhePage(
							widget.tributIcmsCustomDet.valorPrecoMaximoSt != null ? Constantes.formatoDecimalValor.format(widget.tributIcmsCustomDet.valorPrecoMaximoSt) : 0.toStringAsFixed(Constantes.decimaisValor), 'Valor Preço Máximo ST'),
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
