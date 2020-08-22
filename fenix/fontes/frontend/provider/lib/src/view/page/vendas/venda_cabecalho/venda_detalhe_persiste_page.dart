/*
Title: T2Ti ERP Fenix                                                                
Description: AbaDetalhe PersistePage relacionada à tabela [VENDA_DETALHE] 
                                                                                
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
import 'package:fenix/src/infra/biblioteca.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:fenix/src/model/model.dart';
import 'package:fenix/src/view/shared/view_util_lib.dart';

import 'package:fenix/src/view/shared/lookup_page.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:fenix/src/infra/constantes.dart';
import 'package:fenix/src/view/shared/valida_campo_formulario.dart';

class VendaDetalhePersistePage extends StatefulWidget {
  final VendaCabecalho vendaCabecalho;
  final VendaDetalhe vendaDetalhe;
  final String title;
  final String operacao;

  const VendaDetalhePersistePage(
      {Key key, this.vendaCabecalho, this.vendaDetalhe, this.title, this.operacao})
      : super(key: key);

  @override
  VendaDetalhePersistePageState createState() =>
      VendaDetalhePersistePageState();
}

class VendaDetalhePersistePageState extends State<VendaDetalhePersistePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool _formFoiAlterado = false;

  @override
  Widget build(BuildContext context) {
	var importaProdutoController = TextEditingController();
	importaProdutoController.text = widget.vendaDetalhe?.produto?.nome ?? '';
	var quantidadeController = new MoneyMaskedTextController(precision: Constantes.decimaisQuantidade, initialValue: widget.vendaDetalhe?.quantidade ?? 0);
	var valorUnitarioController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.vendaDetalhe?.valorUnitario ?? 0);
	var valorSubtotalController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.vendaDetalhe?.valorSubtotal ?? 0);
	var taxaDescontoController = new MoneyMaskedTextController(precision: Constantes.decimaisTaxa, initialValue: widget.vendaDetalhe?.taxaDesconto ?? 0);
	var valorDescontoController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.vendaDetalhe?.valorDesconto ?? 0);
	var valorTotalController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.vendaDetalhe?.valorTotal ?? 0);
	
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
				  					validator: ValidaCampoFormulario.validarObrigatorioAlfanumerico,
				  					onChanged: (text) {
				  						widget.vendaDetalhe?.produto?.nome = text;
				  						ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
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
                              valorPesquisaPadrao: '%',
				  									),
				  									fullscreenDialog: true,
				  								));
				  				if (objetoJsonRetorno != null) {
				  					if (objetoJsonRetorno['nome'] != null) {
				  						importaProdutoController.text = objetoJsonRetorno['nome'];
				  						widget.vendaDetalhe.idProduto = objetoJsonRetorno['id'];
                      widget.vendaDetalhe.valorUnitario = objetoJsonRetorno['valorVenda'].toDouble();
				  						widget.vendaDetalhe.produto = new Produto.fromJson(objetoJsonRetorno);
                      atualizarTotais();
				  					}
				  				}
				  			},
				  		),
				  		),
				  	],
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
				  		widget.vendaDetalhe.quantidade = quantidadeController.numberValue;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  		_formFoiAlterado = true;
              atualizarTotais();
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
            readOnly: true,
				  	keyboardType: TextInputType.number,
				  	controller: valorUnitarioController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Valor Unitário',
				  		'Valor Unitário',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.vendaDetalhe.valorUnitario = valorUnitarioController.numberValue;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
            readOnly: true,
				  	keyboardType: TextInputType.number,
				  	controller: valorSubtotalController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Valor Subtotal',
				  		'Valor Subtotal',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.vendaDetalhe.valorSubtotal = valorSubtotalController.numberValue;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: taxaDescontoController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Taxa de Desconto',
				  		'Taxa Desconto',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.vendaDetalhe.taxaDesconto = taxaDescontoController.numberValue;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  		_formFoiAlterado = true;
              atualizarTotais();
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
            readOnly: true,
				  	keyboardType: TextInputType.number,
				  	controller: valorDescontoController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Valor do Desconto',
				  		'Valor Desconto',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.vendaDetalhe.valorDesconto = valorDescontoController.numberValue;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
            readOnly: true,
				  	keyboardType: TextInputType.number,
				  	controller: valorTotalController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Valor Total',
				  		'Valor Total',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.vendaDetalhe.valorTotal = valorTotalController.numberValue;
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

  atualizarTotais() {
    setState(() {
      widget.vendaDetalhe.valorSubtotal = Biblioteca.multiplicarMonetario(widget.vendaDetalhe.quantidade, widget.vendaDetalhe.valorUnitario);
      widget.vendaDetalhe.valorDesconto = Biblioteca.calcularDesconto(widget.vendaDetalhe.valorSubtotal, widget.vendaDetalhe.taxaDesconto);
      widget.vendaDetalhe.valorTotal = widget.vendaDetalhe.valorSubtotal - widget.vendaDetalhe.valorDesconto;
    });
  }

  Future<bool> _avisarUsuarioFormAlterado() async {
    final FormState form = _formKey.currentState;
    if (form == null || !_formFoiAlterado) return true;

    return await ViewUtilLib.gerarDialogBoxFormAlterado(context);
  }
}
