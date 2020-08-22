/*
Title: T2Ti ERP Fenix                                                                
Description: Classe que armazena alguns métodos úteis para as classes da aplicação.
                                                                                
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
import 'constantes.dart';

class Biblioteca {
  /// singleton
  factory Biblioteca() {
    _this ??= Biblioteca._();
    return _this;
  }
  static Biblioteca _this;
  Biblioteca._() : super();

  /// remove a máscara de uma string
  /// útil para campos do tipo: CPF, CNPJ, CEP, etc
  static String removerMascara(dynamic value) {
    if (value != null) {
      return value.replaceAll(new RegExp(r'[^\w\s]+'), '');
    } else {
      return null;
    }
  }

  /// calcula valor de juros
  static double calcularJuros(double valor, double taxaJuros, DateTime dataVencimento) {
    if (valor == null) {
      valor = 0;
    }
    if (taxaJuros == null) {
      taxaJuros = 0;
    }
    double valorJuros = (valor * (taxaJuros / 30) / 100) * (DateTime.now().difference(dataVencimento).inDays);
    valorJuros = num.parse(valorJuros.toStringAsFixed(Constantes.decimaisValor)); 
    return valorJuros;
  }

  /// calcula valor de multa
  static double calcularMulta(double valor, double taxaMulta) {
    if (valor == null) {
      valor = 0;
    }
    if (taxaMulta == null) {
      taxaMulta = 0;
    }
    double valorMulta = (valor * (taxaMulta / 100));
    valorMulta = num.parse(valorMulta.toStringAsFixed(Constantes.decimaisValor)); 
    return valorMulta;
  }

  /// calcula valor de desconto
  static double calcularDesconto(double valor, double taxaDesconto) {
    if (valor == null) {
      valor = 0;
    }
    if (taxaDesconto == null) {
      taxaDesconto = 0;
    }
    double valorDesconto = (valor * (taxaDesconto / 100));
    valorDesconto = num.parse(valorDesconto.toStringAsFixed(Constantes.decimaisValor)); 
    return valorDesconto;
  }  

  /// calcula valor da comissão
  static double calcularComissao(double valor, double taxaComissao) {
    if (valor == null) {
      valor = 0;
    }
    if (taxaComissao == null) {
      taxaComissao = 0;
    }
    double valorComissao = (valor * (taxaComissao / 100));
    valorComissao = num.parse(valorComissao.toStringAsFixed(Constantes.decimaisValor)); 
    return valorComissao;
  }  

  /// calcula a multiplicacao entre dois números e retorna o valor com as devidas casas decimais
  static double multiplicarMonetario(double valor1, double valor2) {
    if (valor1 == null) {
      valor1 = 0;
    }
    if (valor2 == null) {
      valor2 = 0;
    }

    double resultado = num.parse((valor1 * valor2).toStringAsFixed(Constantes.decimaisValor));
    return resultado;
  }  

  /// calcula a divisão entre dois números e retorna o valor com as devidas casas decimais
  static double dividirMonetario(double valor1, double valor2) {
    if (valor1 == null) {
      valor1 = 0;
    }
    if (valor2 == null) {
      valor2 = 0;
    }

    double resultado = num.parse((valor1 / valor2).toStringAsFixed(Constantes.decimaisValor));
    return resultado;
  }  

  /// pega um período anterior com a máscara MM/AAAA
  static String periodoAnterior(String mesAno) {                         
    int mes = int.tryParse(mesAno.substring(0, 2));
    int ano = int.tryParse(mesAno.substring(3, 7)); 

    if (mes == 1) {
      mes = 12;
      ano = ano - 1;
      return mes.toString() + '/' + ano.toString();
    } else {
      mes = mes - 1;
      return mes.toString().padLeft(2,'0') + '/' + ano.toString();
    }
  }

}
