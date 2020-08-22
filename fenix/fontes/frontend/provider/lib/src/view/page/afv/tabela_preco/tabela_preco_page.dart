/*
Title: T2Ti ERP Fenix                                                                
Description: AbaMestre Page relacionada à tabela [TABELA_PRECO] 
                                                                                
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
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fenix/src/model/model.dart';
import 'package:fenix/src/view_model/view_model.dart';
import 'package:fenix/src/view/shared/view_util_lib.dart';

import 'tabela_preco_persiste_page.dart';
import 'tabela_preco_produto_lista_page.dart';

List<Aba> _todasAsAbas = <Aba>[];

List<Aba> getAbasAtivas() {
  List<Aba> retorno = [];
  for (var item in _todasAsAbas) {
    if (item.visible) retorno.add(item);
  }
  return retorno;
}

class TabelaPrecoPage extends StatefulWidget {
  final TabelaPreco tabelaPreco;
  final String title;
  final String operacao;

  TabelaPrecoPage({this.tabelaPreco, this.title, this.operacao, Key key})
      : super(key: key);

  @override
  TabelaPrecoPageState createState() => TabelaPrecoPageState();
}

class TabelaPrecoPageState extends State<TabelaPrecoPage>
    with SingleTickerProviderStateMixin {
  TabController _abasController;
  String _estiloBotoesAba = 'iconsAndText';

  // TabelaPreco
  final GlobalKey<FormState> _tabelaPrecoPersisteFormKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _tabelaPrecoPersisteScaffoldKey = GlobalKey<ScaffoldState>();


  @override
  void initState() {
    super.initState();
    atualizarAbas();
    _abasController = TabController(vsync: this, length: getAbasAtivas().length);
    _abasController.addListener(salvarForms);
    ViewUtilLib.paginaMestreDetalheFoiAlterada = false; // vamos controlar as alterações nas paginas filhas aqui para alertar ao usuario sobre possivel perda de dados
  }

  @override
  void dispose() {
    _abasController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewUtilLib.getScaffoldAbaPage(
        widget.title,
        context,
        _abasController,
        getAbasAtivas(),
        getIndicator(),
        _estiloBotoesAba,
        salvarTabelaPreco,
        alterarEstiloBotoes,
        avisarUsuarioAlteracoesNaPagina);
  }

  void atualizarAbas() {
    _todasAsAbas.clear();
	 // a primeira aba sempre é a de Persistencia da tabela Mestre
    _todasAsAbas.add(Aba(
        icon: Icons.receipt,
        text: 'Detalhes',
        visible: true,
        pagina: TabelaPrecoPersistePage(
          formKey: _tabelaPrecoPersisteFormKey,
          scaffoldKey: _tabelaPrecoPersisteScaffoldKey,
          tabelaPreco: widget.tabelaPreco,
          atualizaTabelaPrecoCallBack: this.atualizarDados,
        )));
    _todasAsAbas.add(Aba(
    	icon: Icons.group,
    	text: 'Relação - Tabela Preco Produto',
    	visible: true,
    	pagina: TabelaPrecoProdutoListaPage(tabelaPreco: widget.tabelaPreco)));
  }

  void atualizarDados() { // serve para atualizar algum dado após alguma ação numa página filha
    setState(() {
    });
  }

  void salvarForms() {
    // valida e salva o form TabelaPrecoDetalhe
    FormState formTabelaPreco = _tabelaPrecoPersisteFormKey.currentState;
    if (formTabelaPreco != null) {
      if (!formTabelaPreco.validate()) {
        _abasController.animateTo(0);
      } else {
        _tabelaPrecoPersisteFormKey.currentState?.save();
      }
    }

    // valida e salva os forms OneToOne
  }

  void salvarTabelaPreco() async {
    salvarForms();
    var tabelaPrecoProvider = Provider.of<TabelaPrecoViewModel>(context);
    if (widget.operacao == 'A') {
      await tabelaPrecoProvider.alterar(widget.tabelaPreco);
    } else {
      await tabelaPrecoProvider.inserir(widget.tabelaPreco);
    }
    Navigator.pop(context);
  }

  void alterarEstiloBotoes(String style) {
    setState(() {
      _estiloBotoesAba = style;
    });
  }

  Decoration getIndicator() {
    return ViewUtilLib.getShapeDecorationAbaPage(_estiloBotoesAba);
  }

  Future<bool> avisarUsuarioAlteracoesNaPagina() async {
    if (!ViewUtilLib.paginaMestreDetalheFoiAlterada) return true;
    return await ViewUtilLib.gerarDialogBoxFormAlterado(context);
  }
}