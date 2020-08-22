/*
Title: T2Ti ERP Fenix                                                                
Description: PersistePage relacionada à tabela [VENDEDOR_META] 
                                                                                
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

class VendedorMetaPersistePage extends StatefulWidget {
  final VendedorMeta vendedorMeta;
  final String title;
  final String operacao;

  const VendedorMetaPersistePage({Key key, this.vendedorMeta, this.title, this.operacao})
      : super(key: key);

  @override
  VendedorMetaPersistePageState createState() => VendedorMetaPersistePageState();
}

class VendedorMetaPersistePageState extends State<VendedorMetaPersistePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool _formFoiAlterado = false;

  @override
  Widget build(BuildContext context) {
    var vendedorMetaProvider = Provider.of<VendedorMetaViewModel>(context);
	
    var importaVendedorController = TextEditingController();
    importaVendedorController.text = widget.vendedorMeta?.vendedor?.colaborador?.pessoa?.nome ?? '';
    var importaClienteController = TextEditingController();
    importaClienteController.text = widget.vendedorMeta?.cliente?.pessoa?.nome ?? '';
    var metaOrcadaController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.vendedorMeta?.metaOrcada ?? 0);
    var metaRealizadaController = new MoneyMaskedTextController(precision: Constantes.decimaisValor, initialValue: widget.vendedorMeta?.metaRealizada ?? 0);
	
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
                  await vendedorMetaProvider.alterar(widget.vendedorMeta);
                } else {
                  await vendedorMetaProvider.inserir(widget.vendedorMeta);
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
				  					controller: importaVendedorController,
				  					readOnly: true,
				  					decoration: ViewUtilLib.getInputDecorationPersistePage(
				  						'Importe o Vendedor Vinculado',
				  						'Vendedor *',
				  						false),
				  					onSaved: (String value) {
				  					},
				  					onChanged: (text) {
				  						widget.vendedorMeta?.vendedor?.colaborador?.pessoa?.nome = text;
				  						_formFoiAlterado = true;
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
				  										campoPesquisaPadrao: 'colaborador?.pessoa?.nome',
				  										valorPesquisaPadrao: '%',
				  									),
				  									fullscreenDialog: true,
				  								));
				  				if (objetoJsonRetorno != null) {
				  					if (objetoJsonRetorno['colaborador?.pessoa?.nome'] != null) {
				  						importaVendedorController.text = objetoJsonRetorno['colaborador?.pessoa?.nome'];
				  						widget.vendedorMeta.idVendedor = objetoJsonRetorno['id'];
				  						widget.vendedorMeta.vendedor = new Vendedor.fromJson(objetoJsonRetorno);
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
				  					onChanged: (text) {
				  						widget.vendedorMeta?.cliente?.pessoa?.nome = text;
				  						_formFoiAlterado = true;
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
				  										colunas: Cliente.colunas,
				  										campos: Cliente.campos,
				  										rota: '/cliente/',
				  										campoPesquisaPadrao: 'pessoa?.nome',
				  										valorPesquisaPadrao: '',
				  									),
				  									fullscreenDialog: true,
				  								));
				  				if (objetoJsonRetorno != null) {
				  					if (objetoJsonRetorno['pessoa?.nome'] != null) {
				  						importaClienteController.text = objetoJsonRetorno['pessoa?.nome'];
				  						widget.vendedorMeta.idCliente = objetoJsonRetorno['id'];
				  						widget.vendedorMeta.cliente = new Cliente.fromJson(objetoJsonRetorno);
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
				  		'Período',
				  		true),
				  	isEmpty: widget.vendedorMeta.periodoMeta == null,
				  	child: ViewUtilLib.getDropDownButton(widget.vendedorMeta.periodoMeta,
				  		(String newValue) {
				  	setState(() {
				  		widget.vendedorMeta.periodoMeta = newValue;
				  	});
				  	}, <String>[
				  		'Semanal',
				  		'Mensal',
				  		'Bimestral',
				  		'Trimestral',
				  		'Semestral',
				  		'Anual',
				  ])),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: metaOrcadaController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Meta Orçada',
				  		'Meta Orçada',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.vendedorMeta.metaOrcada = metaOrcadaController.numberValue;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: metaRealizadaController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Meta Realizada',
				  		'Meta Realizada',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.vendedorMeta.metaRealizada = metaRealizadaController.numberValue;
				  		_formFoiAlterado = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  InputDecorator(
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Data Inicial',
				  		'Data Inicial',
				  		true),
				  	isEmpty: widget.vendedorMeta.dataInicio == null,
				  	child: DatePickerItem(
				  		dateTime: widget.vendedorMeta.dataInicio,
				  		firstDate: DateTime.parse('1900-01-01'),
				  		lastDate: DateTime.now(),
				  		onChanged: (DateTime value) {
				  			setState(() {
				  				widget.vendedorMeta.dataInicio = value;
				  			});
				  		},
				  	),
				  ),
				  const SizedBox(height: 24.0),
				  InputDecorator(
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Data Final',
				  		'Data Final',
				  		true),
				  	isEmpty: widget.vendedorMeta.dataFim == null,
				  	child: DatePickerItem(
				  		dateTime: widget.vendedorMeta.dataFim,
				  		firstDate: DateTime.parse('1900-01-01'),
				  		lastDate: DateTime.now(),
				  		onChanged: (DateTime value) {
				  			setState(() {
				  				widget.vendedorMeta.dataFim = value;
				  			});
				  		},
				  	),
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