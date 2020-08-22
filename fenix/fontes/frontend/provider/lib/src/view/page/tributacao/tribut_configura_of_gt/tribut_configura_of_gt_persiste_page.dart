/*
Title: T2Ti ERP Fenix                                                                
Description: AbaMestre PersistePage relacionada à tabela [TRIBUT_CONFIGURA_OF_GT] 
                                                                                
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
import 'package:fenix/src/view/shared/valida_campo_formulario.dart';

class TributConfiguraOfGtPersistePage extends StatefulWidget {
  final TributConfiguraOfGt tributConfiguraOfGt;
  final GlobalKey<FormState> formKey;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function atualizaTributConfiguraOfGtCallBack;

  const TributConfiguraOfGtPersistePage(
      {Key key, this.formKey, this.scaffoldKey, this.tributConfiguraOfGt, this.atualizaTributConfiguraOfGtCallBack})
      : super(key: key);

  @override
  TributConfiguraOfGtPersistePageState createState() => TributConfiguraOfGtPersistePageState();
}

class TributConfiguraOfGtPersistePageState extends State<TributConfiguraOfGtPersistePage> {
  @override
  Widget build(BuildContext context) {
	var importaTributGrupoTributarioController = TextEditingController();
	importaTributGrupoTributarioController.text = widget.tributConfiguraOfGt?.tributGrupoTributario?.descricao ?? '';
	var importaTributOperacaoFiscalController = TextEditingController();
	importaTributOperacaoFiscalController.text = widget.tributConfiguraOfGt?.tributOperacaoFiscal?.descricao ?? '';

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
				  					controller: importaTributGrupoTributarioController,
				  					readOnly: true,
				  					decoration: ViewUtilLib.getInputDecorationPersistePage(
				  						'Importe o Grupo Tributário Vinculado',
				  						'Grupo Tributário *',
				  						false),
				  					onSaved: (String value) {
				  					},
				  					validator: ValidaCampoFormulario.validarObrigatorioAlfanumerico,
				  					onChanged: (text) {
				  						widget.tributConfiguraOfGt?.tributGrupoTributario?.descricao = text;
				  						ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  					},
				  				),
				  			),
				  		),
				  		Expanded(
				  			flex: 0,
				  			child: IconButton(
				  				tooltip: 'Importar Grupo Tributário',
				  				icon: const Icon(Icons.search),
				  				onPressed: () async {
				  					///chamando o lookup
				  					Map<String, dynamic> objetoJsonRetorno =
				  						await Navigator.push(
				  							context,
				  							MaterialPageRoute(
				  								builder: (BuildContext context) =>
				  									LookupPage(
				  										title: 'Importar Grupo Tributário',
				  										colunas: TributGrupoTributario.colunas,
				  										campos: TributGrupoTributario.campos,
				  										rota: '/tribut-grupo-tributario/',
				  										campoPesquisaPadrao: 'pessoa?.nome',
				  									),
				  									fullscreenDialog: true,
				  								));
				  				if (objetoJsonRetorno != null) {
				  					if (objetoJsonRetorno['pessoa?.nome'] != null) {
				  						importaTributGrupoTributarioController.text = objetoJsonRetorno['pessoa?.nome'];
				  						widget.tributConfiguraOfGt.idTributGrupoTributario = objetoJsonRetorno['id'];
				  						widget.tributConfiguraOfGt.tributGrupoTributario = new TributGrupoTributario.fromJson(objetoJsonRetorno);
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
				  						widget.tributConfiguraOfGt?.tributOperacaoFiscal?.descricao = text;
				  						ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
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
				  										campoPesquisaPadrao: 'pessoa?.nome',
				  									),
				  									fullscreenDialog: true,
				  								));
				  				if (objetoJsonRetorno != null) {
				  					if (objetoJsonRetorno['pessoa?.nome'] != null) {
				  						importaTributOperacaoFiscalController.text = objetoJsonRetorno['pessoa?.nome'];
				  						widget.tributConfiguraOfGt.idTributOperacaoFiscal = objetoJsonRetorno['id'];
				  						widget.tributConfiguraOfGt.tributOperacaoFiscal = new TributOperacaoFiscal.fromJson(objetoJsonRetorno);
				  					}
				  				}
				  			},
				  		),
				  		),
				  	],
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
