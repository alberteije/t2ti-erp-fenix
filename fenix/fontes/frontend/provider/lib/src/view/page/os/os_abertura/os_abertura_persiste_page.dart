/*
Title: T2Ti ERP Fenix                                                                
Description: AbaMestre PersistePage relacionada à tabela [OS_ABERTURA] 
                                                                                
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

class OsAberturaPersistePage extends StatefulWidget {
  final OsAbertura osAbertura;
  final GlobalKey<FormState> formKey;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function atualizaOsAberturaCallBack;

  const OsAberturaPersistePage(
      {Key key, this.formKey, this.scaffoldKey, this.osAbertura, this.atualizaOsAberturaCallBack})
      : super(key: key);

  @override
  OsAberturaPersistePageState createState() => OsAberturaPersistePageState();
}

class OsAberturaPersistePageState extends State<OsAberturaPersistePage> {
  @override
  Widget build(BuildContext context) {
	var importaOsStatusController = TextEditingController();
	importaOsStatusController.text = widget.osAbertura?.osStatus?.nome ?? '';
	var importaClienteController = TextEditingController();
	importaClienteController.text = widget.osAbertura?.cliente?.pessoa?.nome ?? '';
	var importaColaboradorController = TextEditingController();
	importaColaboradorController.text = widget.osAbertura?.colaborador?.pessoa?.nome ?? '';
	var horaInicioController = new MaskedTextController(
		mask: Constantes.mascaraHORA,
		text: widget.osAbertura?.horaInicio ?? '',
	);
	var horaPrevisaoController = new MaskedTextController(
		mask: Constantes.mascaraHORA,
		text: widget.osAbertura?.horaPrevisao ?? '',
	);
	var horaFimController = new MaskedTextController(
		mask: Constantes.mascaraHORA,
		text: widget.osAbertura?.horaFim ?? '',
	);
	var foneContatoController = new MaskedTextController(
		mask: Constantes.mascaraTELEFONE,
		text: widget.osAbertura?.foneContato ?? '',
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
				  					controller: importaOsStatusController,
				  					readOnly: true,
				  					decoration: ViewUtilLib.getInputDecorationPersistePage(
				  						'Importe o Status Vinculado',
				  						'Status *',
				  						false),
				  					onSaved: (String value) {
				  					},
				  					onChanged: (text) {
				  						widget.osAbertura?.osStatus?.nome = text;
				  						ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  					},
				  				),
				  			),
				  		),
				  		Expanded(
				  			flex: 0,
				  			child: IconButton(
				  				tooltip: 'Importar Status',
				  				icon: const Icon(Icons.search),
				  				onPressed: () async {
				  					///chamando o lookup
				  					Map<String, dynamic> objetoJsonRetorno =
				  						await Navigator.push(
				  							context,
				  							MaterialPageRoute(
				  								builder: (BuildContext context) =>
				  									LookupPage(
				  										title: 'Importar Status',
				  										colunas: OsStatus.colunas,
				  										campos: OsStatus.campos,
				  										rota: '/os-status/',
				  										campoPesquisaPadrao: 'nome',
				  										valorPesquisaPadrao: '',
				  									),
				  									fullscreenDialog: true,
				  								));
				  				if (objetoJsonRetorno != null) {
				  					if (objetoJsonRetorno['nome'] != null) {
				  						importaOsStatusController.text = objetoJsonRetorno['nome'];
				  						widget.osAbertura.idOsStatus = objetoJsonRetorno['id'];
				  						widget.osAbertura.osStatus = new OsStatus.fromJson(objetoJsonRetorno);
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
				  						widget.osAbertura?.cliente?.pessoa?.nome = text;
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
				  						widget.osAbertura.idCliente = objetoJsonRetorno['id'];
				  						widget.osAbertura.cliente = new Cliente.fromJson(objetoJsonRetorno);
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
				  					onChanged: (text) {
				  						widget.osAbertura?.colaborador?.pessoa?.nome = text;
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
				  										colunas: Colaborador.colunas,
				  										campos: Colaborador.campos,
				  										rota: '/colaborador/',
				  										campoPesquisaPadrao: 'pessoa?.nome',
				  										valorPesquisaPadrao: '',
				  									),
				  									fullscreenDialog: true,
				  								));
				  				if (objetoJsonRetorno != null) {
				  					if (objetoJsonRetorno['pessoa?.nome'] != null) {
				  						importaColaboradorController.text = objetoJsonRetorno['pessoa?.nome'];
				  						widget.osAbertura.idColaborador = objetoJsonRetorno['id'];
				  						widget.osAbertura.colaborador = new Colaborador.fromJson(objetoJsonRetorno);
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
				  	initialValue: widget.osAbertura?.numero ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Número',
				  		'Número',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.osAbertura.numero = text;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  InputDecorator(
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Data Inicial',
				  		'Data Inicial',
				  		true),
				  	isEmpty: widget.osAbertura.dataInicio == null,
				  	child: DatePickerItem(
				  		dateTime: widget.osAbertura.dataInicio,
				  		firstDate: DateTime.parse('1900-01-01'),
				  		lastDate: DateTime.now(),
				  		onChanged: (DateTime value) {
				  			ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  			setState(() {
				  				widget.osAbertura.dataInicio = value;
				  			});
				  		},
				  	),
				  ),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: horaInicioController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Hora Inicial',
				  		'Hora Inicial',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	validator: ValidaCampoFormulario.validarHORA,
				  	onChanged: (text) {
				  		widget.osAbertura.horaInicio = text;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  InputDecorator(
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Data Prevista',
				  		'Data Prevista',
				  		true),
				  	isEmpty: widget.osAbertura.dataPrevisao == null,
				  	child: DatePickerItem(
				  		dateTime: widget.osAbertura.dataPrevisao,
				  		firstDate: DateTime.parse('1900-01-01'),
				  		lastDate: DateTime.now(),
				  		onChanged: (DateTime value) {
				  			ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  			setState(() {
				  				widget.osAbertura.dataPrevisao = value;
				  			});
				  		},
				  	),
				  ),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: horaPrevisaoController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Hora Prevista',
				  		'Hora Prevista',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	validator: ValidaCampoFormulario.validarHORA,
				  	onChanged: (text) {
				  		widget.osAbertura.horaPrevisao = text;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  InputDecorator(
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Data Final',
				  		'Data Final',
				  		true),
				  	isEmpty: widget.osAbertura.dataFim == null,
				  	child: DatePickerItem(
				  		dateTime: widget.osAbertura.dataFim,
				  		firstDate: DateTime.parse('1900-01-01'),
				  		lastDate: DateTime.now(),
				  		onChanged: (DateTime value) {
				  			ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  			setState(() {
				  				widget.osAbertura.dataFim = value;
				  			});
				  		},
				  	),
				  ),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: horaFimController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Hora Final',
				  		'Hora Final',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	validator: ValidaCampoFormulario.validarHORA,
				  	onChanged: (text) {
				  		widget.osAbertura.horaFim = text;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 50,
				  	maxLines: 1,
				  	initialValue: widget.osAbertura?.nomeContato ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Nome do Contato',
				  		'Nome do Contato',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	validator: ValidaCampoFormulario.validarAlfanumerico,
				  	onChanged: (text) {
				  		widget.osAbertura.nomeContato = text;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	keyboardType: TextInputType.number,
				  	controller: foneContatoController,
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe o Telefone do Contato',
				  		'Telefone do Contato',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	// validator: ValidaCampoFormulario.validarte,
				  	onChanged: (text) {
				  		widget.osAbertura.foneContato = text;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 1000,
				  	maxLines: 3,
				  	initialValue: widget.osAbertura?.observacaoCliente ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Observações Gerais do Cliente',
				  		'Observação Cliente',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.osAbertura.observacaoCliente = text;
				  		ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  	},
				  	),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 1000,
				  	maxLines: 3,
				  	initialValue: widget.osAbertura?.observacaoAbertura ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Observações Gerais do Colaborador',
				  		'Observação Abertura',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.osAbertura.observacaoAbertura = text;
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
