/*
Title: T2Ti ERP Fenix                                                                
Description: AbaDetalhe PersistePage relacionada à tabela [TRIBUT_ICMS_CUSTOM_DET] 
                                                                                
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
import 'package:flutter/gestures.dart';

import 'package:fenix/src/model/model.dart';
import 'package:fenix/src/view/shared/view_util_lib.dart';

import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:fenix/src/infra/constantes.dart';
import 'package:fenix/src/view/shared/dropdown_lista.dart';

class TributIcmsCustomDetPersistePage extends StatefulWidget {
  final TributIcmsCustomCab tributIcmsCustomCab;
  final TributIcmsCustomDet tributIcmsCustomDet;
  final String title;
  final String operacao;

  const TributIcmsCustomDetPersistePage(
      {Key key, this.tributIcmsCustomCab, this.tributIcmsCustomDet, this.title, this.operacao})
      : super(key: key);

  @override
  TributIcmsCustomDetPersistePageState createState() =>
      TributIcmsCustomDetPersistePageState();
}

class TributIcmsCustomDetPersistePageState extends State<TributIcmsCustomDetPersistePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool _formFoiAlterado = false;

  @override
  Widget build(BuildContext context) {
	var aliquotaController = new MoneyMaskedTextController(precision: Constantes.decimaisTaxa, initialValue: widget.tributIcmsCustomDet?.aliquota ?? 0);
	var valorPautaController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.tributIcmsCustomDet?.valorPauta ?? 0);
	var valorPrecoMaximoController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.tributIcmsCustomDet?.valorPrecoMaximo ?? 0);
	var mvaController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.tributIcmsCustomDet?.mva ?? 0);
	var porcentoBcController = new MoneyMaskedTextController(precision: Constantes.decimaisTaxa, initialValue: widget.tributIcmsCustomDet?.porcentoBc ?? 0);
	var aliquotaInternaStController = new MoneyMaskedTextController(precision: Constantes.decimaisTaxa, initialValue: widget.tributIcmsCustomDet?.aliquotaInternaSt ?? 0);
	var aliquotaInterestadualStController = new MoneyMaskedTextController(precision: Constantes.decimaisTaxa, initialValue: widget.tributIcmsCustomDet?.aliquotaInterestadualSt ?? 0);
	var porcentoBcStController = new MoneyMaskedTextController(precision: Constantes.decimaisTaxa, initialValue: widget.tributIcmsCustomDet?.porcentoBcSt ?? 0);
	var aliquotaIcmsStController = new MoneyMaskedTextController(precision: Constantes.decimaisTaxa, initialValue: widget.tributIcmsCustomDet?.aliquotaIcmsSt ?? 0);
	var valorPautaStController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.tributIcmsCustomDet?.valorPautaSt ?? 0);
	var valorPrecoMaximoStController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.tributIcmsCustomDet?.valorPrecoMaximoSt ?? 0);
	
    return Scaffold(
      drawerDragStartBehavior: DragStartBehavior.down,
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: ViewUtilLib.getIconBotaoSalvar(),
            onPressed: () async {
              final FormState form = _formKey.currentState;
              if (!form.validate()) {
                _autoValidate = true;
                ViewUtilLib.showInSnackBar(
                    'Por favor, corrija os erros apresentados antes de continuar.',
                    _scaffoldKey);
              } else {
                form.save();
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Form(
          key: _formKey,
          autovalidate: _autoValidate,
          onWillPop: _avisarUsuarioFormAlterado,
          child: Scrollbar(
            child: SingleChildScrollView(
              dragStartBehavior: DragStartBehavior.down,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
				  const SizedBox(height: 24.0),
				  InputDecorator(
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a UF de Destino',
				  		'UF',
				  		true),
				  	isEmpty: widget.tributIcmsCustomDet.ufDestino == null,
				  	child: ViewUtilLib.getDropDownButton(widget.tributIcmsCustomDet.ufDestino,
				  		(String newValue) {
				  	ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	setState(() {
				  		widget.tributIcmsCustomDet.ufDestino = newValue;
				  	});
				  	}, DropdownLista.listaUF)),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 10,
				  	maxLines: 1,
				  	initialValue: widget.tributIcmsCustomDet?.cfop?.toString() ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o CFOP',
				  		'CFOP',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.tributIcmsCustomDet.cfop = int.tryParse(text);
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 3,
				  	maxLines: 1,
				  	initialValue: widget.tributIcmsCustomDet?.csosn ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o CSOSN',
				  		'CSOSN',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.tributIcmsCustomDet.csosn = text;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 2,
				  	maxLines: 1,
				  	initialValue: widget.tributIcmsCustomDet?.cst ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o CST',
				  		'CST',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.tributIcmsCustomDet.cst = text;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  InputDecorator(
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Selecione a Opção Desejada',
				  		'Modalidade Base Cálculo',
				  		true),
				  	isEmpty: widget.tributIcmsCustomDet.modalidadeBc == null,
				  	child: ViewUtilLib.getDropDownButton(widget.tributIcmsCustomDet.modalidadeBc,
				  		(String newValue) {
				  	ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	setState(() {
				  		widget.tributIcmsCustomDet.modalidadeBc = newValue;
				  	});
				  	}, <String>[
				  		'0-Margem Valor Agregado (%)',
				  		'1-Pauta (Valor)',
				  		'2-Preço Tabelado Máx. (valor)',
				  		'3-Valor da Operação',
				  ])),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: aliquotaController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Alíquota caso Modalidade BC=3',
				  		'Alíquota',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.tributIcmsCustomDet.aliquota = aliquotaController.numberValue;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: valorPautaController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Valor Pauta, caso Modalidade BC=1',
				  		'Valor Pauta',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.tributIcmsCustomDet.valorPauta = valorPautaController.numberValue;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: valorPrecoMaximoController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Valor Preço Máximo, caso Modalidade BC=2',
				  		'Valor Preço Máximo',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.tributIcmsCustomDet.valorPrecoMaximo = valorPrecoMaximoController.numberValue;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: mvaController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Valor da Margem Valor Agregado',
				  		'Valor MVA',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.tributIcmsCustomDet.mva = mvaController.numberValue;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: porcentoBcController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Porcentual da Base de Cálculo',
				  		'Porcento Base Cálculo',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.tributIcmsCustomDet.porcentoBc = porcentoBcController.numberValue;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  InputDecorator(
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Selecione a Opção Desejada',
				  		'Modalidade Base Cálculo ST',
				  		true),
				  	isEmpty: widget.tributIcmsCustomDet.modalidadeBcSt == null,
				  	child: ViewUtilLib.getDropDownButton(widget.tributIcmsCustomDet.modalidadeBcSt,
				  		(String newValue) {
				  	ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	setState(() {
				  		widget.tributIcmsCustomDet.modalidadeBcSt = newValue;
				  	});
				  	}, <String>[
				  		'0-Preço tabelado ou máximo sugerido',
				  		'1-Lista Negativa (valor)',
				  		'2-Lista Positiva (valor)',
				  		'3-Lista Neutra (valor)',
				  		'4-Margem Valor Agregado (%)',
				  		'5-Pauta (valor)',
				  ])),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: aliquotaInternaStController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Alíquota Interna ST',
				  		'Alíquota Interna ST',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.tributIcmsCustomDet.aliquotaInternaSt = aliquotaInternaStController.numberValue;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: aliquotaInterestadualStController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Alíquota Interestadual ST',
				  		'Alíquota Interestadual ST',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.tributIcmsCustomDet.aliquotaInterestadualSt = aliquotaInterestadualStController.numberValue;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: porcentoBcStController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Porcentual da Base de Cálculo ST',
				  		'Porcento Base Cálculo ST',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.tributIcmsCustomDet.porcentoBcSt = porcentoBcStController.numberValue;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: aliquotaIcmsStController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Alíquota ICMS ST',
				  		'Alíquota ICMS ST',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.tributIcmsCustomDet.aliquotaIcmsSt = aliquotaIcmsStController.numberValue;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: valorPautaStController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Valor Pauta ST, caso Modalidade BC ST=5',
				  		'Valor Pauta ST',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.tributIcmsCustomDet.valorPautaSt = valorPautaStController.numberValue;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: valorPrecoMaximoStController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Valor Preço Máximo ST, caso Modalidade BC ST=0',
				  		'Valor Preço Máximo ST',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.tributIcmsCustomDet.valorPrecoMaximoSt = valorPrecoMaximoStController.numberValue;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  		_formFoiAlterado = true;
				  	},
				  	),
                  const SizedBox(height: 24.0),
                  Text(
                    '* indica que o campo é obrigatório',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  const SizedBox(height: 24.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _avisarUsuarioFormAlterado() async {
    final FormState form = _formKey.currentState;
    if (form == null || !_formFoiAlterado) return true;

    return await ViewUtilLib.gerarDialogBoxFormAlterado(context);
  }
}
