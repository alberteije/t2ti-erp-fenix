/*
Title: T2Ti ERP Fenix                                                                
Description: AbaMestre PersistePage relacionada à tabela [COMPRA_PEDIDO] 
                                                                                
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

import 'package:fenix/src/view/shared/lookup_page.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:fenix/src/infra/constantes.dart';
import 'package:fenix/src/view/shared/valida_campo_formulario.dart';

class CompraPedidoPersistePage extends StatefulWidget {
  final CompraPedido compraPedido;
  final GlobalKey<FormState> formKey;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function atualizaCompraPedidoCallBack;

  const CompraPedidoPersistePage(
      {Key key, this.formKey, this.scaffoldKey, this.compraPedido, this.atualizaCompraPedidoCallBack})
      : super(key: key);

  @override
  CompraPedidoPersistePageState createState() => CompraPedidoPersistePageState();
}

class CompraPedidoPersistePageState extends State<CompraPedidoPersistePage> {
  @override
  Widget build(BuildContext context) {
	var importaCompraTipoPedidoController = TextEditingController();
	importaCompraTipoPedidoController.text = widget.compraPedido?.compraTipoPedido?.nome ?? '';
	var importaFornecedorController = TextEditingController();
	importaFornecedorController.text = widget.compraPedido?.fornecedor?.pessoa?.nome ?? '';
	var importaColaboradorController = TextEditingController();
	importaColaboradorController.text = widget.compraPedido?.colaborador?.pessoa?.nome ?? '';
	var valorSubtotalController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.compraPedido?.valorSubtotal ?? 0);
	var taxaDescontoController = new MoneyMaskedTextController(precision: Constantes.decimaisTaxa, initialValue: widget.compraPedido?.taxaDesconto ?? 0);
	var valorDescontoController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.compraPedido?.valorDesconto ?? 0);
	var valorTotalController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.compraPedido?.valorTotal ?? 0);
	var baseCalculoIcmsController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.compraPedido?.baseCalculoIcms ?? 0);
	var valorIcmsController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.compraPedido?.valorIcms ?? 0);
	var baseCalculoIcmsStController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.compraPedido?.baseCalculoIcmsSt ?? 0);
	var valorIcmsStController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.compraPedido?.valorIcmsSt ?? 0);
	var valorTotalProdutosController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.compraPedido?.valorTotalProdutos ?? 0);
	var valorFreteController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.compraPedido?.valorFrete ?? 0);
	var valorSeguroController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.compraPedido?.valorSeguro ?? 0);
	var valorOutrasDespesasController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.compraPedido?.valorOutrasDespesas ?? 0);
	var valorIpiController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.compraPedido?.valorIpi ?? 0);
	var valorTotalNfController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.compraPedido?.valorTotalNf ?? 0);
	var diaPrimeiroVencimentoController = new MaskedTextController(
		mask: Constantes.mascaraDIA,
		text: widget.compraPedido?.diaPrimeiroVencimento ?? '',
	);
	var diaFixoParcelaController = new MaskedTextController(
		mask: Constantes.mascaraDIA,
		text: widget.compraPedido?.diaFixoParcela ?? '',
	);

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
				  Row(
				  	children: <Widget>[
				  		Expanded(
				  			flex: 1,
				  			child: Container(
				  				child: TextFormField(
				  					controller: importaCompraTipoPedidoController,
				  					readOnly: true,
				  					decoration: ViewUtilLib.getInputDecorationPersistePage(
				  						'Importe o Tipo de Pedido Vinculado',
				  						'Tipo Pedido *',
				  						false),
				  					onSaved: (String value) {
				  					},
				  					validator: ValidaCampoFormulario.validarObrigatorioAlfanumerico,
				  					onChanged: (text) {
				  						widget.compraPedido?.compraTipoPedido?.nome = text;
				  						ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  					},
				  				),
				  			),
				  		),
				  		Expanded(
				  			flex: 0,
				  			child: IconButton(
				  				tooltip: 'Importar Tipo Pedido',
				  				icon: const Icon(Icons.search),
				  				onPressed: () async {
				  					///chamando o lookup
				  					Map<String, dynamic> objetoJsonRetorno =
				  						await Navigator.push(
				  							context,
				  							MaterialPageRoute(
				  								builder: (BuildContext context) =>
				  									LookupPage(
				  										title: 'Importar Tipo Pedido',
				  										colunas: CompraTipoPedido.colunas,
				  										campos: CompraTipoPedido.campos,
				  										rota: '/compra-tipo-pedido/',
				  										campoPesquisaPadrao: 'nome',
                              valorPesquisaPadrao: '%',
				  									),
				  									fullscreenDialog: true,
				  								));
				  				if (objetoJsonRetorno != null) {
				  					if (objetoJsonRetorno['nome'] != null) {
				  						importaCompraTipoPedidoController.text = objetoJsonRetorno['nome'];
				  						widget.compraPedido.idCompraTipoPedido = objetoJsonRetorno['id'];
				  						widget.compraPedido.compraTipoPedido = new CompraTipoPedido.fromJson(objetoJsonRetorno);
				  					}
				  				}
				  			},
				  		),
				  		),
				  	],
				  ),
				  const SizedBox(height: 24.0),
				  Row(
				  	children: <Widget>[
				  		Expanded(
				  			flex: 1,
				  			child: Container(
				  				child: TextFormField(
				  					controller: importaFornecedorController,
				  					readOnly: true,
				  					decoration: ViewUtilLib.getInputDecorationPersistePage(
				  						'Importe o Fornecedor Vinculado',
				  						'Fornecedor *',
				  						false),
				  					onSaved: (String value) {
				  					},
				  					validator: ValidaCampoFormulario.validarObrigatorioAlfanumerico,
				  					onChanged: (text) {
				  						widget.compraPedido?.fornecedor?.pessoa?.nome = text;
				  						ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  					},
				  				),
				  			),
				  		),
				  		Expanded(
				  			flex: 0,
				  			child: IconButton(
				  				tooltip: 'Importar Fornecedor',
				  				icon: const Icon(Icons.search),
				  				onPressed: () async {
				  					///chamando o lookup
				  					Map<String, dynamic> objetoJsonRetorno =
				  						await Navigator.push(
				  							context,
				  							MaterialPageRoute(
				  								builder: (BuildContext context) =>
				  									LookupPage(
				  										title: 'Importar Fornecedor',
				  										colunas: ViewPessoaFornecedor.colunas,
				  										campos: ViewPessoaFornecedor.campos,
				  										rota: '/view-pessoa-fornecedor/',
				  										campoPesquisaPadrao: 'nome',
                              valorPesquisaPadrao: '%',
				  									),
				  									fullscreenDialog: true,
				  								));
				  				if (objetoJsonRetorno != null) {
				  					if (objetoJsonRetorno['nome'] != null) {
				  						importaFornecedorController.text = objetoJsonRetorno['nome'];
				  						widget.compraPedido.idFornecedor = objetoJsonRetorno['id'];
				  						widget.compraPedido.fornecedor = new Fornecedor.fromJson(objetoJsonRetorno);
                      widget.compraPedido.fornecedor.pessoa = new Pessoa(nome: objetoJsonRetorno['nome']);
				  					}
				  				}
				  			},
				  		),
				  		),
				  	],
				  ),
				  const SizedBox(height: 24.0),
				  Row(
				  	children: <Widget>[
				  		Expanded(
				  			flex: 1,
				  			child: Container(
				  				child: TextFormField(
				  					controller: importaColaboradorController,
				  					readOnly: true,
				  					decoration: ViewUtilLib.getInputDecorationPersistePage(
				  						'Importe o Colaborador Vinculado',
				  						'Colaborador *',
				  						false),
				  					onSaved: (String value) {
				  					},
				  					validator: ValidaCampoFormulario.validarObrigatorioAlfanumerico,
				  					onChanged: (text) {
				  						widget.compraPedido?.colaborador?.pessoa?.nome = text;
				  						ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  					},
				  				),
				  			),
				  		),
				  		Expanded(
				  			flex: 0,
				  			child: IconButton(
				  				tooltip: 'Importar Colaborador',
				  				icon: const Icon(Icons.search),
				  				onPressed: () async {
				  					///chamando o lookup
				  					Map<String, dynamic> objetoJsonRetorno =
				  						await Navigator.push(
				  							context,
				  							MaterialPageRoute(
				  								builder: (BuildContext context) =>
				  									LookupPage(
				  										title: 'Importar Colaborador',
				  										colunas: ViewPessoaColaborador.colunas,
				  										campos: ViewPessoaColaborador.campos,
				  										rota: '/view-pessoa-colaborador/',
				  										campoPesquisaPadrao: 'nome',
                              valorPesquisaPadrao: '%',
				  									),
				  									fullscreenDialog: true,
				  								));
				  				if (objetoJsonRetorno != null) {
				  					if (objetoJsonRetorno['nome'] != null) {
				  						importaColaboradorController.text = objetoJsonRetorno['nome'];
				  						widget.compraPedido.idColaborador = objetoJsonRetorno['id'];
				  						widget.compraPedido.colaborador = new Colaborador.fromJson(objetoJsonRetorno);
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
				  		'Informe a Data do Pedido',
				  		'Data do Pedido',
				  		true),
				  	isEmpty: widget.compraPedido.dataPedido == null,
				  	child: DatePickerItem(
				  		dateTime: widget.compraPedido.dataPedido,
				  		firstDate: DateTime.parse('1900-01-01'),
				  		lastDate: DateTime.now(),
				  		onChanged: (DateTime value) {
				  			ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  			setState(() {
				  				widget.compraPedido.dataPedido = value;
				  			});
				  		},
				  	),
				  ),
				  const SizedBox(height: 24.0),
				  InputDecorator(
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Data Prevista para Entrega',
				  		'Data Prevista para Entrega',
				  		true),
				  	isEmpty: widget.compraPedido.dataPrevistaEntrega == null,
				  	child: DatePickerItem(
				  		dateTime: widget.compraPedido.dataPrevistaEntrega,
				  		firstDate: DateTime.now(),
				  		lastDate: DateTime.parse('2050-01-01'),
				  		onChanged: (DateTime value) {
				  			ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  			setState(() {
				  				widget.compraPedido.dataPrevistaEntrega = value;
				  			});
				  		},
				  	),
				  ),
				  const SizedBox(height: 24.0),
				  InputDecorator(
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Data de Previsão do Pagamento',
				  		'Data Previsão Pagamento',
				  		true),
				  	isEmpty: widget.compraPedido.dataPrevisaoPagamento == null,
				  	child: DatePickerItem(
				  		dateTime: widget.compraPedido.dataPrevisaoPagamento,
				  		firstDate: DateTime.now(),
				  		lastDate: DateTime.parse('2050-01-01'),
				  		onChanged: (DateTime value) {
				  			ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  			setState(() {
				  				widget.compraPedido.dataPrevisaoPagamento = value;
				  			});
				  		},
				  	),
				  ),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 100,
				  	maxLines: 1,
				  	initialValue: widget.compraPedido?.localEntrega ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Local de Entrega',
				  		'Local de Entrega',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.compraPedido.localEntrega = text;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 100,
				  	maxLines: 1,
				  	initialValue: widget.compraPedido?.localCobranca ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Local de Cobrança',
				  		'Local de Cobrança',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.compraPedido.localCobranca = text;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 50,
				  	maxLines: 1,
				  	initialValue: widget.compraPedido?.contato ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Nome do Contato',
				  		'Nome do Contato',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.compraPedido.contato = text;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: valorSubtotalController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Valor Subtotal',
				  		'Valor Subtotal',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.compraPedido.valorSubtotal = valorSubtotalController.numberValue;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
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
				  		widget.compraPedido.taxaDesconto = taxaDescontoController.numberValue;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: valorDescontoController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Valor do Desconto',
				  		'Valor Desconto',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.compraPedido.valorDesconto = valorDescontoController.numberValue;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: valorTotalController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Valor Total',
				  		'Valor Total',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.compraPedido.valorTotal = valorTotalController.numberValue;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  InputDecorator(
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Tipo do Frete',
				  		'Tipo do Frete',
				  		true),
				  	isEmpty: widget.compraPedido.tipoFrete == null,
				  	child: ViewUtilLib.getDropDownButton(widget.compraPedido.tipoFrete,
				  		(String newValue) {
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	setState(() {
				  		widget.compraPedido.tipoFrete = newValue;
				  	});
				  	}, <String>[
				  		'CIF',
				  		'FOB',
				  ])),
				  const SizedBox(height: 24.0),
				  InputDecorator(
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Forma de Pagamento',
				  		'Forma de Pagamento',
				  		true),
				  	isEmpty: widget.compraPedido.formaPagamento == null,
				  	child: ViewUtilLib.getDropDownButton(widget.compraPedido.formaPagamento,
				  		(String newValue) {
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	setState(() {
				  		widget.compraPedido.formaPagamento = newValue;
				  	});
				  	}, <String>[
				  		'Pagamento a Vista',
				  		'Pagamento a Prazo',
				  		'Outros',
				  ])),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: baseCalculoIcmsController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Base de Cálculo do ICMS',
				  		'Base Cálculo ICMS',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.compraPedido.baseCalculoIcms = baseCalculoIcmsController.numberValue;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: valorIcmsController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Valor do ICMS',
				  		'Valor do ICMS',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.compraPedido.valorIcms = valorIcmsController.numberValue;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: baseCalculoIcmsStController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Base de Cálculo do ICMS ST',
				  		'Base Cálculo ICMS ST',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.compraPedido.baseCalculoIcmsSt = baseCalculoIcmsStController.numberValue;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: valorIcmsStController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Valor do ICMS ST',
				  		'Valor do ICMS ST',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.compraPedido.valorIcmsSt = valorIcmsStController.numberValue;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: valorTotalProdutosController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Valor Total Produtos',
				  		'Valor Total Produtos',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.compraPedido.valorTotalProdutos = valorTotalProdutosController.numberValue;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: valorFreteController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Valor do Frete',
				  		'Valor Frete',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.compraPedido.valorFrete = valorFreteController.numberValue;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: valorSeguroController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Valor do Seguro',
				  		'Valor Seguro',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.compraPedido.valorSeguro = valorSeguroController.numberValue;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: valorOutrasDespesasController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Valor de Outras Despesas',
				  		'Valor Outras Despesas',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.compraPedido.valorOutrasDespesas = valorOutrasDespesasController.numberValue;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: valorIpiController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Valor do IPI',
				  		'Valor do IPI',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.compraPedido.valorIpi = valorIpiController.numberValue;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: valorTotalNfController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Valor Total da NF',
				  		'Valor Total NF',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.compraPedido.valorTotalNf = valorTotalNfController.numberValue;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	maxLength: 10,
				  	maxLines: 1,
				  	initialValue: widget.compraPedido?.quantidadeParcelas?.toString() ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Quantidade de Parcelas',
				  		'Quantidade de Parcelas',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.compraPedido.quantidadeParcelas = int.tryParse(text);
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: diaPrimeiroVencimentoController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Dia do Primeiro Vencimento',
				  		'Dia Primeiro Vencimento',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	// validator: ValidaCampoFormulario.validarDIA,
				  	onChanged: (text) {
				  		widget.compraPedido.diaPrimeiroVencimento = text;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	maxLength: 10,
				  	maxLines: 1,
				  	initialValue: widget.compraPedido?.intervaloEntreParcelas?.toString() ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Intervalo entre as Parcelas',
				  		'Intervalo entre Parcelas',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.compraPedido.intervaloEntreParcelas = int.tryParse(text);
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: diaFixoParcelaController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Dia do Fixo da Parcela',
				  		'Dia Fixo da Parcela',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	// validator: ValidaCampoFormulario.validarDIA,
				  	onChanged: (text) {
				  		widget.compraPedido.diaFixoParcela = text;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 32,
				  	maxLines: 1,
				  	initialValue: widget.compraPedido?.codigoCotacao ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Código da Cotação',
				  		'Código da Cotação',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	validator: ValidaCampoFormulario.validarAlfanumerico,
				  	onChanged: (text) {
				  		widget.compraPedido.codigoCotacao = text;
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
