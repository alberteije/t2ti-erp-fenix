/*
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [VENDA_CABECALHO] 
                                                                                
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

class VendaCabecalho {
	int id;
	int idVendaOrcamentoCabecalho;
	int idVendaCondicoesPagamento;
	int idNotaFiscalTipo;
	int idCliente;
	int idTransportadora;
	int idVendedor;
	DateTime dataVenda;
	DateTime dataSaida;
	String horaSaida;
	int numeroFatura;
	String localEntrega;
	String localCobranca;
	double valorSubtotal;
	double taxaComissao;
	double valorComissao;
	double taxaDesconto;
	double valorDesconto;
	double valorTotal;
	String tipoFrete;
	String formaPagamento;
	double valorFrete;
	double valorSeguro;
	String observacao;
	String situacao;
	String diaFixoParcela;
	VendaOrcamentoCabecalho vendaOrcamentoCabecalho;
	VendaCondicoesPagamento vendaCondicoesPagamento;
	NotaFiscalTipo notaFiscalTipo;
	Cliente cliente;
	Transportadora transportadora;
	Vendedor vendedor;
	List<VendaComissao> listaVendaComissao = [];
	List<VendaDetalhe> listaVendaDetalhe = [];

	VendaCabecalho({
			this.id,
			this.idVendaOrcamentoCabecalho,
			this.idVendaCondicoesPagamento,
			this.idNotaFiscalTipo,
			this.idCliente,
			this.idTransportadora,
			this.idVendedor,
			this.dataVenda,
			this.dataSaida,
			this.horaSaida,
			this.numeroFatura,
			this.localEntrega,
			this.localCobranca,
			this.valorSubtotal = 0.0,
			this.taxaComissao = 0.0,
			this.valorComissao = 0.0,
			this.taxaDesconto = 0.0,
			this.valorDesconto = 0.0,
			this.valorTotal = 0.0,
			this.tipoFrete,
			this.formaPagamento,
			this.valorFrete = 0.0,
			this.valorSeguro = 0.0,
			this.observacao,
			this.situacao,
			this.diaFixoParcela,
			this.vendaOrcamentoCabecalho,
			this.vendaCondicoesPagamento,
			this.notaFiscalTipo,
			this.cliente,
			this.transportadora,
			this.vendedor,
			this.listaVendaComissao,
			this.listaVendaDetalhe,
		});

	static List<String> campos = <String>[
		'ID', 
		'DATA_VENDA', 
		'DATA_SAIDA', 
		'HORA_SAIDA', 
		'NUMERO_FATURA', 
		'LOCAL_ENTREGA', 
		'LOCAL_COBRANCA', 
		'VALOR_SUBTOTAL', 
		'TAXA_COMISSAO', 
		'VALOR_COMISSAO', 
		'TAXA_DESCONTO', 
		'VALOR_DESCONTO', 
		'VALOR_TOTAL', 
		'TIPO_FRETE', 
		'FORMA_PAGAMENTO', 
		'VALOR_FRETE', 
		'VALOR_SEGURO', 
		'OBSERVACAO', 
		'SITUACAO', 
		'DIA_FIXO_PARCELA', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'Data da Venda', 
		'Data da Saída', 
		'Hora da Saída', 
		'Número da Fatura', 
		'Local de Entrega', 
		'Local de Cobrança', 
		'Valor Subtotal', 
		'Taxa Comissão', 
		'Valor Comissão', 
		'Taxa Desconto', 
		'Valor Desconto', 
		'Valor Total', 
		'Tipo do Frete', 
		'Forma de Pagamento', 
		'Valor Frete', 
		'Valor Seguro', 
		'Observação', 
		'Situação', 
		'Dia Fixo da Parcela', 
	];

	VendaCabecalho.fromJson(Map<String, dynamic> jsonDados) {
		id = jsonDados['id'];
		idVendaOrcamentoCabecalho = jsonDados['idVendaOrcamentoCabecalho'];
		idVendaCondicoesPagamento = jsonDados['idVendaCondicoesPagamento'];
		idNotaFiscalTipo = jsonDados['idNotaFiscalTipo'];
		idCliente = jsonDados['idCliente'];
		idTransportadora = jsonDados['idTransportadora'];
		idVendedor = jsonDados['idVendedor'];
		dataVenda = jsonDados['dataVenda'] != null ? DateTime.tryParse(jsonDados['dataVenda']) : null;
		dataSaida = jsonDados['dataSaida'] != null ? DateTime.tryParse(jsonDados['dataSaida']) : null;
		horaSaida = jsonDados['horaSaida'];
		numeroFatura = jsonDados['numeroFatura'];
		localEntrega = jsonDados['localEntrega'];
		localCobranca = jsonDados['localCobranca'];
		valorSubtotal = jsonDados['valorSubtotal'] != null ? jsonDados['valorSubtotal'].toDouble() : null;
		taxaComissao = jsonDados['taxaComissao'] != null ? jsonDados['taxaComissao'].toDouble() : null;
		valorComissao = jsonDados['valorComissao'] != null ? jsonDados['valorComissao'].toDouble() : null;
		taxaDesconto = jsonDados['taxaDesconto'] != null ? jsonDados['taxaDesconto'].toDouble() : null;
		valorDesconto = jsonDados['valorDesconto'] != null ? jsonDados['valorDesconto'].toDouble() : null;
		valorTotal = jsonDados['valorTotal'] != null ? jsonDados['valorTotal'].toDouble() : null;
		tipoFrete = getTipoFrete(jsonDados['tipoFrete']);
		formaPagamento = getFormaPagamento(jsonDados['formaPagamento']);
		valorFrete = jsonDados['valorFrete'] != null ? jsonDados['valorFrete'].toDouble() : null;
		valorSeguro = jsonDados['valorSeguro'] != null ? jsonDados['valorSeguro'].toDouble() : null;
		observacao = jsonDados['observacao'];
		situacao = getSituacao(jsonDados['situacao']);
		diaFixoParcela = jsonDados['diaFixoParcela'];
		vendaOrcamentoCabecalho = jsonDados['vendaOrcamentoCabecalho'] == null ? null : new VendaOrcamentoCabecalho.fromJson(jsonDados['vendaOrcamentoCabecalho']);
		vendaCondicoesPagamento = jsonDados['vendaCondicoesPagamento'] == null ? null : new VendaCondicoesPagamento.fromJson(jsonDados['vendaCondicoesPagamento']);
		notaFiscalTipo = jsonDados['notaFiscalTipo'] == null ? null : new NotaFiscalTipo.fromJson(jsonDados['notaFiscalTipo']);
		cliente = jsonDados['cliente'] == null ? null : new Cliente.fromJson(jsonDados['cliente']);
		transportadora = jsonDados['transportadora'] == null ? null : new Transportadora.fromJson(jsonDados['transportadora']);
		vendedor = jsonDados['vendedor'] == null ? null : new Vendedor.fromJson(jsonDados['vendedor']);
		listaVendaComissao = (jsonDados['listaVendaComissao'] as Iterable)?.map((m) => VendaComissao.fromJson(m))?.toList() ?? [];
		listaVendaDetalhe = (jsonDados['listaVendaDetalhe'] as Iterable)?.map((m) => VendaDetalhe.fromJson(m))?.toList() ?? [];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = new Map<String, dynamic>();

		jsonDados['id'] = this.id ?? 0;
		jsonDados['idVendaOrcamentoCabecalho'] = this.idVendaOrcamentoCabecalho ?? 0;
		jsonDados['idVendaCondicoesPagamento'] = this.idVendaCondicoesPagamento ?? 0;
		jsonDados['idNotaFiscalTipo'] = this.idNotaFiscalTipo ?? 0;
		jsonDados['idCliente'] = this.idCliente ?? 0;
		jsonDados['idTransportadora'] = this.idTransportadora ?? 0;
		jsonDados['idVendedor'] = this.idVendedor ?? 0;
		jsonDados['dataVenda'] = this.dataVenda != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.dataVenda) : null;
		jsonDados['dataSaida'] = this.dataSaida != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.dataSaida) : null;
		jsonDados['horaSaida'] = Biblioteca.removerMascara(this.horaSaida);
		jsonDados['numeroFatura'] = this.numeroFatura ?? 0;
		jsonDados['localEntrega'] = this.localEntrega;
		jsonDados['localCobranca'] = this.localCobranca;
		jsonDados['valorSubtotal'] = this.valorSubtotal;
		jsonDados['taxaComissao'] = this.taxaComissao;
		jsonDados['valorComissao'] = this.valorComissao;
		jsonDados['taxaDesconto'] = this.taxaDesconto;
		jsonDados['valorDesconto'] = this.valorDesconto;
		jsonDados['valorTotal'] = this.valorTotal;
		jsonDados['tipoFrete'] = setTipoFrete(this.tipoFrete);
		jsonDados['formaPagamento'] = setFormaPagamento(this.formaPagamento);
		jsonDados['valorFrete'] = this.valorFrete;
		jsonDados['valorSeguro'] = this.valorSeguro;
		jsonDados['observacao'] = this.observacao;
		jsonDados['situacao'] = setSituacao(this.situacao);
		jsonDados['diaFixoParcela'] = this.diaFixoParcela;
		jsonDados['vendaOrcamentoCabecalho'] = this.vendaOrcamentoCabecalho == null ? null : this.vendaOrcamentoCabecalho.toJson;
		jsonDados['vendaCondicoesPagamento'] = this.vendaCondicoesPagamento == null ? null : this.vendaCondicoesPagamento.toJson;
		jsonDados['notaFiscalTipo'] = this.notaFiscalTipo == null ? null : this.notaFiscalTipo.toJson;
		jsonDados['cliente'] = this.cliente == null ? null : this.cliente.toJson;
		jsonDados['transportadora'] = this.transportadora == null ? null : this.transportadora.toJson;
		jsonDados['vendedor'] = this.vendedor == null ? null : this.vendedor.toJson;
		

		var listaVendaComissaoLocal = [];
		for (VendaComissao objeto in this.listaVendaComissao ?? []) {
			listaVendaComissaoLocal.add(objeto.toJson);
		}
		jsonDados['listaVendaComissao'] = listaVendaComissaoLocal;
		

		var listaVendaDetalheLocal = [];
		for (VendaDetalhe objeto in this.listaVendaDetalhe ?? []) {
			listaVendaDetalheLocal.add(objeto.toJson);
		}
		jsonDados['listaVendaDetalhe'] = listaVendaDetalheLocal;
	
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

    getSituacao(String situacao) {
    	switch (situacao) {
    		case '0':
    			return 'Digitação';
    			break;
    		case '1':
    			return 'Produção';
    			break;
    		case '2':
    			return 'Expedição';
    			break;
    		case '3':
    			return 'Faturado';
    			break;
    		case '4':
    			return 'Entregue';
    			break;
    		case '5':
    			return 'Devolução';
    			break;
    		default:
    			return null;
    		}
    	}

    setSituacao(String situacao) {
    	switch (situacao) {
    		case 'Digitação':
    			return '0';
    			break;
    		case 'Produção':
    			return '1';
    			break;
    		case 'Expedição':
    			return '2';
    			break;
    		case 'Faturado':
    			return '3';
    			break;
    		case 'Entregue':
    			return '4';
    			break;
    		case 'Devolução':
    			return '5';
    			break;
    		default:
    			return null;
    		}
    	}


	String objetoEncodeJson(VendaCabecalho objeto) {
	  final jsonDados = objeto.toJson;
	  return json.encode(jsonDados);
	}
	
}