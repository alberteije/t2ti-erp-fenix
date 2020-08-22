/*
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [COMPRA_PEDIDO_DETALHE] 
                                                                                
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

class CompraPedidoDetalhe {
	int id;
	int idCompraPedido;
	int idProduto;
	double quantidade;
	double valorUnitario;
	double valorSubtotal;
	double taxaDesconto;
	double valorDesconto;
	double valorTotal;
	String cst;
	String csosn;
	int cfop;
	double baseCalculoIcms;
	double valorIcms;
	double valorIpi;
	double aliquotaIcms;
	double aliquotaIpi;
	Produto produto;

	CompraPedidoDetalhe({
			this.id,
			this.idCompraPedido,
			this.idProduto,
			this.quantidade,
			this.valorUnitario,
			this.valorSubtotal,
			this.taxaDesconto,
			this.valorDesconto,
			this.valorTotal,
			this.cst,
			this.csosn,
			this.cfop,
			this.baseCalculoIcms,
			this.valorIcms,
			this.valorIpi,
			this.aliquotaIcms,
			this.aliquotaIpi,
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
		'CST', 
		'CSOSN', 
		'CFOP', 
		'BASE_CALCULO_ICMS', 
		'VALOR_ICMS', 
		'VALOR_IPI', 
		'ALIQUOTA_ICMS', 
		'ALIQUOTA_IPI', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'Quantidade', 
		'Valor Unitário', 
		'Valor Subtotal', 
		'Taxa Desconto', 
		'Valor Desconto', 
		'Valor Total', 
		'CST', 
		'CSOSN', 
		'CFOP', 
		'CFOP', 
		'Valor do ICMS', 
		'Valor do IPI', 
		'Alíquota do ICMS', 
		'Alíquota do IPI', 
	];

	CompraPedidoDetalhe.fromJson(Map<String, dynamic> jsonDados) {
		id = jsonDados['id'];
		idCompraPedido = jsonDados['idCompraPedido'];
		idProduto = jsonDados['idProduto'];
		quantidade = jsonDados['quantidade'] != null ? jsonDados['quantidade'].toDouble() : null;
		valorUnitario = jsonDados['valorUnitario'] != null ? jsonDados['valorUnitario'].toDouble() : null;
		valorSubtotal = jsonDados['valorSubtotal'] != null ? jsonDados['valorSubtotal'].toDouble() : null;
		taxaDesconto = jsonDados['taxaDesconto'] != null ? jsonDados['taxaDesconto'].toDouble() : null;
		valorDesconto = jsonDados['valorDesconto'] != null ? jsonDados['valorDesconto'].toDouble() : null;
		valorTotal = jsonDados['valorTotal'] != null ? jsonDados['valorTotal'].toDouble() : null;
		cst = jsonDados['cst'];
		csosn = jsonDados['csosn'];
		cfop = jsonDados['cfop'];
		baseCalculoIcms = jsonDados['baseCalculoIcms'] != null ? jsonDados['baseCalculoIcms'].toDouble() : null;
		valorIcms = jsonDados['valorIcms'] != null ? jsonDados['valorIcms'].toDouble() : null;
		valorIpi = jsonDados['valorIpi'] != null ? jsonDados['valorIpi'].toDouble() : null;
		aliquotaIcms = jsonDados['aliquotaIcms'] != null ? jsonDados['aliquotaIcms'].toDouble() : null;
		aliquotaIpi = jsonDados['aliquotaIpi'] != null ? jsonDados['aliquotaIpi'].toDouble() : null;
		produto = jsonDados['produto'] == null ? null : new Produto.fromJson(jsonDados['produto']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = new Map<String, dynamic>();

		jsonDados['id'] = this.id ?? 0;
		jsonDados['idCompraPedido'] = this.idCompraPedido ?? 0;
		jsonDados['idProduto'] = this.idProduto ?? 0;
		jsonDados['quantidade'] = this.quantidade;
		jsonDados['valorUnitario'] = this.valorUnitario;
		jsonDados['valorSubtotal'] = this.valorSubtotal;
		jsonDados['taxaDesconto'] = this.taxaDesconto;
		jsonDados['valorDesconto'] = this.valorDesconto;
		jsonDados['valorTotal'] = this.valorTotal;
		jsonDados['cst'] = this.cst;
		jsonDados['csosn'] = this.csosn;
		jsonDados['cfop'] = this.cfop ?? 0;
		jsonDados['baseCalculoIcms'] = this.baseCalculoIcms;
		jsonDados['valorIcms'] = this.valorIcms;
		jsonDados['valorIpi'] = this.valorIpi;
		jsonDados['aliquotaIcms'] = this.aliquotaIcms;
		jsonDados['aliquotaIpi'] = this.aliquotaIpi;
		jsonDados['produto'] = this.produto == null ? null : this.produto.toJson;
	
		return jsonDados;
	}
	

	String objetoEncodeJson(CompraPedidoDetalhe objeto) {
	  final jsonDados = objeto.toJson;
	  return json.encode(jsonDados);
	}
	
}