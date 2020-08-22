/*
Title: T2Ti ERP Fenix                                                                
Description: ViewModel relacionado à tabela [OS_ABERTURA] 
                                                                                
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

import 'package:fenix/src/infra/locator.dart';
import 'package:fenix/src/model/model.dart';
import 'package:fenix/src/model/filtro.dart';
import 'package:fenix/src/model/retorno_json_erro.dart';
import 'package:fenix/src/service/service.dart';

class OsAberturaViewModel extends ChangeNotifier {
  OsAberturaService _osAberturaService = locator<OsAberturaService>();
  List<OsAbertura> listaOsAbertura;
  OsAbertura osAbertura;
  RetornoJsonErro objetoJsonErro;

  OsAberturaViewModel();

  Future<List<OsAbertura>> consultarLista({Filtro filtro}) async {
    listaOsAbertura = await _osAberturaService.consultarLista(filtro: filtro);
    if (listaOsAbertura == null) {
      objetoJsonErro = _osAberturaService.objetoJsonErro;
    }
    notifyListeners();
    return listaOsAbertura;
  }

  Future<OsAbertura> consultarObjeto(int id) async {
    osAbertura = await _osAberturaService.consultarObjeto(id);
    if (osAbertura == null) {
      objetoJsonErro = _osAberturaService.objetoJsonErro;
    }
    notifyListeners();
    return osAbertura;
  }

  Future<OsAbertura> inserir(OsAbertura osAbertura) async {
    var result = await _osAberturaService.inserir(osAbertura);
    if (result == null) {
      objetoJsonErro = _osAberturaService.objetoJsonErro;
    }
    notifyListeners();
    return result;
  }

  Future<OsAbertura> alterar(OsAbertura osAbertura) async {
    var result = await _osAberturaService.alterar(osAbertura);
    if (result == null) {
      objetoJsonErro = _osAberturaService.objetoJsonErro;
    }
    notifyListeners();
    return result;
  }

  Future<bool> excluir(int id) async {
    var result = await _osAberturaService.excluir(id);
    if (result == false) {
      objetoJsonErro = _osAberturaService.objetoJsonErro;
      notifyListeners();
    } else {
      consultarLista();
    }
    return result;
  }
}