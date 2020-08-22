/*
Title: T2Ti ERP Fenix                                                                
Description: PersistePage relacionada à tabela [NOTA_FISCAL_TIPO] 
                                                                                
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
import 'package:fenix/src/view/shared/valida_campo_formulario.dart';

class NotaFiscalTipoPersistePage extends StatefulWidget {
  final NotaFiscalTipo notaFiscalTipo;
  final String title;
  final String operacao;

  const NotaFiscalTipoPersistePage({Key key, this.notaFiscalTipo, this.title, this.operacao})
      : super(key: key);

  @override
  NotaFiscalTipoPersistePageState createState() => NotaFiscalTipoPersistePageState();
}

class NotaFiscalTipoPersistePageState extends State<NotaFiscalTipoPersistePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool _formFoiAlterado = false;

  @override
  Widget build(BuildContext context) {
    var notaFiscalTipoProvider = Provider.of<NotaFiscalTipoViewModel>(context);
	
	var importaNotaFiscalModeloController = TextEditingController();
	importaNotaFiscalModeloController.text = widget.notaFiscalTipo?.notaFiscalModelo?.descricao ?? '';
	
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
                  await notaFiscalTipoProvider.alterar(widget.notaFiscalTipo);
                } else {
                  await notaFiscalTipoProvider.inserir(widget.notaFiscalTipo);
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
				  					controller: importaNotaFiscalModeloController,
				  					readOnly: true,
				  					decoration: ViewUtilLib.getInputDecorationPersistePage(
				  						'Importe o Modelo da Nota Fiscal Vinculado',
				  						'Modelo NF *',
				  						false),
				  					onSaved: (String value) {
				  					},
				  					validator: ValidaCampoFormulario.validarObrigatorioAlfanumerico,
				  					onChanged: (text) {
				  						widget.notaFiscalTipo?.notaFiscalModelo?.descricao = text;
				  						_formFoiAlterado = true;
				  					},
				  				),
				  			),
				  		),
				  		Expanded(
				  			flex: 0,
				  			child: IconButton(
				  				tooltip: 'Importar Modelo NF',
				  				icon: const Icon(Icons.search),
				  				onPressed: () async {
				  					///chamando o lookup
				  					Map<String, dynamic> objetoJsonRetorno =
				  						await Navigator.push(
				  							context,
				  							MaterialPageRoute(
				  								builder: (BuildContext context) =>
				  									LookupPage(
				  										title: 'Importar Modelo NF',
				  										colunas: NotaFiscalModelo.colunas,
				  										campos: NotaFiscalModelo.campos,
				  										rota: '/nota-fiscal-modelo/',
				  										campoPesquisaPadrao: 'descricao',
				  									),
				  									fullscreenDialog: true,
				  								));
				  				if (objetoJsonRetorno != null) {
				  					if (objetoJsonRetorno['descricao'] != null) {
				  						importaNotaFiscalModeloController.text = objetoJsonRetorno['descricao'];
				  						widget.notaFiscalTipo.idNotaFiscalModelo = objetoJsonRetorno['id'];
				  						widget.notaFiscalTipo.notaFiscalModelo = new NotaFiscalModelo.fromJson(objetoJsonRetorno);
				  					}
				  				}
				  			},
				  		),
				  		),
				  	],
				  ),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 50,
				  	maxLines: 1,
				  	initialValue: widget.notaFiscalTipo?.nome ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Nome do Tipo NF',
				  		'Nome *',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	validator: ValidaCampoFormulario.validarObrigatorioAlfanumerico,
				  	onChanged: (text) {
				  		widget.notaFiscalTipo.nome = text;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 1000,
				  	maxLines: 3,
				  	initialValue: widget.notaFiscalTipo?.descricao ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Descrição do Tipo NF',
				  		'Descrição',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.notaFiscalTipo.descricao = text;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 3,
				  	maxLines: 1,
				  	initialValue: widget.notaFiscalTipo?.serie ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Série do Tipo da NF',
				  		'Série',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.notaFiscalTipo.serie = text;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 3,
				  	maxLines: 1,
				  	initialValue: widget.notaFiscalTipo?.serieScan ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Série SCAN do Tipo da NF',
				  		'Série SCAN',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.notaFiscalTipo.serieScan = text;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
            readOnly: true,
				  	keyboardType: TextInputType.number,
				  	maxLength: 10,
				  	maxLines: 1,
				  	initialValue: widget.notaFiscalTipo?.ultimoNumero?.toString() ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Último Número',
				  		'Último Número',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.notaFiscalTipo.ultimoNumero = int.tryParse(text);
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