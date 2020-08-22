/*
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [COMPRA_PEDIDO] 
                                                                                
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
import 'package:fenix/src/infra/biblioteca.dart';
import 'package:fenix/src/model/model.dart';

class CompraPedido {
	int id;
	int idCompraTipoPedido;
	int idFornecedor;
	int idColaborador;
	DateTime dataPedido;
	DateTime dataPrevistaEntrega;
	DateTime dataPrevisaoPagamento;
	String localEntrega;
	String localCobranca;
	String contato;
	double valorSubtotal;
	double taxaDesconto;
	double valorDesconto;
	double valorTotal;
	String tipoFrete;
	String formaPagamento;
	double baseCalculoIcms;
	double valorIcms;
	double baseCalculoIcmsSt;
	double valorIcmsSt;
	double valorTotalProdutos;
	double valorFrete;
	double valorSeguro;
	double valorOutrasDespesas;
	double valorIpi;
	double valorTotalNf;
	int quantidadeParcelas;
	String diaPrimeiroVencimento;
	int intervaloEntreParcelas;
	String diaFixoParcela;
	String codigoCotacao;
	CompraTipoPedido compraTipoPedido;
	Fornecedor fornecedor;
	Colaborador colaborador;
	List<CompraPedidoDetalhe> listaCompraPedidoDetalhe = [];

	CompraPedido({
			this.id,
			this.idCompraTipoPedido,
			this.idFornecedor,
			this.idColaborador,
			this.dataPedido,
			this.dataPrevistaEntrega,
			this.dataPrevisaoPagamento,
			this.localEntrega,
			this.localCobranca,
			this.contato,
			this.valorSubtotal,
			this.taxaDesconto,
			this.valorDesconto,
			this.valorTotal,
			this.tipoFrete,
			this.formaPagamento,
			this.baseCalculoIcms,
			this.valorIcms,
			this.baseCalculoIcmsSt,
			this.valorIcmsSt,
			this.valorTotalProdutos,
			this.valorFrete,
			this.valorSeguro,
			this.valorOutrasDespesas,
			this.valorIpi,
			this.valorTotalNf,
			this.quantidadeParcelas,
			this.diaPrimeiroVencimento,
			this.intervaloEntreParcelas,
			this.diaFixoParcela,
			this.codigoCotacao,
			this.compraTipoPedido,
			this.fornecedor,
			this.colaborador,
			this.listaCompraPedidoDetalhe,
		});

	static List<String> campos = <String>[
		'ID', 
		'DATA_PEDIDO', 
		'DATA_PREVISTA_ENTREGA', 
		'DATA_PREVISAO_PAGAMENTO', 
		'LOCAL_ENTREGA', 
		'LOCAL_COBRANCA', 
		'CONTATO', 
		'VALOR_SUBTOTAL', 
		'TAXA_DESCONTO', 
		'VALOR_DESCONTO', 
		'VALOR_TOTAL', 
		'TIPO_FRETE', 
		'FORMA_PAGAMENTO', 
		'BASE_CALCULO_ICMS', 
		'VALOR_ICMS', 
		'BASE_CALCULO_ICMS_ST', 
		'VALOR_ICMS_ST', 
		'VALOR_TOTAL_PRODUTOS', 
		'VALOR_FRETE', 
		'VALOR_SEGURO', 
		'VALOR_OUTRAS_DESPESAS', 
		'VALOR_IPI', 
		'VALOR_TOTAL_NF', 
		'QUANTIDADE_PARCELAS', 
		'DIA_PRIMEIRO_VENCIMENTO', 
		'INTERVALO_ENTRE_PARCELAS', 
		'DIA_FIXO_PARCELA', 
		'CODIGO_COTACAO', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'Data do Pedido', 
		'Data Prevista para Entrega', 
		'Data Previsão Pagamento', 
		'Local de Entrega', 
		'Local de Cobrança', 
		'Nome do Contato', 
		'Valor Subtotal', 
		'Taxa Desconto', 
		'Valor Desconto', 
		'Valor Total', 
		'Tipo do Frete', 
		'Forma de Pagamento', 
		'Base Cálculo ICMS', 
		'Valor do ICMS', 
		'Base Cálculo ICMS ST', 
		'Valor do ICMS ST', 
		'Valor Total Produtos', 
		'Valor Frete', 
		'Valor Seguro', 
		'Valor Outras Despesas', 
		'Valor do IPI', 
		'Valor Total NF', 
		'Quantidade de Parcelas', 
		'Dia Primeiro Vencimento', 
		'Intervalo entre Parcelas', 
		'Dia Fixo da Parcela', 
		'Código da Cotação', 
	];

	CompraPedido.fromJson(Map<String, dynamic> jsonDados) {
		id = jsonDados['id'];
		idCompraTipoPedido = jsonDados['idCompraTipoPedido'];
		idFornecedor = jsonDados['idFornecedor'];
		idColaborador = jsonDados['idColaborador'];
		dataPedido = jsonDados['dataPedido'] != null ? DateTime.tryParse(jsonDados['dataPedido']) : null;
		dataPrevistaEntrega = jsonDados['dataPrevistaEntrega'] != null ? DateTime.tryParse(jsonDados['dataPrevistaEntrega']) : null;
		dataPrevisaoPagamento = jsonDados['dataPrevisaoPagamento'] != null ? DateTime.tryParse(jsonDados['dataPrevisaoPagamento']) : null;
		localEntrega = jsonDados['localEntrega'];
		localCobranca = jsonDados['localCobranca'];
		contato = jsonDados['contato'];
		valorSubtotal = jsonDados['valorSubtotal'] != null ? jsonDados['valorSubtotal'].toDouble() : null;
		taxaDesconto = jsonDados['taxaDesconto'] != null ? jsonDados['taxaDesconto'].toDouble() : null;
		valorDesconto = jsonDados['valorDesconto'] != null ? jsonDados['valorDesconto'].toDouble() : null;
		valorTotal = jsonDados['valorTotal'] != null ? jsonDados['valorTotal'].toDouble() : null;
		tipoFrete = getTipoFrete(jsonDados['tipoFrete']);
		formaPagamento = getFormaPagamento(jsonDados['formaPagamento']);
		baseCalculoIcms = jsonDados['baseCalculoIcms'] != null ? jsonDados['baseCalculoIcms'].toDouble() : null;
		valorIcms = jsonDados['valorIcms'] != null ? jsonDados['valorIcms'].toDouble() : null;
		baseCalculoIcmsSt = jsonDados['baseCalculoIcmsSt'] != null ? jsonDados['baseCalculoIcmsSt'].toDouble() : null;
		valorIcmsSt = jsonDados['valorIcmsSt'] != null ? jsonDados['valorIcmsSt'].toDouble() : null;
		valorTotalProdutos = jsonDados['valorTotalProdutos'] != null ? jsonDados['valorTotalProdutos'].toDouble() : null;
		valorFrete = jsonDados['valorFrete'] != null ? jsonDados['valorFrete'].toDouble() : null;
		valorSeguro = jsonDados['valorSeguro'] != null ? jsonDados['valorSeguro'].toDouble() : null;
		valorOutrasDespesas = jsonDados['valorOutrasDespesas'] != null ? jsonDados['valorOutrasDespesas'].toDouble() : null;
		valorIpi = jsonDados['valorIpi'] != null ? jsonDados['valorIpi'].toDouble() : null;
		valorTotalNf = jsonDados['valorTotalNf'] != null ? jsonDados['valorTotalNf'].toDouble() : null;
		quantidadeParcelas = jsonDados['quantidadeParcelas'];
		diaPrimeiroVencimento = jsonDados['diaPrimeiroVencimento'];
		intervaloEntreParcelas = jsonDados['intervaloEntreParcelas'];
		diaFixoParcela = jsonDados['diaFixoParcela'];
		codigoCotacao = jsonDados['codigoCotacao'];
		compraTipoPedido = jsonDados['compraTipoPedido'] == null ? null : new CompraTipoPedido.fromJson(jsonDados['compraTipoPedido']);
		fornecedor = jsonDados['fornecedor'] == null ? null : new Fornecedor.fromJson(jsonDados['fornecedor']);
		colaborador = jsonDados['colaborador'] == null ? null : new Colaborador.fromJson(jsonDados['colaborador']);
		listaCompraPedidoDetalhe = (jsonDados['listaCompraPedidoDetalhe'] as Iterable)?.map((m) => CompraPedidoDetalhe.fromJson(m))?.toList() ?? [];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = new Map<String, dynamic>();

		jsonDados['id'] = this.id ?? 0;
		jsonDados['idCompraTipoPedido'] = this.idCompraTipoPedido ?? 0;
		jsonDados['idFornecedor'] = this.idFornecedor ?? 0;
		jsonDados['idColaborador'] = this.idColaborador ?? 0;
		jsonDados['dataPedido'] = this.dataPedido != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.dataPedido) : null;
		jsonDados['dataPrevistaEntrega'] = this.dataPrevistaEntrega != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.dataPrevistaEntrega) : null;
		jsonDados['dataPrevisaoPagamento'] = this.dataPrevisaoPagamento != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.dataPrevisaoPagamento) : null;
		jsonDados['localEntrega'] = this.localEntrega;
		jsonDados['localCobranca'] = this.localCobranca;
		jsonDados['contato'] = this.contato;
		jsonDados['valorSubtotal'] = this.valorSubtotal;
		jsonDados['taxaDesconto'] = this.taxaDesconto;
		jsonDados['valorDesconto'] = this.valorDesconto;
		jsonDados['valorTotal'] = this.valorTotal;
		jsonDados['tipoFrete'] = setTipoFrete(this.tipoFrete);
		jsonDados['formaPagamento'] = setFormaPagamento(this.formaPagamento);
		jsonDados['baseCalculoIcms'] = this.baseCalculoIcms;
		jsonDados['valorIcms'] = this.valorIcms;
		jsonDados['baseCalculoIcmsSt'] = this.baseCalculoIcmsSt;
		jsonDados['valorIcmsSt'] = this.valorIcmsSt;
		jsonDados['valorTotalProdutos'] = this.valorTotalProdutos;
		jsonDados['valorFrete'] = this.valorFrete;
		jsonDados['valorSeguro'] = this.valorSeguro;
		jsonDados['valorOutrasDespesas'] = this.valorOutrasDespesas;
		jsonDados['valorIpi'] = this.valorIpi;
		jsonDados['valorTotalNf'] = this.valorTotalNf;
		jsonDados['quantidadeParcelas'] = this.quantidadeParcelas ?? 0;
		jsonDados['diaPrimeiroVencimento'] = Biblioteca.removerMascara(this.diaPrimeiroVencimento);
		jsonDados['intervaloEntreParcelas'] = this.intervaloEntreParcelas ?? 0;
		jsonDados['diaFixoParcela'] = Biblioteca.removerMascara(this.diaFixoParcela);
		jsonDados['codigoCotacao'] = this.codigoCotacao;
		jsonDados['compraTipoPedido'] = this.compraTipoPedido == null ? null : this.compraTipoPedido.toJson;
		jsonDados['fornecedor'] = this.fornecedor == null ? null : this.fornecedor.toJson;
		jsonDados['colaborador'] = this.colaborador == null ? null : this.colaborador.toJson;
		

		var listaCompraPedidoDetalheLocal = [];
		for (CompraPedidoDetalhe objeto in this.listaCompraPedidoDetalhe ?? []) {
			listaCompraPedidoDetalheLocal.add(objeto.toJson);
		}
		jsonDados['listaCompraPedidoDetalhe'] = listaCompraPedidoDetalheLocal;
	
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

    getFormaPagamento(String formaPagamento) {
    	switch (formaPagamento) {
    		case '0':
    			return 'Pagamento a Vista';
    			break;
    		case '1':
    			return 'Pagamento a Prazo';
    			break;
    		case '2':
    			return 'Outros';
    			break;
    		default:
    			return null;
    		}
    	}

    setFormaPagamento(String formaPagamento) {
    	switch (formaPagamento) {
    		case 'Pagamento a Vista':
    			return '0';
    			break;
    		case 'Pagamento a Prazo':
    			return '1';
    			break;
    		case 'Outros':
    			return '2';
    			break;
    		default:
    			return null;
    		}
    	}


	String objetoEncodeJson(CompraPedido objeto) {
	  final jsonDados = objeto.toJson;
	  return json.encode(jsonDados);
	}
	
}