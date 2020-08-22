/*
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [TABELA_PRECO] 
                                                                                
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

class TabelaPreco {
	int id;
	String nome;
	String principal;
	double coeficiente;
	List<TabelaPrecoProduto> listaTabelaPrecoProduto = [];

	TabelaPreco({
			this.id,
			this.nome,
			this.principal,
			this.coeficiente = 0.0,
			this.listaTabelaPrecoProduto,
		});

	static List<String> campos = <String>[
		'ID', 
		'NOME', 
		'PRINCIPAL', 
		'COEFICIENTE', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'Nome', 
		'Principal', 
		'Coeficiente', 
	];

	TabelaPreco.fromJson(Map<String, dynamic> jsonDados) {
		id = jsonDados['id'];
		nome = jsonDados['nome'];
		principal = getPrincipal(jsonDados['principal']);
		coeficiente = jsonDados['coeficiente'] != null ? jsonDados['coeficiente'].toDouble() : null;
		listaTabelaPrecoProduto = (jsonDados['listaTabelaPrecoProduto'] as Iterable)?.map((m) => TabelaPrecoProduto.fromJson(m))?.toList() ?? [];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = new Map<String, dynamic>();

		jsonDados['id'] = this.id ?? 0;
		jsonDados['nome'] = this.nome;
		jsonDados['principal'] = setPrincipal(this.principal);
		jsonDados['coeficiente'] = this.coeficiente;
		

		var listaTabelaPrecoProdutoLocal = [];
		for (TabelaPrecoProduto objeto in this.listaTabelaPrecoProduto ?? []) {
			listaTabelaPrecoProdutoLocal.add(objeto.toJson);
		}
		jsonDados['listaTabelaPrecoProduto'] = listaTabelaPrecoProdutoLocal;
	
		return jsonDados;
	}
	
    getPrincipal(String principal) {
    	switch (principal) {
    		case 'S':
    			return 'Sim';
    			break;
    		case 'N':
    			return 'Não';
    			break;
    		default:
    			return null;
    		}
    	}

    setPrincipal(String principal) {
    	switch (principal) {
    		case 'Sim':
    			return 'S';
    			break;
    		case 'Não':
    			return 'N';
    			break;
    		default:
    			return null;
    		}
    	}


	String objetoEncodeJson(TabelaPreco objeto) {
	  final jsonDados = objeto.toJson;
	  return json.encode(jsonDados);
	}
	
}