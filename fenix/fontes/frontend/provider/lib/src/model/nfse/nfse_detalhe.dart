/*
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [NFSE_DETALHE] 
                                                                                
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

class NfseDetalhe {
	int id;
	int idNfseListaServico;
	int idNfseCabecalho;
	double valorServicos;
	double valorDeducoes;
	double valorPis;
	double valorCofins;
	double valorInss;
	double valorIr;
	double valorCsll;
	String codigoCnae;
	String codigoTributacaoMunicipio;
	double valorBaseCalculo;
	double aliquota;
	double valorIss;
	double valorLiquido;
	double outrasRetencoes;
	double valorCredito;
	String issRetido;
	double valorIssRetido;
	double valorDescontoCondicionado;
	double valorDescontoIncondicionado;
	String discriminacao;
	int municipioPrestacao;
	NfseListaServico nfseListaServico;

	NfseDetalhe({
			this.id,
			this.idNfseListaServico,
			this.idNfseCabecalho,
			this.valorServicos = 0.0,
			this.valorDeducoes = 0.0,
			this.valorPis = 0.0,
			this.valorCofins = 0.0,
			this.valorInss = 0.0,
			this.valorIr = 0.0,
			this.valorCsll = 0.0,
			this.codigoCnae,
			this.codigoTributacaoMunicipio,
			this.valorBaseCalculo = 0.0,
			this.aliquota = 0.0,
			this.valorIss = 0.0,
			this.valorLiquido = 0.0,
			this.outrasRetencoes = 0.0,
			this.valorCredito = 0.0,
			this.issRetido,
			this.valorIssRetido = 0.0,
			this.valorDescontoCondicionado = 0.0,
			this.valorDescontoIncondicionado = 0.0,
			this.discriminacao,
			this.municipioPrestacao,
			this.nfseListaServico,
		});

	static List<String> campos = <String>[
		'ID', 
		'VALOR_SERVICOS', 
		'VALOR_DEDUCOES', 
		'VALOR_PIS', 
		'VALOR_COFINS', 
		'VALOR_INSS', 
		'VALOR_IR', 
		'VALOR_CSLL', 
		'CODIGO_CNAE', 
		'CODIGO_TRIBUTACAO_MUNICIPIO', 
		'VALOR_BASE_CALCULO', 
		'ALIQUOTA', 
		'VALOR_ISS', 
		'VALOR_LIQUIDO', 
		'OUTRAS_RETENCOES', 
		'VALOR_CREDITO', 
		'ISS_RETIDO', 
		'VALOR_ISS_RETIDO', 
		'VALOR_DESCONTO_CONDICIONADO', 
		'VALOR_DESCONTO_INCONDICIONADO', 
		'DISCRIMINACAO', 
		'MUNICIPIO_PRESTACAO', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'Valor dos Serviços', 
		'Valor das Deduções', 
		'Valor do PIS', 
		'Valor do COFINS', 
		'Valor do INSS', 
		'Valor do IR', 
		'Valor do CSLL', 
		'CNAE', 
		'Código Tributação Município', 
		'Valor Base Cálculo', 
		'Alíquota', 
		'Valor do ISS', 
		'Valor Líquido', 
		'Valor Outras Retenções', 
		'Valor Crédito', 
		'ISS Retido', 
		'Valor ISS Retido', 
		'Valor Desconto Condicionado', 
		'Valor Desconto Incondicionado', 
		'Discriminação', 
		'Município IBGE', 
	];

	NfseDetalhe.fromJson(Map<String, dynamic> jsonDados) {
		id = jsonDados['id'];
		idNfseListaServico = jsonDados['idNfseListaServico'];
		idNfseCabecalho = jsonDados['idNfseCabecalho'];
		valorServicos = jsonDados['valorServicos'] != null ? jsonDados['valorServicos'].toDouble() : null;
		valorDeducoes = jsonDados['valorDeducoes'] != null ? jsonDados['valorDeducoes'].toDouble() : null;
		valorPis = jsonDados['valorPis'] != null ? jsonDados['valorPis'].toDouble() : null;
		valorCofins = jsonDados['valorCofins'] != null ? jsonDados['valorCofins'].toDouble() : null;
		valorInss = jsonDados['valorInss'] != null ? jsonDados['valorInss'].toDouble() : null;
		valorIr = jsonDados['valorIr'] != null ? jsonDados['valorIr'].toDouble() : null;
		valorCsll = jsonDados['valorCsll'] != null ? jsonDados['valorCsll'].toDouble() : null;
		codigoCnae = jsonDados['codigoCnae'];
		codigoTributacaoMunicipio = jsonDados['codigoTributacaoMunicipio'];
		valorBaseCalculo = jsonDados['valorBaseCalculo'] != null ? jsonDados['valorBaseCalculo'].toDouble() : null;
		aliquota = jsonDados['aliquota'] != null ? jsonDados['aliquota'].toDouble() : null;
		valorIss = jsonDados['valorIss'] != null ? jsonDados['valorIss'].toDouble() : null;
		valorLiquido = jsonDados['valorLiquido'] != null ? jsonDados['valorLiquido'].toDouble() : null;
		outrasRetencoes = jsonDados['outrasRetencoes'] != null ? jsonDados['outrasRetencoes'].toDouble() : null;
		valorCredito = jsonDados['valorCredito'] != null ? jsonDados['valorCredito'].toDouble() : null;
		issRetido = getIssRetido(jsonDados['issRetido']);
		valorIssRetido = jsonDados['valorIssRetido'] != null ? jsonDados['valorIssRetido'].toDouble() : null;
		valorDescontoCondicionado = jsonDados['valorDescontoCondicionado'] != null ? jsonDados['valorDescontoCondicionado'].toDouble() : null;
		valorDescontoIncondicionado = jsonDados['valorDescontoIncondicionado'] != null ? jsonDados['valorDescontoIncondicionado'].toDouble() : null;
		discriminacao = jsonDados['discriminacao'];
		municipioPrestacao = jsonDados['municipioPrestacao'];
		nfseListaServico = jsonDados['nfseListaServico'] == null ? null : new NfseListaServico.fromJson(jsonDados['nfseListaServico']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = new Map<String, dynamic>();

		jsonDados['id'] = this.id ?? 0;
		jsonDados['idNfseListaServico'] = this.idNfseListaServico ?? 0;
		jsonDados['idNfseCabecalho'] = this.idNfseCabecalho ?? 0;
		jsonDados['valorServicos'] = this.valorServicos;
		jsonDados['valorDeducoes'] = this.valorDeducoes;
		jsonDados['valorPis'] = this.valorPis;
		jsonDados['valorCofins'] = this.valorCofins;
		jsonDados['valorInss'] = this.valorInss;
		jsonDados['valorIr'] = this.valorIr;
		jsonDados['valorCsll'] = this.valorCsll;
		jsonDados['codigoCnae'] = this.codigoCnae;
		jsonDados['codigoTributacaoMunicipio'] = this.codigoTributacaoMunicipio;
		jsonDados['valorBaseCalculo'] = this.valorBaseCalculo;
		jsonDados['aliquota'] = this.aliquota;
		jsonDados['valorIss'] = this.valorIss;
		jsonDados['valorLiquido'] = this.valorLiquido;
		jsonDados['outrasRetencoes'] = this.outrasRetencoes;
		jsonDados['valorCredito'] = this.valorCredito;
		jsonDados['issRetido'] = setIssRetido(this.issRetido);
		jsonDados['valorIssRetido'] = this.valorIssRetido;
		jsonDados['valorDescontoCondicionado'] = this.valorDescontoCondicionado;
		jsonDados['valorDescontoIncondicionado'] = this.valorDescontoIncondicionado;
		jsonDados['discriminacao'] = this.discriminacao;
		jsonDados['municipioPrestacao'] = this.municipioPrestacao ?? 0;
		jsonDados['nfseListaServico'] = this.nfseListaServico == null ? null : this.nfseListaServico.toJson;
	
		return jsonDados;
	}
	
    getIssRetido(String issRetido) {
    	switch (issRetido) {
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

    setIssRetido(String issRetido) {
    	switch (issRetido) {
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


	String objetoEncodeJson(NfseDetalhe objeto) {
	  final jsonDados = objeto.toJson;
	  return json.encode(jsonDados);
	}
	
}