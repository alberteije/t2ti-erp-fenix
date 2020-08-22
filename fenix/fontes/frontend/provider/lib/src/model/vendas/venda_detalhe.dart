/*
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [VENDA_DETALHE] 
                                                                                
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

import 'package:fenix/src/model/model.dart';

class VendaDetalhe {
	int id;
	int idVendaCabecalho;
	int idProduto;
	double quantidade;
	double valorUnitario;
	double valorSubtotal;
	double taxaDesconto;
	double valorDesconto;
	double valorTotal;
	Produto produto;

	VendaDetalhe({
			this.id,
			this.idVendaCabecalho,
			this.idProduto,
			this.quantidade,
			this.valorUnitario,
			this.valorSubtotal,
			this.taxaDesconto,
			this.valorDesconto,
			this.valorTotal,
			this.produto,
		});

	static List<String> campos = <String>[
		'ID', 
		'QUANTIDADE', 
		'VALOR_UNITARIO', 
		'VALOR_SUBTOTAL', 
		'TAXA_DESCONTO', 
		'VALOR_DESCONTO', 
		'VALOR_TOTAL', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'Quantidade', 
		'Valor Unitário', 
		'Valor Subtotal', 
		'Taxa Desconto', 
		'Valor Desconto', 
		'Valor Total', 
	];

	VendaDetalhe.fromJson(Map<String, dynamic> jsonDados) {
		id = jsonDados['id'];
		idVendaCabecalho = jsonDados['idVendaCabecalho'];
		idProduto = jsonDados['idProduto'];
		quantidade = jsonDados['quantidade'] != null ? jsonDados['quantidade'].toDouble() : null;
		valorUnitario = jsonDados['valorUnitario'] != null ? jsonDados['valorUnitario'].toDouble() : null;
		valorSubtotal = jsonDados['valorSubtotal'] != null ? jsonDados['valorSubtotal'].toDouble() : null;
		taxaDesconto = jsonDados['taxaDesconto'] != null ? jsonDados['taxaDesconto'].toDouble() : null;
		valorDesconto = jsonDados['valorDesconto'] != null ? jsonDados['valorDesconto'].toDouble() : null;
		valorTotal = jsonDados['valorTotal'] != null ? jsonDados['valorTotal'].toDouble() : null;
		produto = jsonDados['produto'] == null ? null : new Produto.fromJson(jsonDados['produto']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = new Map<String, dynamic>();

		jsonDados['id'] = this.id ?? 0;
		jsonDados['idVendaCabecalho'] = this.idVendaCabecalho ?? 0;
		jsonDados['idProduto'] = this.idProduto ?? 0;
		jsonDados['quantidade'] = this.quantidade;
		jsonDados['valorUnitario'] = this.valorUnitario;
		jsonDados['valorSubtotal'] = this.valorSubtotal;
		jsonDados['taxaDesconto'] = this.taxaDesconto;
		jsonDados['valorDesconto'] = this.valorDesconto;
		jsonDados['valorTotal'] = this.valorTotal;
		jsonDados['produto'] = this.produto == null ? null : this.produto.toJson;
	
		return jsonDados;
	}
	

	String objetoEncodeJson(VendaDetalhe objeto) {
	  final jsonDados = objeto.toJson;
	  return json.encode(jsonDados);
	}
	
}