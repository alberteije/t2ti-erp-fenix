/*
Title: T2Ti ERP Fenix                                                                
Description: AbaMestre PersistePage relacionada à tabela [VENDA_ORCAMENTO_CABECALHO] 
                                                                                
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

class VendaOrcamentoCabecalhoPersistePage extends StatefulWidget {
  final VendaOrcamentoCabecalho vendaOrcamentoCabecalho;
  final GlobalKey<FormState> formKey;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function atualizaVendaOrcamentoCabecalhoCallBack;

  const VendaOrcamentoCabecalhoPersistePage(
      {Key key, this.formKey, this.scaffoldKey, this.vendaOrcamentoCabecalho, this.atualizaVendaOrcamentoCabecalhoCallBack})
      : super(key: key);

  @override
  VendaOrcamentoCabecalhoPersistePageState createState() => VendaOrcamentoCabecalhoPersistePageState();
}

class VendaOrcamentoCabecalhoPersistePageState extends State<VendaOrcamentoCabecalhoPersistePage> {
  @override
  Widget build(BuildContext context) {
	var importaVendaCondicoesPagamentoController = TextEditingController();
	importaVendaCondicoesPagamentoController.text = widget.vendaOrcamentoCabecalho?.vendaCondicoesPagamento?.nome ?? '';
	var importaVendedorController = TextEditingController();
	importaVendedorController.text = widget.vendaOrcamentoCabecalho?.vendedor?.colaborador?.pessoa?.nome ?? '';
	var importaClienteController = TextEditingController();
	importaClienteController.text = widget.vendaOrcamentoCabecalho?.cliente?.pessoa?.nome ?? '';
	var importaTransportadoraController = TextEditingController();
	importaTransportadoraController.text = widget.vendaOrcamentoCabecalho?.transportadora?.pessoa?.nome ?? '';
	var valorSubtotalController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.vendaOrcamentoCabecalho?.valorSubtotal ?? 0);
	var valorFreteController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.vendaOrcamentoCabecalho?.valorFrete ?? 0);
	var taxaComissaoController = new MoneyMaskedTextController(precision: Constantes.decimaisTaxa, initialValue: widget.vendaOrcamentoCabecalho?.taxaComissao ?? 0);
	var valorComissaoController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.vendaOrcamentoCabecalho?.valorComissao ?? 0);
	var taxaDescontoController = new MoneyMaskedTextController(precision: Constantes.decimaisTaxa, initialValue: widget.vendaOrcamentoCabecalho?.taxaDesconto ?? 0);
	var valorDescontoController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.vendaOrcamentoCabecalho?.valorDesconto ?? 0);
	var valorTotalController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.vendaOrcamentoCabecalho?.valorTotal ?? 0);

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
				  					controller: importaVendaCondicoesPagamentoController,
				  					readOnly: true,
				  					decoration: ViewUtilLib.getInputDecorationPersistePage(
				  						'Importe a Condição de Pagamento Vinculada',
				  						'Condição  Pagamento *',
				  						false),
				  					onSaved: (String value) {
				  					},
				  					validator: ValidaCampoFormulario.validarObrigatorioAlfanumerico,
				  					onChanged: (text) {
				  						widget.vendaOrcamentoCabecalho?.vendaCondicoesPagamento?.nome = text;
				  						ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  					},
				  				),
				  			),
				  		),
				  		Expanded(
				  			flex: 0,
				  			child: IconButton(
				  				tooltip: 'Importar Condição  Pagamento',
				  				icon: const Icon(Icons.search),
				  				onPressed: () async {
				  					///chamando o lookup
				  					Map<String, dynamic> objetoJsonRetorno =
				  						await Navigator.push(
				  							context,
				  							MaterialPageRoute(
				  								builder: (BuildContext context) =>
				  									LookupPage(
				  										title: 'Importar Condição  Pagamento',
				  										colunas: VendaCondicoesPagamento.colunas,
				  										campos: VendaCondicoesPagamento.campos,
				  										rota: '/venda-condicoes-pagamento/',
				  										campoPesquisaPadrao: 'nome',
                              valorPesquisaPadrao: '%',
				  									),
				  									fullscreenDialog: true,
				  								));
				  				if (objetoJsonRetorno != null) {
				  					if (objetoJsonRetorno['nome'] != null) {
				  						importaVendaCondicoesPagamentoController.text = objetoJsonRetorno['nome'];
				  						widget.vendaOrcamentoCabecalho.idVendaCondicoesPagamento = objetoJsonRetorno['id'];
				  						widget.vendaOrcamentoCabecalho.vendaCondicoesPagamento = new VendaCondicoesPagamento.fromJson(objetoJsonRetorno);
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
				  					controller: importaVendedorController,
				  					readOnly: true,
				  					decoration: ViewUtilLib.getInputDecorationPersistePage(
				  						'Importe o Vendedor Vinculado',
				  						'Vendedor *',
				  						false),
				  					onSaved: (String value) {
				  					},
				  					validator: ValidaCampoFormulario.validarObrigatorioAlfanumerico,
				  					onChanged: (text) {
				  						widget.vendaOrcamentoCabecalho?.vendedor?.colaborador?.pessoa?.nome = text;
				  						ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  					},
				  				),
				  			),
				  		),
				  		Expanded(
				  			flex: 0,
				  			child: IconButton(
				  				tooltip: 'Importar Vendedor',
				  				icon: const Icon(Icons.search),
				  				onPressed: () async {
				  					///chamando o lookup
				  					Map<String, dynamic> objetoJsonRetorno =
				  						await Navigator.push(
				  							context,
				  							MaterialPageRoute(
				  								builder: (BuildContext context) =>
				  									LookupPage(
				  										title: 'Importar Vendedor',
				  										colunas: Vendedor.colunas,
				  										campos: Vendedor.campos,
				  										rota: '/vendedor/',
				  										campoPesquisaPadrao: 'id',
                              valorPesquisaPadrao: '%',
				  									),
				  									fullscreenDialog: true,
				  								));
				  				if (objetoJsonRetorno != null) {
				  					if (objetoJsonRetorno['id'] != null) {
				  						importaVendedorController.text = objetoJsonRetorno['id'].toString();
				  						widget.vendaOrcamentoCabecalho.idVendedor = objetoJsonRetorno['id'];
                      widget.vendaOrcamentoCabecalho.taxaComissao = objetoJsonRetorno['comissao'].toDouble();
				  						widget.vendaOrcamentoCabecalho.vendedor = new Vendedor.fromJson(objetoJsonRetorno);
                      atualizarTotais();
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
				  					controller: importaClienteController,
				  					readOnly: true,
				  					decoration: ViewUtilLib.getInputDecorationPersistePage(
				  						'Importe o Cliente Vinculado',
				  						'Cliente *',
				  						false),
				  					onSaved: (String value) {
				  					},
				  					validator: ValidaCampoFormulario.validarObrigatorioAlfanumerico,
				  					onChanged: (text) {
				  						widget.vendaOrcamentoCabecalho?.cliente?.pessoa?.nome = text;
				  						ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  					},
				  				),
				  			),
				  		),
				  		Expanded(
				  			flex: 0,
				  			child: IconButton(
				  				tooltip: 'Importar Cliente',
				  				icon: const Icon(Icons.search),
				  				onPressed: () async {
				  					///chamando o lookup
				  					Map<String, dynamic> objetoJsonRetorno =
				  						await Navigator.push(
				  							context,
				  							MaterialPageRoute(
				  								builder: (BuildContext context) =>
				  									LookupPage(
				  										title: 'Importar Cliente',
				  										colunas: ViewPessoaCliente.colunas,
				  										campos: ViewPessoaCliente.campos,
				  										rota: '/view-pessoa-cliente/',
				  										campoPesquisaPadrao: 'nome',
                              valorPesquisaPadrao: '%',
				  									),
				  									fullscreenDialog: true,
				  								));
				  				if (objetoJsonRetorno != null) {
				  					if (objetoJsonRetorno['nome'] != null) {
				  						importaClienteController.text = objetoJsonRetorno['nome'];
				  						widget.vendaOrcamentoCabecalho.idCliente = objetoJsonRetorno['id'];
				  						widget.vendaOrcamentoCabecalho.cliente = new Cliente.fromJson(objetoJsonRetorno);
                      widget.vendaOrcamentoCabecalho.cliente.pessoa = new Pessoa(nome: objetoJsonRetorno['nome']);
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
				  					controller: importaTransportadoraController,
				  					readOnly: true,
				  					decoration: ViewUtilLib.getInputDecorationPersistePage(
				  						'Importe a Transportadora Vinculada',
				  						'Transportadora *',
				  						false),
				  					onSaved: (String value) {
				  					},
				  					validator: ValidaCampoFormulario.validarObrigatorioAlfanumerico,
				  					onChanged: (text) {
				  						widget.vendaOrcamentoCabecalho?.transportadora?.pessoa?.nome = text;
				  						ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  					},
				  				),
				  			),
				  		),
				  		Expanded(
				  			flex: 0,
				  			child: IconButton(
				  				tooltip: 'Importar Transportadora',
				  				icon: const Icon(Icons.search),
				  				onPressed: () async {
				  					///chamando o lookup
				  					Map<String, dynamic> objetoJsonRetorno =
				  						await Navigator.push(
				  							context,
				  							MaterialPageRoute(
				  								builder: (BuildContext context) =>
				  									LookupPage(
				  										title: 'Importar Transportadora',
				  										colunas: Transportadora.colunas,
				  										campos: Transportadora.campos,
				  										rota: '/transportadora/',
				  										campoPesquisaPadrao: 'id',
                              valorPesquisaPadrao: '%',
				  									),
				  									fullscreenDialog: true,
				  								));
				  				if (objetoJsonRetorno != null) {
				  					if (objetoJsonRetorno['id'] != null) {
				  						importaTransportadoraController.text = objetoJsonRetorno['id'].toString();
				  						widget.vendaOrcamentoCabecalho.idTransportadora = objetoJsonRetorno['id'];
				  						widget.vendaOrcamentoCabecalho.transportadora = new Transportadora.fromJson(objetoJsonRetorno);
				  					}
				  				}
				  			},
				  		),
				  		),
				  	],
				  ),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 20,
				  	maxLines: 1,
				  	initialValue: widget.vendaOrcamentoCabecalho?.codigo ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Código do Orçamento',
				  		'Código do Orçamento',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.vendaOrcamentoCabecalho.codigo = text;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  InputDecorator(
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Data de Cadastro',
				  		'Data de Cadastro',
				  		true),
				  	isEmpty: widget.vendaOrcamentoCabecalho.dataCadastro == null,
				  	child: DatePickerItem(
				  		dateTime: widget.vendaOrcamentoCabecalho.dataCadastro,
				  		firstDate: DateTime.parse('1900-01-01'),
				  		lastDate: DateTime.now(),
				  		onChanged: (DateTime value) {
				  			ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  			setState(() {
				  				widget.vendaOrcamentoCabecalho.dataCadastro = value;
				  			});
				  		},
				  	),
				  ),
				  const SizedBox(height: 24.0),
				  InputDecorator(
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Data de Entrega',
				  		'Data de Entrega',
				  		true),
				  	isEmpty: widget.vendaOrcamentoCabecalho.dataEntrega == null,
				  	child: DatePickerItem(
				  		dateTime: widget.vendaOrcamentoCabecalho.dataEntrega,
				  		firstDate: DateTime.parse('1900-01-01'),
				  		lastDate: DateTime.parse('2050-01-01'),
				  		onChanged: (DateTime value) {
				  			ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  			setState(() {
				  				widget.vendaOrcamentoCabecalho.dataEntrega = value;
				  			});
				  		},
				  	),
				  ),
				  const SizedBox(height: 24.0),
				  InputDecorator(
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Data de Validade',
				  		'Data de Validade',
				  		true),
				  	isEmpty: widget.vendaOrcamentoCabecalho.validade == null,
				  	child: DatePickerItem(
				  		dateTime: widget.vendaOrcamentoCabecalho.validade,
				  		firstDate: DateTime.parse('1900-01-01'),
				  		lastDate: DateTime.parse('2050-01-01'),
				  		onChanged: (DateTime value) {
				  			ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  			setState(() {
				  				widget.vendaOrcamentoCabecalho.validade = value;
				  			});
				  		},
				  	),
				  ),
				  const SizedBox(height: 24.0),
				  InputDecorator(
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Tipo do Frete',
				  		'Tipo do Frete',
				  		true),
				  	isEmpty: widget.vendaOrcamentoCabecalho.tipoFrete == null,
				  	child: ViewUtilLib.getDropDownButton(widget.vendaOrcamentoCabecalho.tipoFrete,
				  		(String newValue) {
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	setState(() {
				  		widget.vendaOrcamentoCabecalho.tipoFrete = newValue;
				  	});
				  	}, <String>[
				  		'CIF',
				  		'FOB',
				  ])),
				  const SizedBox(height: 24.0),
				  TextFormField(
            readOnly: true,
				  	keyboardType: TextInputType.number,
				  	controller: valorSubtotalController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Valor Subtotal',
				  		'Valor Subtotal',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.vendaOrcamentoCabecalho.valorSubtotal = valorSubtotalController.numberValue;
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
				  		widget.vendaOrcamentoCabecalho.valorFrete = valorFreteController.numberValue;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
              atualizarTotais();
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
            readOnly: true,
				  	keyboardType: TextInputType.number,
				  	controller: taxaComissaoController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Taxa de Comissão',
				  		'Taxa Comissão',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.vendaOrcamentoCabecalho.taxaComissao = taxaComissaoController.numberValue;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
            readOnly: true,
				  	keyboardType: TextInputType.number,
				  	controller: valorComissaoController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Valor da Comissão',
				  		'Valor Comissão',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.vendaOrcamentoCabecalho.valorComissao = valorComissaoController.numberValue;
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
				  		widget.vendaOrcamentoCabecalho.taxaDesconto = taxaDescontoController.numberValue;
              atualizarTotais();
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
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
				  		widget.vendaOrcamentoCabecalho.valorDesconto = valorDescontoController.numberValue;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
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
				  		widget.vendaOrcamentoCabecalho.valorTotal = valorTotalController.numberValue;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 1000,
				  	maxLines: 3,
				  	initialValue: widget.vendaOrcamentoCabecalho?.observacao ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Observações Gerais',
				  		'Observação',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.vendaOrcamentoCabecalho.observacao = text;
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

  atualizarTotais() {
    setState(() {
        widget.vendaOrcamentoCabecalho.valorDesconto = Biblioteca.calcularDesconto(widget.vendaOrcamentoCabecalho.valorSubtotal, widget.vendaOrcamentoCabecalho.taxaDesconto);
        widget.vendaOrcamentoCabecalho.valorComissao = Biblioteca.calcularComissao(widget.vendaOrcamentoCabecalho.valorSubtotal - widget.vendaOrcamentoCabecalho.valorDesconto, widget.vendaOrcamentoCabecalho.taxaComissao);
        widget.vendaOrcamentoCabecalho.valorTotal = widget.vendaOrcamentoCabecalho.valorSubtotal + 
                                                    widget.vendaOrcamentoCabecalho.valorFrete - 
                                                    widget.vendaOrcamentoCabecalho.valorDesconto;
    });
  }

}
