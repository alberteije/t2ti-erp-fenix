/*
Title: T2Ti ERP Fenix                                                                
Description: DetalhePage relacionada à tabela [NOTA_FISCAL_MODELO] 
                                                                                
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
import 'package:provider/provider.dart';

import 'package:fenix/src/model/model.dart';
import 'package:fenix/src/view_model/view_model.dart';
import 'package:fenix/src/view/shared/erro_page.dart';
import 'package:fenix/src/view/shared/view_util_lib.dart';
// import 'nota_fiscal_modelo_persiste_page.dart';

class NotaFiscalModeloDetalhePage extends StatelessWidget {
  final NotaFiscalModelo notaFiscalModelo;

  const NotaFiscalModeloDetalhePage({Key key, this.notaFiscalModelo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var notaFiscalModeloProvider = Provider.of<NotaFiscalModeloViewModel>(context);

    if (notaFiscalModeloProvider.objetoJsonErro != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Nota Fiscal Modelo'),
          actions: <Widget>[],
        ),
        body: ErroPage(
            objetoJsonErro:
                Provider.of<NotaFiscalModeloViewModel>(context).objetoJsonErro),
      );
    } else {
      return Theme(
          data: ViewUtilLib.getThemeDataDetalhePage(context),
          child: Scaffold(
            appBar: AppBar(title: Text('Nota Fiscal Modelo'), actions: <Widget>[
              // IconButton(
              //   icon: ViewUtilLib.getIconBotaoExcluir(),
              //   onPressed: () {
              //     return ViewUtilLib.gerarDialogBoxExclusao(context, () {
              //       notaFiscalModeloProvider.excluir(notaFiscalModelo.id);
              //       Navigator.of(context).pop();
              //       Navigator.of(context).pop();
              //     });
              //   },
              // ),
              // IconButton(
              //   icon: ViewUtilLib.getIconBotaoAlterar(),
              //   onPressed: () {
              //     Navigator.of(context).push(MaterialPageRoute(
              //         builder: (BuildContext context) => NotaFiscalModeloPersistePage(
              //             notaFiscalModelo: notaFiscalModelo,
              //             title: 'Nota Fiscal Modelo - Editando',
              //             operacao: 'A')));
              //   },
              // ),
            ]),
            body: SingleChildScrollView(
              child: Theme(
                data: ThemeData(fontFamily: 'Raleway'),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ViewUtilLib.getPaddingDetalhePage('Detalhes de Nota Fiscal Modelo'),
                    Card(
                      color: Colors.white,
                      elevation: 2.0,
                      child: Column(
                        children: <Widget>[
                        ViewUtilLib.getListTileDataDetalhePageId(
                            notaFiscalModelo.id?.toString() ?? '', 'Id'),
						ViewUtilLib.getListTileDataDetalhePage(
							notaFiscalModelo.codigo ?? '', 'Código do Modelo'),
						ViewUtilLib.getListTileDataDetalhePage(
							notaFiscalModelo.descricao ?? '', 'Descrição'),
						ViewUtilLib.getListTileDataDetalhePage(
							notaFiscalModelo.modelo ?? '', 'Modelo'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ));
    }
  }
}