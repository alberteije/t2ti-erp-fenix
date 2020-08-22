/*
Title: T2Ti ERP Fenix                                                                
Description: Caixa - Utilizado para a NFC-e e para o SAT CF-e
                                                                                
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

Based on: Flutter UI Challenges by Many - https://github.com/lohanidamodar/flutter_ui_challenges
*******************************************************************************/
import 'package:flutter/material.dart';
import 'package:bottomreveal/bottomreveal.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:fenix/src/view/shared/view_util_lib.dart';
import 'package:fenix/src/infra/constantes.dart';

class Caixa extends StatelessWidget {
  static final int _itens = 6;

  // https://pub.dev/packages/bottomreveal
  final BottomRevealController _menuController = BottomRevealController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Caixa"),
        actions: <Widget>[
          IconButton(
            icon: ViewUtilLib.getIconBotaoInserir(),
            tooltip: "Inserir produto",
            onPressed: () {},
          ),
          IconButton(
            icon: FaIcon(FontAwesomeIcons.barcode),
            tooltip: "Ler código de barras",
            onPressed: () {},
          ),
        ],
      ),
      body: BottomReveal(
        openIcon: Icons.menu,
        closeIcon: Icons.close,
        revealWidth: 100,
        revealHeight: 100,
        backColor: Colors.grey.shade600,
        frontColor: Colors.grey.shade300,
        rightContent: menuInternoDireita(),
        bottomContent: menuInternoRodape(),
        controller: _menuController,
        body: Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                itemCount: _itens,
                itemBuilder: (context, int index) {
                  return itensDaVenda(index);
                },
              ),
            ),
            rodape()
          ],
        ),
      ),
    );
  }

  Widget itensDaVenda(int index) {
    return ViewUtilLib.getProdutoDoCaixa(
        imagem: Constantes.menuBiImage,
        nome: "Livro a vida de harry potter e tudo mais e Item 1" + index.toString(),
        quantidade: 3.0 * index,
        valor: 120,
        subTotal: 650,
        estoque: 148,        
        onPressedExcluirItem: () {
          print("excluir item");
        },
        onTapDecrementa: () {
          print("decrementa");
        },
        onTapIncrementa: () {
          print("incrementa");
        },
      );
  }

  Widget rodape() {
    return Material(
      color: ViewUtilLib.getBottomAppBarColor(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 80),
              child: Row(
                children: <Widget>[
                  Text(
                    "Itens: " + _itens.toString(),
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue.shade900),
                  ),
                  Spacer(),
                  Text(
                    "R\$ 5000",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  )
                ],
              )),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 80, 10),
            child: SizedBox(
              width: double.infinity,
              child: RaisedButton(
                elevation: 2,
                padding: EdgeInsets.all(10.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.blueGrey.shade200)),
                onPressed: () {},
                color: Colors.blueGrey.shade500,
                textColor: Colors.white,
                child: Text("Encerrar Venda", style: TextStyle(fontSize: 18)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row menuInternoRodape() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ViewUtilLib.getBotaoInternoCaixa(
            texto: "Vendedor",
            icone: FontAwesomeIcons.userTie,
            tamanhoIcone: 35,
            corBotao: Colors.black54,
            paddingAll: 8,
            onPressed: () {
              _menuController.close();
            }),
        const SizedBox(width: 10.0),
        ViewUtilLib.getBotaoInternoCaixa(
            texto: "Cliente",
            icone: FontAwesomeIcons.userTag,
            tamanhoIcone: 35,
            corBotao: Colors.black45,
            paddingAll: 8,
            onPressed: () {
              _menuController.close();
            }),
        const SizedBox(width: 10.0),
        ViewUtilLib.getBotaoInternoCaixa(
            texto: "Gerente",
            icone: FontAwesomeIcons.portrait,
            tamanhoIcone: 35,
            corBotao: Colors.black38,
            paddingAll: 8,
            onPressed: () {
              _menuController.close();
            }),
      ],
    );
  }

  Column menuInternoDireita() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ViewUtilLib.getBotaoInternoCaixa(
            texto: "Salvar",
            icone: FontAwesomeIcons.save,
            tamanhoIcone: 30,
            corBotao: Colors.blueAccent.shade200,
            paddingAll: 0,
            onPressed: () {
              _menuController.close();
            }),
        const SizedBox(height: 10.0),
        ViewUtilLib.getBotaoInternoCaixa(
            texto: "Cancelar",
            icone: FontAwesomeIcons.windowClose,
            tamanhoIcone: 30,
            corBotao: Colors.redAccent.shade200,
            paddingAll: 0,
            onPressed: () {
              _menuController.close();
            }),
        const SizedBox(height: 10.0),
        ViewUtilLib.getBotaoInternoCaixa(
            texto: "Recuperar",
            icone: FontAwesomeIcons.redo,
            tamanhoIcone: 30,
            corBotao: Colors.orangeAccent.shade200,
            paddingAll: 0,
            onPressed: () {
              _menuController.close();
            }),
        const SizedBox(height: 10.0),
        ViewUtilLib.getBotaoInternoCaixa(
            texto: "Desconto",
            icone: FontAwesomeIcons.percentage,
            tamanhoIcone: 30,
            corBotao: Colors.greenAccent.shade700,
            paddingAll: 0,
            onPressed: () {
              _menuController.close();
            }),
      ],
    );
  }
}