/*
Title: T2Ti ERP Fenix                                                                
Description: PersistePage relacionada à tabela [COMISSAO_OBJETIVO] 
                                                                                
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

class ComissaoObjetivoPersistePage extends StatefulWidget {
  final ComissaoObjetivo comissaoObjetivo;
  final String title;
  final String operacao;

  const ComissaoObjetivoPersistePage({Key key, this.comissaoObjetivo, this.title, this.operacao})
      : super(key: key);

  @override
  ComissaoObjetivoPersistePageState createState() => ComissaoObjetivoPersistePageState();
}

class ComissaoObjetivoPersistePageState extends State<ComissaoObjetivoPersistePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool _formFoiAlterado = false;

  @override
  Widget build(BuildContext context) {
    var comissaoObjetivoProvider = Provider.of<ComissaoObjetivoViewModel>(context);
	
    var importaProdutoController = TextEditingController();
    importaProdutoController.text = widget.comissaoObjetivo?.produto?.nome ?? '';
    var taxaPagamentoController = new MoneyMaskedTextController(precision: Constantes.decimaisTaxa, initialValue: widget.comissaoObjetivo?.taxaPagamento ?? 0);
    var valorPagamentoController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.comissaoObjetivo?.valorPagamento ?? 0);
    var valorMetaController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.comissaoObjetivo?.valorMeta ?? 0);
    var quantidadeController = new MoneyMaskedTextController(precision: Constantes.decimaisQuantidade, initialValue: widget.comissaoObjetivo?.quantidade ?? 0);
	
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
                  await comissaoObjetivoProvider.alterar(widget.comissaoObjetivo);
                } else {
                  await comissaoObjetivoProvider.inserir(widget.comissaoObjetivo);
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
				  					controller: importaProdutoController,
				  					readOnly: true,
				  					decoration: ViewUtilLib.getInputDecorationPersistePage(
				  						'Importe o Produto Vinculado',
				  						'Produto *',
				  						false),
				  					onSaved: (String value) {
				  					},
				  					onChanged: (text) {
				  						widget.comissaoObjetivo?.produto?.nome = text;
				  						_formFoiAlterado = true;
				  					},
				  				),
				  			),
				  		),
				  		Expanded(
				  			flex: 0,
				  			child: IconButton(
				  				tooltip: 'Importar Produto',
				  				icon: const Icon(Icons.search),
				  				onPressed: () async {
				  					///chamando o lookup
				  					Map<String, dynamic> objetoJsonRetorno =
				  						await Navigator.push(
				  							context,
				  							MaterialPageRoute(
				  								builder: (BuildContext context) =>
				  									LookupPage(
				  										title: 'Importar Produto',
				  										colunas: Produto.colunas,
				  										campos: Produto.campos,
				  										rota: '/produto/',
				  										campoPesquisaPadrao: 'nome',
				  										valorPesquisaPadrao: '',
				  									),
				  									fullscreenDialog: true,
				  								));
				  				if (objetoJsonRetorno != null) {
				  					if (objetoJsonRetorno['nome'] != null) {
				  						importaProdutoController.text = objetoJsonRetorno['nome'];
				  						widget.comissaoObjetivo.idProduto = objetoJsonRetorno['id'];
				  						widget.comissaoObjetivo.produto = new Produto.fromJson(objetoJsonRetorno);
				  					}
				  				}
				  			},
				  		),
				  		),
				  	],
				  ),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 3,
				  	maxLines: 1,
				  	initialValue: widget.comissaoObjetivo?.codigo ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Código',
				  		'Código',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.comissaoObjetivo.codigo = text;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 100,
				  	maxLines: 1,
				  	initialValue: widget.comissaoObjetivo?.nome ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Nome',
				  		'Nome',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	validator: ValidaCampoFormulario.validarAlfanumerico,
				  	onChanged: (text) {
				  		widget.comissaoObjetivo.nome = text;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 1000,
				  	maxLines: 3,
				  	initialValue: widget.comissaoObjetivo?.descricao ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Descrição',
				  		'Descrição',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.comissaoObjetivo.descricao = text;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  InputDecorator(
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Selecione a Opção Desejada',
				  		'Forma de Pagamento',
				  		true),
				  	isEmpty: widget.comissaoObjetivo.formaPagamento == null,
				  	child: ViewUtilLib.getDropDownButton(widget.comissaoObjetivo.formaPagamento,
				  		(String newValue) {
				  	setState(() {
				  		widget.comissaoObjetivo.formaPagamento = newValue;
				  	});
				  	}, <String>[
				  		'Valor Fixo',
				  		'Percentual',
				  ])),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: taxaPagamentoController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Taxa de Pagamento',
				  		'Taxa Pagamento',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.comissaoObjetivo.taxaPagamento = taxaPagamentoController.numberValue;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: valorPagamentoController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Valor Pagamento',
				  		'Valor Pagamento',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.comissaoObjetivo.valorPagamento = valorPagamentoController.numberValue;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: valorMetaController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Valor Meta',
				  		'Valor Meta',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.comissaoObjetivo.valorMeta = valorMetaController.numberValue;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: quantidadeController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Quantidade',
				  		'Quantidade',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.comissaoObjetivo.quantidade = quantidadeController.numberValue;
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