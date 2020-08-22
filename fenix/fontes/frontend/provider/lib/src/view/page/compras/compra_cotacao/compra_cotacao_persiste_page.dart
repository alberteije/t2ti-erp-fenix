/*
Title: T2Ti ERP Fenix                                                                
Description: AbaMestre PersistePage relacionada à tabela [COMPRA_COTACAO] 
                                                                                
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

class CompraCotacaoPersistePage extends StatefulWidget {
  final CompraCotacao compraCotacao;
  final GlobalKey<FormState> formKey;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function atualizaCompraCotacaoCallBack;

  const CompraCotacaoPersistePage(
      {Key key, this.formKey, this.scaffoldKey, this.compraCotacao, this.atualizaCompraCotacaoCallBack})
      : super(key: key);

  @override
  CompraCotacaoPersistePageState createState() => CompraCotacaoPersistePageState();
}

class CompraCotacaoPersistePageState extends State<CompraCotacaoPersistePage> {
  @override
  Widget build(BuildContext context) {
	var importaCompraRequisicaoController = TextEditingController();
	importaCompraRequisicaoController.text = widget.compraCotacao?.compraRequisicao?.descricao ?? '';

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
				  					controller: importaCompraRequisicaoController,
				  					readOnly: true,
				  					decoration: ViewUtilLib.getInputDecorationPersistePage(
				  						'Importe a Requisição Vinculada',
				  						'Requisição *',
				  						false),
				  					onSaved: (String value) {
				  					},
				  					validator: ValidaCampoFormulario.validarObrigatorio,
				  					onChanged: (text) {
				  						widget.compraCotacao?.compraRequisicao?.descricao = text;
				  						ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  					},
				  				),
				  			),
				  		),
				  		Expanded(
				  			flex: 0,
				  			child: IconButton(
				  				tooltip: 'Importar Requisição',
				  				icon: const Icon(Icons.search),
				  				onPressed: () async {
				  					///chamando o lookup
				  					Map<String, dynamic> objetoJsonRetorno =
				  						await Navigator.push(
				  							context,
				  							MaterialPageRoute(
				  								builder: (BuildContext context) =>
				  									LookupPage(
				  										title: 'Importar Requisição',
				  										colunas: CompraRequisicao.colunas,
				  										campos: CompraRequisicao.campos,
				  										rota: '/compra-requisicao/',
				  										campoPesquisaPadrao: 'descricao',
				  									),
				  									fullscreenDialog: true,
				  								));
				  				if (objetoJsonRetorno != null) {
				  					if (objetoJsonRetorno['descricao'] != null) {
				  						importaCompraRequisicaoController.text = objetoJsonRetorno['descricao'];
				  						widget.compraCotacao.idCompraRequisicao = objetoJsonRetorno['id'];
				  						widget.compraCotacao.compraRequisicao = new CompraRequisicao.fromJson(objetoJsonRetorno);
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
				  		'Informe a Data da Cotação',
				  		'Data da Cotação',
				  		true),
				  	isEmpty: widget.compraCotacao.dataCotacao == null,
				  	child: DatePickerItem(
				  		dateTime: widget.compraCotacao.dataCotacao,
				  		firstDate: DateTime.parse('1900-01-01'),
				  		lastDate: DateTime.now(),
				  		onChanged: (DateTime value) {
				  			ViewUtilLib.paginaMestreDetalheFoiAlterada = true;
				  			setState(() {
				  				widget.compraCotacao.dataCotacao = value;
				  			});
				  		},
				  	),
				  ),
				  const SizedBox(height: 24.0),
				  TextFormField(
				  	maxLength: 100,
				  	maxLines: 1,
				  	initialValue: widget.compraCotacao?.descricao ?? '',
				  	decoration: ViewUtilLib.getInputDecorationPersistePage(
				  		'Informe a Descrição da Cotação',
				  		'Descrição',
				  		false),
				  	onSaved: (String value) {
				  	},
				  	onChanged: (text) {
				  		widget.compraCotacao.descricao = text;
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
