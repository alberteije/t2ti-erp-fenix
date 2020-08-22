/*
Title: T2Ti ERP Fenix                                                                
Description: Classe que valida os campos do formulário
                                                                                
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
import 'package:cpf_cnpj_validator/cnpj_validator.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';

class ValidaCampoFormulario {
  /// factory - teremos apenas uma instância de ValidaCampoFormulario - singleton
  factory ValidaCampoFormulario() {
    _this ??= ValidaCampoFormulario._();
    return _this;
  }
  static ValidaCampoFormulario _this;
  ValidaCampoFormulario._() : super();

  /// valida campo obrigatório
  static String validarObrigatorio(String value) {
    if (value.isEmpty) return 'Obrigatório informar esse campo.';
    return null;
  }

  /// valida campos decimais como obrigatórios
  static String validarObrigatorioDecimal(String value) {
    if (value == '0,00') return 'Obrigatório informar esse campo.';
    return null;
  }

  /// validar se os caracteres são alfanumericos
  static String validarAlfanumerico(String value) {
    final RegExp nameExp = RegExp(r'^[A-Za-z0-9. ]+$');
    if (!nameExp.hasMatch(value))
      return 'Por favor, informe apenas caracteres alfanuméricos.';
    return null;
  }

  /// validar o campo como obrigatório e verificar se os caracteres são alfanumericos
  static String validarObrigatorioAlfanumerico(String value) {
    var campoObrigario = validarObrigatorio(value);
    if (campoObrigario == null) {
      return validarAlfanumerico(value);
    } else {
      return campoObrigario;
    }
  }

  /// validar se os caracteres são numericos
  static String validarNumerico(String value) {
    final RegExp nameExp = RegExp(r'^[0-9]+$');
    if (!nameExp.hasMatch(value))
      return 'Por favor, informe apenas caracteres numéricos.';
    return null;
  }

  /// validar o campo como obrigatório e verificar se os caracteres são numericos
  static String validarObrigatorioNumerico(String value) {
    var campoObrigario = validarObrigatorio(value);
    if (campoObrigario == null) {
      return validarNumerico(value);
    } else {
      return campoObrigario;
    }
  }

  /// validar se o conteúdo do campo é um CNPJ válido
  static String validarObrigatorioCNPJ(String value) {
    var campoObrigario = validarObrigatorio(value);
    if (campoObrigario == null) {
      return validarCNPJ(value);
    } else {
      return campoObrigario;
    }
  }

  static String validarCNPJ(String value) {
    if (value != "") {
      var cnpjValido = CNPJValidator.isValid(value);
      if (cnpjValido) {
        return null;
      } else {
        return 'Por favor, informe um CNPJ válido.';
      }
    } else {
      return null;
    }
  }

  /// validar se o conteúdo do campo é um CPF válido
  static String validarObrigatorioCPF(String value) {
    if (value != "") {
      var campoObrigario = validarObrigatorio(value);
      if (campoObrigario == null) {
        return validarCPF(value);
      } else {
        return campoObrigario;
      }
    } else {
      return null;
    }
  }

  static String validarCPF(String value) {
    var cpfValido = CPFValidator.isValid(value);
    if (cpfValido) {
      return null;
    } else {
      return 'Por favor, informe um CPF válido.';
    }
  }

  /// validar se o conteúdo do campo é um DIA válido
  static String validarObrigatorioDIA(String value) {
    var campoObrigario = validarObrigatorio(value);
    if (campoObrigario == null) {
      return validarDIA(value);
    } else {
      return campoObrigario;
    }
  }

  static String validarDIA(String value) {
    int mes = int.tryParse(value);
    if (mes >= 1 && mes <= 30) {
      return null;
    } else {
      return 'Por favor, informe um DIA válido.';
    }
  }

  static String validarHORA(String value) {
    return null;
  }

  /// validar se o conteúdo do campo é um MÊS válido
  static String validarObrigatorioMES(String value) {
    var campoObrigario = validarObrigatorio(value);
    if (campoObrigario == null) {
      return validarMES(value);
    } else {
      return campoObrigario;
    }
  }

  static String validarMES(String value) {
    int mes = int.tryParse(value);
    if (mes >= 1 && mes <= 12) {
      return null;
    } else {
      return 'Por favor, informe um MÊS válido.';
    }
  }
}
