/*
Title: T2Ti ERP Fenix                                                                
Description: AbaMestre PersistePage relacionada à tabela [VENDA_CABECALHO] 
                                                                                
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

class VendaCabecalhoPersistePage extends StatefulWidget {
  final VendaCabecalho vendaCabecalho;
  final GlobalKey<FormState> formKey;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function atualizaVendaCabecalhoCallBack;

  const VendaCabecalhoPersistePage(
      {Key key, this.formKey, this.scaffoldKey, this.vendaCabecalho, this.atualizaVendaCabecalhoCallBack})
      : super(key: key);

  @override
  VendaCabecalhoPersistePageState createState() => VendaCabecalhoPersistePageState();
}

class VendaCabecalhoPersistePageState extends State<VendaCabecalhoPersistePage> {
  @override
  Widget build(BuildContext context) {
	var importaVendaOrcamentoCabecalhoController = TextEditingController();
	importaVendaOrcamentoCabecalhoController.text = widget.vendaCabecalho?.vendaOrcamentoCabecalho?.codigo ?? '';
	var importaVendaCondicoesPagamentoController = TextEditingController();
	importaVendaCondicoesPagamentoController.text = widget.vendaCabecalho?.vendaCondicoesPagamento?.descricao ?? '';
	var importaNotaFiscalTipoController = TextEditingController();
	importaNotaFiscalTipoController.text = widget.vendaCabecalho?.notaFiscalTipo?.nome ?? '';
	var importaClienteController = TextEditingController();
	importaClienteController.text = widget.vendaCabecalho?.cliente?.pessoa?.nome ?? '';
	var importaTransportadoraController = TextEditingController();
	importaTransportadoraController.text = widget.vendaCabecalho?.transportadora?.pessoa?.nome ?? '';
	var importaVendedorController = TextEditingController();
	importaVendedorController.text = widget.vendaCabecalho?.vendedor?.colaborador?.pessoa?.nome ?? '';
	var horaSaidaController = new MaskedTextController(
		mask: Constantes.mascaraHORA,
		text: widget.vendaCabecalho?.horaSaida ?? '',
	);
	var valorSubtotalController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.vendaCabecalho?.valorSubtotal ?? 0);
	var taxaComissaoController = new MoneyMaskedTextController(precision: Constantes.decimaisTaxa, initialValue: widget.vendaCabecalho?.taxaComissao ?? 0);
	var valorComissaoController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.vendaCabecalho?.valorComissao ?? 0);
	var taxaDescontoController = new MoneyMaskedTextController(precision: Constantes.decimaisTaxa, initialValue: widget.vendaCabecalho?.taxaDesconto ?? 0);
	var valorDescontoController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.vendaCabecalho?.valorDesconto ?? 0);
	var valorTotalController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.vendaCabecalho?.valorTotal ?? 0);
	var valorFreteController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.vendaCabecalho?.valorFrete ?? 0);
	var valorSeguroController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.vendaCabecalho?.valorSeguro ?? 0);

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
				  					controller: importaVendaOrcamentoCabecalhoController,
				  					readOnly: true,
				  					decoration: ViewUtilLib.getInputDecorationPersistePage(
				  						'Importe o Orçamento Vinculado',
				  						'Orçamento',
				  						false),
				  					onSaved: (String value) {
				  					},
				  					onChanged: (text) {
				  						widget.vendaCabecalho?.vendaOrcamentoCabecalho?.codigo = text;
				  						ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  					},
				  				),
				  			),
				  		),
				  		Expanded(
				  			flex: 0,
				  			child: IconButton(
				  				tooltip: 'Importar Orçamento',
				  				icon: const Icon(Icons.search),
				  				onPressed: () async {
				  					///chamando o lookup
				  					Map<String, dynamic> objetoJsonRetorno =
				  						await Navigator.push(
				  							context,
				  							MaterialPageRoute(
				  								builder: (BuildContext context) =>
				  									LookupPage(
				  										title: 'Importar Orçamento',
				  										colunas: VendaOrcamentoCabecalho.colunas,
				  										campos: VendaOrcamentoCabecalho.campos,
				  										rota: '/venda-orcamento-cabecalho/',
				  										campoPesquisaPadrao: 'codigo',
                              valorPesquisaPadrao: '%',
				  									),
				  									fullscreenDialog: true,
				  								));
				  				if (objetoJsonRetorno != null) {
				  					if (objetoJsonRetorno['codigo'] != null) {
				  						importaVendaOrcamentoCabecalhoController.text = objetoJsonRetorno['codigo'];
				  						widget.vendaCabecalho.idVendaOrcamentoCabecalho = objetoJsonRetorno['id'];
				  						widget.vendaCabecalho.vendaOrcamentoCabecalho = new VendaOrcamentoCabecalho.fromJson(objetoJsonRetorno);
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
				  					controller: importaVendaCondicoesPagamentoController,
				  					readOnly: true,
				  					decoration: ViewUtilLib.getInputDecorationPersistePage(
				  						'Importe a Condição de Pagamento Vinculado',
				  						'Condição Pagamento',
				  						false),
				  					onSaved: (String value) {
				  					},
				  					validator: ValidaCampoFormulario.validarAlfanumerico,
				  					onChanged: (text) {
				  						widget.vendaCabecalho?.vendaCondicoesPagamento?.descricao = text;
				  						ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  					},
				  				),
				  			),
				  		),
				  		Expanded(
				  			flex: 0,
				  			child: IconButton(
				  				tooltip: 'Importar Condição Pagamento',
				  				icon: const Icon(Icons.search),
				  				onPressed: () async {
				  					///chamando o lookup
				  					Map<String, dynamic> objetoJsonRetorno =
				  						await Navigator.push(
				  							context,
				  							MaterialPageRoute(
				  								builder: (BuildContext context) =>
				  									LookupPage(
				  										title: 'Importar Condição Pagamento',
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
				  						widget.vendaCabecalho.idVendaCondicoesPagamento = objetoJsonRetorno['id'];
				  						widget.vendaCabecalho.vendaCondicoesPagamento = new VendaCondicoesPagamento.fromJson(objetoJsonRetorno);
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
				  					controller: importaNotaFiscalTipoController,
				  					readOnly: true,
				  					decoration: ViewUtilLib.getInputDecorationPersistePage(
				  						'Importe o Tipo da Nota Fiscal Vinculada',
				  						'Tipo Nota Fiscal',
				  						false),
				  					onSaved: (String value) {
				  					},
				  					validator: ValidaCampoFormulario.validarAlfanumerico,
				  					onChanged: (text) {
				  						widget.vendaCabecalho?.notaFiscalTipo?.nome = text;
				  						ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  					},
				  				),
				  			),
				  		),
				  		Expanded(
				  			flex: 0,
				  			child: IconButton(
				  				tooltip: 'Importar Tipo Nota Fiscal',
				  				icon: const Icon(Icons.search),
				  				onPressed: () async {
				  					///chamando o lookup
				  					Map<String, dynamic> objetoJsonRetorno =
				  						await Navigator.push(
				  							context,
				  							MaterialPageRoute(
				  								builder: (BuildContext context) =>
				  									LookupPage(
				  										title: 'Importar Tipo Nota Fiscal',
				  										colunas: NotaFiscalTipo.colunas,
				  										campos: NotaFiscalTipo.campos,
				  										rota: '/nota-fiscal-tipo/',
				  										campoPesquisaPadrao: 'nome',
                              valorPesquisaPadrao: '%',
				  									),
				  									fullscreenDialog: true,
				  								));
				  				if (objetoJsonRetorno != null) {
				  					if (objetoJsonRetorno['nome'] != null) {
				  						importaNotaFiscalTipoController.text = objetoJsonRetorno['nome'];
				  						widget.vendaCabecalho.idNotaFiscalTipo = objetoJsonRetorno['id'];
				  						widget.vendaCabecalho.notaFiscalTipo = new NotaFiscalTipo.fromJson(objetoJsonRetorno);
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
				  						widget.vendaCabecalho?.cliente?.pessoa?.nome = text;
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
				  						widget.vendaCabecalho.idCliente = objetoJsonRetorno['id'];
				  						widget.vendaCabecalho.cliente = new Cliente.fromJson(objetoJsonRetorno);
                      widget.vendaCabecalho.cliente.pessoa = new Pessoa(nome: objetoJsonRetorno['nome']);
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
				  						'Transportadora',
				  						false),
				  					onSaved: (String value) {
				  					},
				  					validator: ValidaCampoFormulario.validarAlfanumerico,
				  					onChanged: (text) {
				  						widget.vendaCabecalho?.transportadora?.pessoa?.nome = text;
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
				  						widget.vendaCabecalho.idTransportadora = objetoJsonRetorno['id'];
				  						widget.vendaCabecalho.transportadora = new Transportadora.fromJson(objetoJsonRetorno);
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
				  						widget.vendaCabecalho?.vendedor?.colaborador?.pessoa?.nome = text;
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
				  						widget.vendaCabecalho.idVendedor = objetoJsonRetorno['id'];
                      widget.vendaCabecalho.taxaComissao = objetoJsonRetorno['comissao'].toDouble();
				  						widget.vendaCabecalho.vendedor = new Vendedor.fromJson(objetoJsonRetorno);
                      atualizarTotais();
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
				  		'Informe a Data da Venda',
				  		'Data da Venda',
				  		true),
				  	isEmpty: widget.vendaCabecalho.dataVenda == null,
				  	child: DatePickerItem(
				  		dateTime: widget.vendaCabecalho.dataVenda,
				  		firstDate: DateTime.parse('1900-01-01'),
				  		lastDate: DateTime.parse('2050-01-01'),
				  		onChanged: (DateTime value) {
				  			ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  			setState(() {
				  				widget.vendaCabecalho.dataVenda = value;
				  			});
				  		},
				  	),
				  ),
				  const SizedBox(height: 24.0),
				  InputDecorator(
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Data da Saída',
				  		'Data da Saída',
				  		true),
				  	isEmpty: widget.vendaCabecalho.dataSaida == null,
				  	child: DatePickerItem(
				  		dateTime: widget.vendaCabecalho.dataSaida,
				  		firstDate: DateTime.parse('1900-01-01'),
				  		lastDate: DateTime.parse('2050-01-01'),
				  		onChanged: (DateTime value) {
				  			ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  			setState(() {
				  				widget.vendaCabecalho.dataSaida = value;
				  			});
				  		},
				  	),
				  ),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: horaSaidaController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Hora da Saída',
				  		'Hora da Saída',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.vendaCabecalho.horaSaida = text;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	maxLength: 10,
				  	maxLines: 1,
				  	initialValue: widget.vendaCabecalho?.numeroFatura?.toString() ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Número da Fatura',
				  		'Número da Fatura',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.vendaCabecalho.numeroFatura = int.tryParse(text);
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 100,
				  	maxLines: 1,
				  	initialValue: widget.vendaCabecalho?.localEntrega ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Local de Entrega',
				  		'Local de Entrega',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.vendaCabecalho.localEntrega = text;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 100,
				  	maxLines: 1,
				  	initialValue: widget.vendaCabecalho?.localCobranca ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Local de Cobrança',
				  		'Local de Cobrança',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.vendaCabecalho.localCobranca = text;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
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
				  		widget.vendaCabecalho.valorSubtotal = valorSubtotalController.numberValue;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
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
				  		widget.vendaCabecalho.taxaComissao = taxaComissaoController.numberValue;
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
				  		widget.vendaCabecalho.valorComissao = valorComissaoController.numberValue;
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
				  		widget.vendaCabecalho.taxaDesconto = taxaDescontoController.numberValue;
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
				  		widget.vendaCabecalho.valorDesconto = valorDescontoController.numberValue;
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
				  		widget.vendaCabecalho.valorTotal = valorTotalController.numberValue;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  InputDecorator(
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Selecione a Opção Desejada',
				  		'Tipo do Frete',
				  		true),
				  	isEmpty: widget.vendaCabecalho.tipoFrete == null,
				  	child: ViewUtilLib.getDropDownButton(widget.vendaCabecalho.tipoFrete,
				  		(String newValue) {
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	setState(() {
				  		widget.vendaCabecalho.tipoFrete = newValue;
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
				  	isEmpty: widget.vendaCabecalho.formaPagamento == null,
				  	child: ViewUtilLib.getDropDownButton(widget.vendaCabecalho.formaPagamento,
				  		(String newValue) {
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	setState(() {
				  		widget.vendaCabecalho.formaPagamento = newValue;
				  	});
				  	}, <String>[
				  		'Pagamento a Vista',
				  		'Pagamento a Prazo',
				  		'Outros',
				  ])),
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
				  		widget.vendaCabecalho.valorFrete = valorFreteController.numberValue;
              atualizarTotais();
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
				  		widget.vendaCabecalho.valorSeguro = valorSeguroController.numberValue;
              atualizarTotais();
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 1000,
				  	maxLines: 3,
				  	initialValue: widget.vendaCabecalho?.observacao ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Observações Gerais',
				  		'Observação',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.vendaCabecalho.observacao = text;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  InputDecorator(
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Selecione a Opção Desejada',
				  		'Situação',
				  		true),
				  	isEmpty: widget.vendaCabecalho.situacao == null,
				  	child: ViewUtilLib.getDropDownButton(widget.vendaCabecalho.situacao,
				  		(String newValue) {
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	setState(() {
				  		widget.vendaCabecalho.situacao = newValue;
				  	});
				  	}, <String>[
				  		'Digitação',
				  		'Produção',
				  		'Expedição',
				  		'Faturado',
				  		'Entregue',
				  		'Devolução',
				  ])),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 2,
				  	maxLines: 1,
				  	initialValue: widget.vendaCabecalho?.diaFixoParcela ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Dia Fixo da Parcela',
				  		'Dia Fixo da Parcela',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.vendaCabecalho.diaFixoParcela = text;
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
        widget.vendaCabecalho.valorDesconto = Biblioteca.calcularDesconto(widget.vendaCabecalho.valorSubtotal, widget.vendaCabecalho.taxaDesconto);
        widget.vendaCabecalho.valorComissao = Biblioteca.calcularComissao(widget.vendaCabecalho.valorSubtotal - widget.vendaCabecalho.valorDesconto, widget.vendaCabecalho.taxaComissao);
        widget.vendaCabecalho.valorTotal = widget.vendaCabecalho.valorSubtotal + 
                                            widget.vendaCabecalho.valorFrete + 
                                            widget.vendaCabecalho.valorSeguro - 
                                            widget.vendaCabecalho.valorDesconto;
    });
  }

}
