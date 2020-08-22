/*
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [ESTOQUE_REAJUSTE_DETALHE] 
                                                                                
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

class EstoqueReajusteDetalhe {
	int id;
	int idEstoqueReajusteCabecalho;
	int idProduto;
	double valorOriginal;
	double valorReajuste;
	Produto produto;

	EstoqueReajusteDetalhe({
			this.id,
			this.idEstoqueReajusteCabecalho,
			this.idProduto,
			this.valorOriginal,
			this.valorReajuste,
			this.produto,
		});

	static List<String> campos = <String>[
		'ID', 
		'VALOR_ORIGINAL', 
		'VALOR_REAJUSTE', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'Valor Original', 
		'Valor Reajustado', 
	];

	EstoqueReajusteDetalhe.fromJson(Map<String, dynamic> jsonDados) {
		id = jsonDados['id'];
		idEstoqueReajusteCabecalho = jsonDados['idEstoqueReajusteCabecalho'];
		idProduto = jsonDados['idProduto'];
		valorOriginal = jsonDados['valorOriginal'] != null ? jsonDados['valorOriginal'].toDouble() : null;
		valorReajuste = jsonDados['valorReajuste'] != null ? jsonDados['valorReajuste'].toDouble() : null;
		produto = jsonDados['produto'] == null ? null : new Produto.fromJson(jsonDados['produto']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = new Map<String, dynamic>();

		jsonDados['id'] = this.id ?? 0;
		jsonDados['idEstoqueReajusteCabecalho'] = this.idEstoqueReajusteCabecalho ?? 0;
		jsonDados['idProduto'] = this.idProduto ?? 0;
		jsonDados['valorOriginal'] = this.valorOriginal;
		jsonDados['valorReajuste'] = this.valorReajuste;
		jsonDados['produto'] = this.produto == null ? null : this.produto.toJson;
	
		return jsonDados;
	}
	

	String objetoEncodeJson(EstoqueReajusteDetalhe objeto) {
	  final jsonDados = objeto.toJson;
	  return json.encode(jsonDados);
	}
	
}