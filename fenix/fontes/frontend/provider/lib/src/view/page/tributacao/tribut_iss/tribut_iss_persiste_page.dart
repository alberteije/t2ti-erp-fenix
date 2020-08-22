/*
Title: T2Ti ERP Fenix                                                                
Description: PersistePage relacionada à tabela [TRIBUT_ISS] 
                                                                                
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
import 'package:provider/provider.dart';

import 'package:fenix/src/model/model.dart';
import 'package:fenix/src/view_model/view_model.dart';
import 'package:fenix/src/view/shared/view_util_lib.dart';

import 'package:fenix/src/view/shared/lookup_page.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:fenix/src/infra/constantes.dart';
import 'package:fenix/src/view/shared/valida_campo_formulario.dart';

class TributIssPersistePage extends StatefulWidget {
  final TributIss tributIss;
  final String title;
  final String operacao;

  const TributIssPersistePage({Key key, this.tributIss, this.title, this.operacao})
      : super(key: key);

  @override
  TributIssPersistePageState createState() => TributIssPersistePageState();
}

class TributIssPersistePageState extends State<TributIssPersistePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool _formFoiAlterado = false;

  @override
  Widget build(BuildContext context) {
    var tributIssProvider = Provider.of<TributIssViewModel>(context);
	
	var importaTributOperacaoFiscalController = TextEditingController();
	importaTributOperacaoFiscalController.text = widget.tributIss?.tributOperacaoFiscal?.descricao ?? '';
	var porcentoBaseCalculoController = new MoneyMaskedTextController(precision: Constantes.decimaisTaxa, initialValue: widget.tributIss?.porcentoBaseCalculo ?? 0);
	var aliquotaPorcentoController = new MoneyMaskedTextController(precision: Constantes.decimaisTaxa, initialValue: widget.tributIss?.aliquotaPorcento ?? 0);
	var aliquotaUnidadeController = new MoneyMaskedTextController(precision: Constantes.decimaisTaxa, initialValue: widget.tributIss?.aliquotaUnidade ?? 0);
	var valorPrecoMaximoController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.tributIss?.valorPrecoMaximo ?? 0);
	var valorPautaFiscalController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.tributIss?.valorPautaFiscal ?? 0);
	
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
                if (widget.operacao == 'A') {
                  await tributIssProvider.alterar(widget.tributIss);
                } else {
                  await tributIssProvider.inserir(widget.tributIss);
                }
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
				  Row(
				  	children: <Widget>[
				  		Expanded(
				  			flex: 1,
				  			child: Container(
				  				child: TextFormField(
				  					controller: importaTributOperacaoFiscalController,
				  					readOnly: true,
				  					decoration: ViewUtilLib.getInputDecorationPersistePage(
				  						'Importe a Operação Fiscal Vinculada',
				  						'Operação Fiscal *',
				  						false),
				  					onSaved: (String value) {
				  					},
				  					validator: ValidaCampoFormulario.validarObrigatorioAlfanumerico,
				  					onChanged: (text) {
				  						widget.tributIss?.tributOperacaoFiscal?.descricao = text;
				  						_formFoiAlterado = true;
				  					},
				  				),
				  			),
				  		),
				  		Expanded(
				  			flex: 0,
				  			child: IconButton(
				  				tooltip: 'Importar Operação Fiscal',
				  				icon: const Icon(Icons.search),
				  				onPressed: () async {
				  					///chamando o lookup
				  					Map<String, dynamic> objetoJsonRetorno =
				  						await Navigator.push(
				  							context,
				  							MaterialPageRoute(
				  								builder: (BuildContext context) =>
				  									LookupPage(
				  										title: 'Importar Operação Fiscal',
				  										colunas: TributOperacaoFiscal.colunas,
				  										campos: TributOperacaoFiscal.campos,
				  										rota: '/tribut-operacao-fiscal/',
				  										campoPesquisaPadrao: 'descricao',
				  									),
				  									fullscreenDialog: true,
				  								));
				  				if (objetoJsonRetorno != null) {
				  					if (objetoJsonRetorno['descricao'] != null) {
				  						importaTributOperacaoFiscalController.text = objetoJsonRetorno['descricao'];
				  						widget.tributIss.idTributOperacaoFiscal = objetoJsonRetorno['id'];
				  						widget.tributIss.tributOperacaoFiscal = new TributOperacaoFiscal.fromJson(objetoJsonRetorno);
				  					}
				  				}
				  			},
				  		),
				  		),
				  	],
				  ),
				  const SizedBox(height: 24.0),
				  InputDecorator(
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Selecione a Opção Desejada',
				  		'Modalidade Base Cálculo',
				  		true),
				  	isEmpty: widget.tributIss.modalidadeBaseCalculo == null,
				  	child: ViewUtilLib.getDropDownButton(widget.tributIss.modalidadeBaseCalculo,
				  		(String newValue) {
				  	setState(() {
				  		widget.tributIss.modalidadeBaseCalculo = newValue;
				  	});
				  	}, <String>[
				  		'0-Valor Operação',
				  		'9-Outros',
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
				  		widget.tributIss.porcentoBaseCalculo = porcentoBaseCalculoController.numberValue;
				  		_formFoiAlterado = true;
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
				  		widget.tributIss.aliquotaPorcento = aliquotaPorcentoController.numberValue;
				  		_formFoiAlterado = true;
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
				  		widget.tributIss.aliquotaUnidade = aliquotaUnidadeController.numberValue;
				  		_formFoiAlterado = true;
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
				  		widget.tributIss.valorPrecoMaximo = valorPrecoMaximoController.numberValue;
				  		_formFoiAlterado = true;
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
				  		widget.tributIss.valorPautaFiscal = valorPautaFiscalController.numberValue;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	maxLength: 10,
				  	maxLines: 1,
				  	initialValue: widget.tributIss?.itemListaServico?.toString() ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Item da Lista de Serviço',
				  		'Item Lista Serviço',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.tributIss.itemListaServico = int.tryParse(text);
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  InputDecorator(
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Selecione a Opção Desejada',
				  		'Código Tributação',
				  		true),
				  	isEmpty: widget.tributIss.codigoTributacao == null,
				  	child: ViewUtilLib.getDropDownButton(widget.tributIss.codigoTributacao,
				  		(String newValue) {
				  	setState(() {
				  		widget.tributIss.codigoTributacao = newValue;
				  	});
				  	}, <String>[
				  		'Normal',
				  		'Retida',
				  		'Substituta',
				  		'Isenta',
				  ])),
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