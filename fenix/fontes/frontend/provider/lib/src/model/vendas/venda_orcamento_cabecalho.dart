/*
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [VENDA_ORCAMENTO_CABECALHO] 
                                                                                
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

import 'package:intl/intl.dart';
import 'package:fenix/src/model/model.dart';

class VendaOrcamentoCabecalho {
	int id;
	int idVendaCondicoesPagamento;
	int idVendedor;
	int idCliente;
	int idTransportadora;
	String codigo;
	DateTime dataCadastro;
	DateTime dataEntrega;
	DateTime validade;
	String tipoFrete;
	double valorSubtotal;
	double valorFrete;
	double taxaComissao;
	double valorComissao;
	double taxaDesconto;
	double valorDesconto;
	double valorTotal;
	String observacao;
	VendaCondicoesPagamento vendaCondicoesPagamento;
	Vendedor vendedor;
	Cliente cliente;
	Transportadora transportadora;
	List<VendaOrcamentoDetalhe> listaVendaOrcamentoDetalhe = [];

	VendaOrcamentoCabecalho({
			this.id,
			this.idVendaCondicoesPagamento,
			this.idVendedor,
			this.idCliente,
			this.idTransportadora,
			this.codigo,
			this.dataCadastro,
			this.dataEntrega,
			this.validade,
			this.tipoFrete,
			this.valorSubtotal = 0.0,
			this.valorFrete = 0.0,
			this.taxaComissao = 0.0,
			this.valorComissao = 0.0,
			this.taxaDesconto = 0.0,
			this.valorDesconto = 0.0,
			this.valorTotal = 0.0,
			this.observacao,
			this.vendaCondicoesPagamento,
			this.vendedor,
			this.cliente,
			this.transportadora,
			this.listaVendaOrcamentoDetalhe,
		});

	static List<String> campos = <String>[
		'ID', 
		'CODIGO', 
		'DATA_CADASTRO', 
		'DATA_ENTREGA', 
		'VALIDADE', 
		'TIPO_FRETE', 
		'VALOR_SUBTOTAL', 
		'VALOR_FRETE', 
		'TAXA_COMISSAO', 
		'VALOR_COMISSAO', 
		'TAXA_DESCONTO', 
		'VALOR_DESCONTO', 
		'VALOR_TOTAL', 
		'OBSERVACAO', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'Código do Orçamento', 
		'Data de Cadastro', 
		'Data de Entrega', 
		'Data de Validade', 
		'Tipo do Frete', 
		'Valor Subtotal', 
		'Valor Frete', 
		'Taxa Comissão', 
		'Valor Comissão', 
		'Taxa Desconto', 
		'Valor Desconto', 
		'Valor Total', 
		'Observação', 
	];

	VendaOrcamentoCabecalho.fromJson(Map<String, dynamic> jsonDados) {
		id = jsonDados['id'];
		idVendaCondicoesPagamento = jsonDados['idVendaCondicoesPagamento'];
		idVendedor = jsonDados['idVendedor'];
		idCliente = jsonDados['idCliente'];
		idTransportadora = jsonDados['idTransportadora'];
		codigo = jsonDados['codigo'];
		dataCadastro = jsonDados['dataCadastro'] != null ? DateTime.tryParse(jsonDados['dataCadastro']) : null;
		dataEntrega = jsonDados['dataEntrega'] != null ? DateTime.tryParse(jsonDados['dataEntrega']) : null;
		validade = jsonDados['validade'] != null ? DateTime.tryParse(jsonDados['validade']) : null;
		tipoFrete = getTipoFrete(jsonDados['tipoFrete']);
		valorSubtotal = jsonDados['valorSubtotal'] != null ? jsonDados['valorSubtotal'].toDouble() : 0.0;
		valorFrete = jsonDados['valorFrete'] != null ? jsonDados['valorFrete'].toDouble() : 0.0;
		taxaComissao = jsonDados['taxaComissao'] != null ? jsonDados['taxaComissao'].toDouble() : 0.0;
		valorComissao = jsonDados['valorComissao'] != null ? jsonDados['valorComissao'].toDouble() : 0.0;
		taxaDesconto = jsonDados['taxaDesconto'] != null ? jsonDados['taxaDesconto'].toDouble() : 0.0;
		valorDesconto = jsonDados['valorDesconto'] != null ? jsonDados['valorDesconto'].toDouble() : 0.0;
		valorTotal = jsonDados['valorTotal'] != null ? jsonDados['valorTotal'].toDouble() : 0.0;
		observacao = jsonDados['observacao'];
		vendaCondicoesPagamento = jsonDados['vendaCondicoesPagamento'] == null ? null : new VendaCondicoesPagamento.fromJson(jsonDados['vendaCondicoesPagamento']);
		vendedor = jsonDados['vendedor'] == null ? null : new Vendedor.fromJson(jsonDados['vendedor']);
		cliente = jsonDados['cliente'] == null ? null : new Cliente.fromJson(jsonDados['cliente']);
		transportadora = jsonDados['transportadora'] == null ? null : new Transportadora.fromJson(jsonDados['transportadora']);
		listaVendaOrcamentoDetalhe = (jsonDados['listaVendaOrcamentoDetalhe'] as Iterable)?.map((m) => VendaOrcamentoDetalhe.fromJson(m))?.toList() ?? [];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = new Map<String, dynamic>();

		jsonDados['id'] = this.id ?? 0;
		jsonDados['idVendaCondicoesPagamento'] = this.idVendaCondicoesPagamento ?? 0;
		jsonDados['idVendedor'] = this.idVendedor ?? 0;
		jsonDados['idCliente'] = this.idCliente ?? 0;
		jsonDados['idTransportadora'] = this.idTransportadora ?? 0;
		jsonDados['codigo'] = this.codigo;
		jsonDados['dataCadastro'] = this.dataCadastro != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.dataCadastro) : null;
		jsonDados['dataEntrega'] = this.dataEntrega != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.dataEntrega) : null;
		jsonDados['validade'] = this.validade != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.validade) : null;
		jsonDados['tipoFrete'] = setTipoFrete(this.tipoFrete);
		jsonDados['valorSubtotal'] = this.valorSubtotal;
		jsonDados['valorFrete'] = this.valorFrete;
		jsonDados['taxaComissao'] = this.taxaComissao;
		jsonDados['valorComissao'] = this.valorComissao;
		jsonDados['taxaDesconto'] = this.taxaDesconto;
		jsonDados['valorDesconto'] = this.valorDesconto;
		jsonDados['valorTotal'] = this.valorTotal;
		jsonDados['observacao'] = this.observacao;
		jsonDados['vendaCondicoesPagamento'] = this.vendaCondicoesPagamento == null ? null : this.vendaCondicoesPagamento.toJson;
		jsonDados['vendedor'] = this.vendedor == null ? null : this.vendedor.toJson;
		jsonDados['cliente'] = this.cliente == null ? null : this.cliente.toJson;
		jsonDados['transportadora'] = this.transportadora == null ? null : this.transportadora.toJson;
		

		var listaVendaOrcamentoDetalheLocal = [];
		for (VendaOrcamentoDetalhe objeto in this.listaVendaOrcamentoDetalhe ?? []) {
			listaVendaOrcamentoDetalheLocal.add(objeto.toJson);
		}
		jsonDados['listaVendaOrcamentoDetalhe'] = listaVendaOrcamentoDetalheLocal;
	
		return jsonDados;
	}
	
    getTipoFrete(String tipoFrete) {
    	switch (tipoFrete) {
    		case 'C':
    			return 'CIF';
    			break;
    		case 'F':
    			return 'FOB';
    			break;
    		default:
    			return null;
    		}
    	}

    setTipoFrete(String tipoFrete) {
    	switch (tipoFrete) {
    		case 'CIF':
    			return 'C';
    			break;
    		case 'FOB':
    			return 'F';
    			break;
    		default:
    			return null;
    		}
    	}


	String objetoEncodeJson(VendaOrcamentoCabecalho objeto) {
	  final jsonDados = objeto.toJson;
	  return json.encode(jsonDados);
	}
	
}