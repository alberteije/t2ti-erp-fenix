/*
Title: T2Ti ERP Fenix                                                                
Description: PersistePage relacionada à tabela [VENDA_FRETE] 
                                                                                
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
import 'package:fenix/src/view/shared/dropdown_lista.dart';

class VendaFretePersistePage extends StatefulWidget {
  final VendaFrete vendaFrete;
  final String title;
  final String operacao;

  const VendaFretePersistePage({Key key, this.vendaFrete, this.title, this.operacao})
      : super(key: key);

  @override
  VendaFretePersistePageState createState() => VendaFretePersistePageState();
}

class VendaFretePersistePageState extends State<VendaFretePersistePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool _formFoiAlterado = false;

  @override
  Widget build(BuildContext context) {
    var vendaFreteProvider = Provider.of<VendaFreteViewModel>(context);
	
	var importaVendaCabecalhoController = TextEditingController();
	importaVendaCabecalhoController.text = widget.vendaFrete?.vendaCabecalho?.id?.toString() ?? '';
	var importaTransportadoraController = TextEditingController();
	importaTransportadoraController.text = widget.vendaFrete?.transportadora?.pessoa?.nome ?? '';
	var quantidadeVolumeController = new MoneyMaskedTextController(precision: Constantes.decimaisQuantidade, initialValue: widget.vendaFrete?.quantidadeVolume ?? 0);
	var pesoBrutoController = new MoneyMaskedTextController(precision: Constantes.decimaisQuantidade, initialValue: widget.vendaFrete?.pesoBruto ?? 0);
	var pesoLiquidoController = new MoneyMaskedTextController(precision: Constantes.decimaisQuantidade, initialValue: widget.vendaFrete?.pesoLiquido ?? 0);
	
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
                  await vendaFreteProvider.alterar(widget.vendaFrete);
                } else {
                  await vendaFreteProvider.inserir(widget.vendaFrete);
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
				  					controller: importaVendaCabecalhoController,
				  					readOnly: true,
				  					decoration: ViewUtilLib.getInputDecorationPersistePage(
				  						'Importe a Venda Vinculada',
				  						'Venda *',
				  						false),
				  					onSaved: (String value) {
				  					},
				  					validator: ValidaCampoFormulario.validarObrigatorioAlfanumerico,
				  					onChanged: (text) {
				  						widget.vendaFrete?.vendaCabecalho?.id = int.tryParse(text);
				  						_formFoiAlterado = true;
				  					},
				  				),
				  			),
				  		),
				  		Expanded(
				  			flex: 0,
				  			child: IconButton(
				  				tooltip: 'Importar Venda',
				  				icon: const Icon(Icons.search),
				  				onPressed: () async {
				  					///chamando o lookup
				  					Map<String, dynamic> objetoJsonRetorno =
				  						await Navigator.push(
				  							context,
				  							MaterialPageRoute(
				  								builder: (BuildContext context) =>
				  									LookupPage(
				  										title: 'Importar Venda',
				  										colunas: VendaCabecalho.colunas,
				  										campos: VendaCabecalho.campos,
				  										rota: '/venda-cabecalho/',
				  										campoPesquisaPadrao: 'id',
                              valorPesquisaPadrao: '%',
				  									),
				  									fullscreenDialog: true,
				  								));
				  				if (objetoJsonRetorno != null) {
				  					if (objetoJsonRetorno['id'] != null) {
				  						importaVendaCabecalhoController.text = objetoJsonRetorno['id'].toString();
				  						widget.vendaFrete.idVendaCabecalho = objetoJsonRetorno['id'];
				  						widget.vendaFrete.vendaCabecalho = new VendaCabecalho.fromJson(objetoJsonRetorno);
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
				  						widget.vendaFrete?.transportadora?.pessoa?.nome = text;
				  						_formFoiAlterado = true;
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
				  						widget.vendaFrete.idTransportadora = objetoJsonRetorno['id'];
				  						widget.vendaFrete.transportadora = new Transportadora.fromJson(objetoJsonRetorno);
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
				  	maxLength: 10,
				  	maxLines: 1,
				  	initialValue: widget.vendaFrete?.conhecimento?.toString() ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Número do Conhecimento',
				  		'Conhecimento',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.vendaFrete.conhecimento = int.tryParse(text);
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  InputDecorator(
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Selecione a Opção Desejada',
				  		'Responsável',
				  		true),
				  	isEmpty: widget.vendaFrete.responsavel == null,
				  	child: ViewUtilLib.getDropDownButton(widget.vendaFrete.responsavel,
				  		(String newValue) {
				  	setState(() {
				  		widget.vendaFrete.responsavel = newValue;
				  	});
				  	}, <String>[
				  		'1-Emitente',
				  		'2-Destinatário',
				  ])),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 7,
				  	maxLines: 1,
				  	initialValue: widget.vendaFrete?.placa ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Placa',
				  		'Placa',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.vendaFrete.placa = text;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  InputDecorator(
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a UF da Placa',
				  		'UF',
				  		true),
				  	isEmpty: widget.vendaFrete.ufPlaca == null,
				  	child: ViewUtilLib.getDropDownButton(widget.vendaFrete.ufPlaca,
				  		(String newValue) {
				  	setState(() {
				  		widget.vendaFrete.ufPlaca = newValue;
				  	});
				  	}, DropdownLista.listaUF)),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	maxLength: 11,
				  	maxLines: 1,
				  	initialValue: widget.vendaFrete?.seloFiscal?.toString() ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Número do Selo Fiscal',
				  		'Selo Fiscal',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.vendaFrete.seloFiscal = int.tryParse(text);
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: quantidadeVolumeController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Quantidade de Volumes',
				  		'Quantidade de Volumes',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.vendaFrete.quantidadeVolume = quantidadeVolumeController.numberValue;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 50,
				  	maxLines: 1,
				  	initialValue: widget.vendaFrete?.marcaVolume ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Marca da Carga',
				  		'Marca Volume',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.vendaFrete.marcaVolume = text;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 20,
				  	maxLines: 1,
				  	initialValue: widget.vendaFrete?.especieVolume ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Espécie do Volume',
				  		'Espécie do Volume',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.vendaFrete.especieVolume = text;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: pesoBrutoController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Peso Bruto',
				  		'Peso Bruto',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.vendaFrete.pesoBruto = pesoBrutoController.numberValue;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: pesoLiquidoController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Peso Líquido',
				  		'Peso Líquido',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.vendaFrete.pesoLiquido = pesoLiquidoController.numberValue;
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