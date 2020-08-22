/*
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [COMPRA_FORNECEDOR_COTACAO] 
                                                                                
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

class CompraFornecedorCotacao {
	int id;
	int idCompraCotacao;
	int idFornecedor;
	String codigo;
	String prazoEntrega;
	String vendaCondicoesPagamento;
	double valorSubtotal;
	double taxaDesconto;
	double valorDesconto;
	double valorTotal;
	Fornecedor fornecedor;
	List<CompraCotacaoDetalhe> listaCompraCotacaoDetalhe = [];

	CompraFornecedorCotacao({
			this.id,
			this.idCompraCotacao,
			this.idFornecedor,
			this.codigo,
			this.prazoEntrega,
			this.vendaCondicoesPagamento,
			this.valorSubtotal,
			this.taxaDesconto,
			this.valorDesconto,
			this.valorTotal,
			this.fornecedor,
			this.listaCompraCotacaoDetalhe,
		});

	static List<String> campos = <String>[
		'ID', 
		'CODIGO', 
		'PRAZO_ENTREGA', 
		'VENDA_CONDICOES_PAGAMENTO', 
		'VALOR_SUBTOTAL', 
		'TAXA_DESCONTO', 
		'VALOR_DESCONTO', 
		'VALOR_TOTAL', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'Código da Cotação', 
		'Prazo de Entrega', 
		'Condições de Pagamento', 
		'Valor Subtotal', 
		'Taxa Desconto', 
		'Valor Desconto', 
		'Valor Total', 
	];

	CompraFornecedorCotacao.fromJson(Map<String, dynamic> jsonDados) {
		id = jsonDados['id'];
		idCompraCotacao = jsonDados['idCompraCotacao'];
		idFornecedor = jsonDados['idFornecedor'];
		codigo = jsonDados['codigo'];
		prazoEntrega = jsonDados['prazoEntrega'];
		vendaCondicoesPagamento = jsonDados['vendaCondicoesPagamento'];
		valorSubtotal = jsonDados['valorSubtotal'] != null ? jsonDados['valorSubtotal'].toDouble() : null;
		taxaDesconto = jsonDados['taxaDesconto'] != null ? jsonDados['taxaDesconto'].toDouble() : null;
		valorDesconto = jsonDados['valorDesconto'] != null ? jsonDados['valorDesconto'].toDouble() : null;
		valorTotal = jsonDados['valorTotal'] != null ? jsonDados['valorTotal'].toDouble() : null;
		fornecedor = jsonDados['fornecedor'] == null ? null : new Fornecedor.fromJson(jsonDados['fornecedor']);
		listaCompraCotacaoDetalhe = (jsonDados['listaCompraCotacaoDetalhe'] as Iterable)?.map((m) => CompraCotacaoDetalhe.fromJson(m))?.toList() ?? [];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = new Map<String, dynamic>();

		jsonDados['id'] = this.id ?? 0;
		jsonDados['idCompraCotacao'] = this.idCompraCotacao ?? 0;
		jsonDados['idFornecedor'] = this.idFornecedor ?? 0;
		jsonDados['codigo'] = this.codigo;
		jsonDados['prazoEntrega'] = this.prazoEntrega;
		jsonDados['vendaCondicoesPagamento'] = this.vendaCondicoesPagamento;
		jsonDados['valorSubtotal'] = this.valorSubtotal;
		jsonDados['taxaDesconto'] = this.taxaDesconto;
		jsonDados['valorDesconto'] = this.valorDesconto;
		jsonDados['valorTotal'] = this.valorTotal;
		jsonDados['fornecedor'] = this.fornecedor == null ? null : this.fornecedor.toJson;
		

		var listaCompraCotacaoDetalheLocal = [];
		for (CompraCotacaoDetalhe objeto in this.listaCompraCotacaoDetalhe ?? []) {
			listaCompraCotacaoDetalheLocal.add(objeto.toJson);
		}
		jsonDados['listaCompraCotacaoDetalhe'] = listaCompraCotacaoDetalheLocal;
	
		return jsonDados;
	}
	

	String objetoEncodeJson(CompraFornecedorCotacao objeto) {
	  final jsonDados = objeto.toJson;
	  return json.encode(jsonDados);
	}
	
}