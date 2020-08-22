/*
Title: T2Ti ERP Fenix                                                                
Description: AbaMestre PersistePage relacionada à tabela [TABELA_PRECO] 
                                                                                
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
import 'package:fenix/src/view/shared/valida_campo_formulario.dart';

class TabelaPrecoPersistePage extends StatefulWidget {
  final TabelaPreco tabelaPreco;
  final GlobalKey<FormState> formKey;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function atualizaTabelaPrecoCallBack;

  const TabelaPrecoPersistePage(
      {Key key, this.formKey, this.scaffoldKey, this.tabelaPreco, this.atualizaTabelaPrecoCallBack})
      : super(key: key);

  @override
  TabelaPrecoPersistePageState createState() => TabelaPrecoPersistePageState();
}

class TabelaPrecoPersistePageState extends State<TabelaPrecoPersistePage> {
  @override
  Widget build(BuildContext context) {
	var coeficienteController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.tabelaPreco?.coeficiente ?? 0);

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
				  	maxLength: 100,
				  	maxLines: 1,
				  	initialValue: widget.tabelaPreco?.nome ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Nome',
				  		'Nome',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	validator: ValidaCampoFormulario.validarAlfanumerico,
				  	onChanged: (text) {
				  		widget.tabelaPreco.nome = text;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  InputDecorator(
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Selecione a Opção Desejada',
				  		'Principal',
				  		true),
				  	isEmpty: widget.tabelaPreco.principal == null,
				  	child: ViewUtilLib.getDropDownButton(widget.tabelaPreco.principal,
				  		(String newValue) {
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	setState(() {
				  		widget.tabelaPreco.principal = newValue;
				  	});
				  	}, <String>[
				  		'Sim',
				  		'Não',
				  ])),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: coeficienteController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Coeficiente',
				  		'Coeficiente',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.tabelaPreco.coeficiente = coeficienteController.numberValue;
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
