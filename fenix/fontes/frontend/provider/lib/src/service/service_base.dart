/*
Title: T2Ti ERP Fenix                                                                
Description: Configuração base para os serviços REST
                                                                                
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
import 'dart:convert';
import 'package:fenix/src/model/filtro.dart';
import 'package:fenix/src/model/retorno_json_erro.dart';

class ServiceBase {
  /// utilizado no projeto apenas por conta de usarmos 5 servidores para o treinamento
  /// necessário para filtros multiplos com mais de um campo no where
  /// pode ser removido para um projeto que usa apenas um servidor
  static const linguagemServidor = 'delphi';

  static const _porta = '80';
  static const _enderecoServidor = 'http://d4f79f9b9242.ngrok.io';
  static const _endpoint = _enderecoServidor + ':' + _porta;
  get endpoint => _endpoint;

  static var _url = '';
  get url => _url;

  static var _objetoJsonErro = RetornoJsonErro();
  get objetoJsonErro => _objetoJsonErro;

  // o filtro deve ser enviado da seguinte forma: ?filter=field||$condition||value
  // referência: https://github.com/nestjsx/crud/wiki/Requests
  void tratarFiltro(Filtro filtro, String entidade) {
    var stringFiltro = '';

    if (filtro != null) {
      if (filtro.condicao == 'cont') {
        stringFiltro = '?filter=' + filtro.campo + '||\$cont' + '||' + filtro.valor;
      } else if (filtro.condicao == 'eq') {
        stringFiltro = '?filter=' + filtro.campo + '||\$eq' + '||' + filtro.valor;
      } else if (filtro.condicao == 'between') {
        stringFiltro = '?filter=' + filtro.campo + '||\$between' + '||' + filtro.dataInicial + ',' + filtro.dataFinal;
      } else if (filtro.condicao == 'where') { // nesse caso o filtro já foi montado na janela
        if (linguagemServidor == 'delphi') {
          filtro.where = filtro.where.replaceAll('&filter=', '?');
        }
        stringFiltro = filtro.where;
      }
    }

    _url = _endpoint + entidade + stringFiltro;
  }

  void tratarRetornoErro(String corpo, Map<String, String> headers) {
    if (headers["content-type"].contains("application/json")) {
      Map<String, dynamic> body = json.decode(corpo);  
      _objetoJsonErro.status = body['status']?.toString() ?? body['statuscode'].toString();
      _objetoJsonErro.error = body['error'] ?? body['classname'].toString();
      _objetoJsonErro.message = body['message'];
      _objetoJsonErro.trace = body['trace'];
      _objetoJsonErro.tipo = 'json';
    } else if (headers["content-type"].contains("html")) {
      _objetoJsonErro.message = corpo;
      _objetoJsonErro.tipo = 'html';
    } else if (headers["content-type"].contains("plain")) { // texto puro
      _objetoJsonErro.message = corpo;
      _objetoJsonErro.tipo = 'text';
    }
  }

  // void tratarRetorno(Map<String, dynamic> body) {
  //   _objetoJsonErro.status = body['status']?.toString() ?? body['statuscode'].toString();
  //   _objetoJsonErro.error = body['error'] ?? body['classname'].toString();
  //   _objetoJsonErro.message = body['message'];
  //   _objetoJsonErro.trace = body['trace'];
  // }

}