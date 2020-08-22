/*
Title: T2Ti ERP Fenix                                                                
Description: AbaMestre PersistePage relacionada à tabela [TRIBUT_IPI] 
                                                                                
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

class TributIpiPersistePage extends StatefulWidget {
  final TributConfiguraOfGt tributConfiguraOfGt;
  final GlobalKey<FormState> formKey;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const TributIpiPersistePage(
      {Key key, this.formKey, this.scaffoldKey, this.tributConfiguraOfGt})
      : super(key: key);

  @override
  TributIpiPersistePageState createState() =>
      TributIpiPersistePageState();
}

class TributIpiPersistePageState extends State<TributIpiPersistePage> {
  @override
  Widget build(BuildContext context) {
	var porcentoBaseCalculoController = new MoneyMaskedTextController(precision: Constantes.decimaisTaxa, initialValue: widget.tributConfiguraOfGt?.tributIpi?.porcentoBaseCalculo ?? 0);
	var aliquotaPorcentoController = new MoneyMaskedTextController(precision: Constantes.decimaisTaxa, initialValue: widget.tributConfiguraOfGt?.tributIpi?.aliquotaPorcento ?? 0);
	var aliquotaUnidadeController = new MoneyMaskedTextController(precision: Constantes.decimaisTaxa, initialValue: widget.tributConfiguraOfGt?.tributIpi?.aliquotaUnidade ?? 0);
	var valorPrecoMaximoController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.tributConfiguraOfGt?.tributIpi?.valorPrecoMaximo ?? 0);
	var valorPautaFiscalController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.tributConfiguraOfGt?.tributIpi?.valorPautaFiscal ?? 0);
	
    if (widget.tributConfiguraOfGt.tributIpi == null) {
      widget.tributConfiguraOfGt.tributIpi = new TributIpi();
    }

    return Scaffold(
      drawerDragStartBehavior: DragStartBehavior.down,
      key: widget.scaffoldKey,
      body: SafeArea(
        top: false,
        bottom: false,
        child: Form(
          key: widget.formKey,
          autovalidate: true,
          child: Scrollbar(
            child: SingleChildScrollView(
              dragStartBehavior: DragStartBehavior.down,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 2,
				  	maxLines: 1,
				  	initialValue: widget.tributConfiguraOfGt?.tributIpi?.cstIpi ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o CST IPI',
				  		'CST IPI',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.tributConfiguraOfGt.tributIpi?.cstIpi = text;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  InputDecorator(
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Selecione a Opção Desejada',
				  		'Modalidade Base Cálculo',
				  		true),
				  	isEmpty: widget.tributConfiguraOfGt?.tributIpi?.modalidadeBaseCalculo == null ||
				  		widget.tributConfiguraOfGt?.tributIpi == null,
				  	child: ViewUtilLib.getDropDownButton(widget.tributConfiguraOfGt.tributIpi?.modalidadeBaseCalculo,
				  		(String newValue) {
				  	ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	setState(() {
				  		widget.tributConfiguraOfGt.tributIpi?.modalidadeBaseCalculo = newValue;
				  	});
				  	}, <String>[
				  		'0-Percentual',
				  		'1-Unidade',
				  ])),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: porcentoBaseCalculoController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Porcento da Base de Cálculo',
				  		'Porcento Base Cálculo',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.tributConfiguraOfGt.tributIpi.porcentoBaseCalculo = porcentoBaseCalculoController.numberValue;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: aliquotaPorcentoController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Alíquota do Porcento',
				  		'Alíquota Porcento',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.tributConfiguraOfGt.tributIpi.aliquotaPorcento = aliquotaPorcentoController.numberValue;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: aliquotaUnidadeController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Alíquota da Unidade',
				  		'Alíquota Unidade',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.tributConfiguraOfGt.tributIpi.aliquotaUnidade = aliquotaUnidadeController.numberValue;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: valorPrecoMaximoController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Valor Preço Máximo',
				  		'Valor Preço Máximo',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.tributConfiguraOfGt.tributIpi.valorPrecoMaximo = valorPrecoMaximoController.numberValue;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: valorPautaFiscalController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Valor da Pauta Fiscal',
				  		'Valor Pauta Fiscal',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.tributConfiguraOfGt.tributIpi.valorPautaFiscal = valorPautaFiscalController.numberValue;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
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
}