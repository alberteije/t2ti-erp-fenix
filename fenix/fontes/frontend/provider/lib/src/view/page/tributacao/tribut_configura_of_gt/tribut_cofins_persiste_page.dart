/*
Title: T2Ti ERP Fenix                                                                
Description: AbaMestre PersistePage relacionada à tabela [TRIBUT_COFINS] 
                                                                                
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

class TributCofinsPersistePage extends StatefulWidget {
  final TributConfiguraOfGt tributConfiguraOfGt;
  final GlobalKey<FormState> formKey;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const TributCofinsPersistePage(
      {Key key, this.formKey, this.scaffoldKey, this.tributConfiguraOfGt})
      : super(key: key);

  @override
  TributCofinsPersistePageState createState() =>
      TributCofinsPersistePageState();
}

class TributCofinsPersistePageState extends State<TributCofinsPersistePage> {
  @override
  Widget build(BuildContext context) {
	var porcentoBaseCalculoController = new MoneyMaskedTextController(precision: Constantes.decimaisTaxa, initialValue: widget.tributConfiguraOfGt?.tributCofins?.porcentoBaseCalculo ?? 0);
	var aliquotaPorcentoController = new MoneyMaskedTextController(precision: Constantes.decimaisTaxa, initialValue: widget.tributConfiguraOfGt?.tributCofins?.aliquotaPorcento ?? 0);
	var aliquotaUnidadeController = new MoneyMaskedTextController(precision: Constantes.decimaisTaxa, initialValue: widget.tributConfiguraOfGt?.tributCofins?.aliquotaUnidade ?? 0);
	var valorPrecoMaximoController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.tributConfiguraOfGt?.tributCofins?.valorPrecoMaximo ?? 0);
	var valorPautaFiscalController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.tributConfiguraOfGt?.tributCofins?.valorPautaFiscal ?? 0);
	
    if (widget.tributConfiguraOfGt.tributCofins == null) {
      widget.tributConfiguraOfGt.tributCofins = new TributCofins();
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
				  	initialValue: widget.tributConfiguraOfGt?.tributCofins?.cstCofins ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o CST COFINS',
				  		'CST COFINS',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.tributConfiguraOfGt.tributCofins?.cstCofins = text;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 2,
				  	maxLines: 1,
				  	initialValue: widget.tributConfiguraOfGt?.tributCofins?.efdTabela435 ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o EFD 435',
				  		'EFD 435',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.tributConfiguraOfGt.tributCofins?.efdTabela435 = text;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  InputDecorator(
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Selecione a Opção Desejada',
				  		'Modalidade Base Cálculo',
				  		true),
				  	isEmpty: widget.tributConfiguraOfGt?.tributCofins?.modalidadeBaseCalculo == null ||
				  		widget.tributConfiguraOfGt?.tributCofins == null,
				  	child: ViewUtilLib.getDropDownButton(widget.tributConfiguraOfGt.tributCofins?.modalidadeBaseCalculo,
				  		(String newValue) {
				  	ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	setState(() {
				  		widget.tributConfiguraOfGt.tributCofins?.modalidadeBaseCalculo = newValue;
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
				  		widget.tributConfiguraOfGt.tributCofins.porcentoBaseCalculo = porcentoBaseCalculoController.numberValue;
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
				  		widget.tributConfiguraOfGt.tributCofins.aliquotaPorcento = aliquotaPorcentoController.numberValue;
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
				  		widget.tributConfiguraOfGt.tributCofins.aliquotaUnidade = aliquotaUnidadeController.numberValue;
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
				  		widget.tributConfiguraOfGt.tributCofins.valorPrecoMaximo = valorPrecoMaximoController.numberValue;
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
				  		widget.tributConfiguraOfGt.tributCofins.valorPautaFiscal = valorPautaFiscalController.numberValue;
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