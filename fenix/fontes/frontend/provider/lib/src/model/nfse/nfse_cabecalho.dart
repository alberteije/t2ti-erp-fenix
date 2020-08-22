/*
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [NFSE_CABECALHO] 
                                                                                
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

class NfseCabecalho {
	int id;
	int idCliente;
	int idOsAbertura;
	String numero;
	String codigoVerificacao;
	DateTime dataHoraEmissao;
	String competencia;
	String numeroSubstituida;
	String naturezaOperacao;
	String regimeEspecialTributacao;
	String optanteSimplesNacional;
	String incentivadorCultural;
	String numeroRps;
	String serieRps;
	String tipoRps;
	DateTime dataEmissaoRps;
	String outrasInformacoes;
	NfseIntermediario nfseIntermediario;
	Cliente cliente;
	OsAbertura osAbertura;
	List<NfseDetalhe> listaNfseDetalhe = [];

	NfseCabecalho({
			this.id,
			this.idCliente,
			this.idOsAbertura,
			this.numero,
			this.codigoVerificacao,
			this.dataHoraEmissao,
			this.competencia,
			this.numeroSubstituida,
			this.naturezaOperacao,
			this.regimeEspecialTributacao,
			this.optanteSimplesNacional,
			this.incentivadorCultural,
			this.numeroRps,
			this.serieRps,
			this.tipoRps,
			this.dataEmissaoRps,
			this.outrasInformacoes,
			this.nfseIntermediario,
			this.cliente,
			this.osAbertura,
			this.listaNfseDetalhe,
		});

	static List<String> campos = <String>[
		'ID', 
		'NUMERO', 
		'CODIGO_VERIFICACAO', 
		'DATA_HORA_EMISSAO', 
		'COMPETENCIA', 
		'NUMERO_SUBSTITUIDA', 
		'NATUREZA_OPERACAO', 
		'REGIME_ESPECIAL_TRIBUTACAO', 
		'OPTANTE_SIMPLES_NACIONAL', 
		'INCENTIVADOR_CULTURAL', 
		'NUMERO_RPS', 
		'SERIE_RPS', 
		'TIPO_RPS', 
		'DATA_EMISSAO_RPS', 
		'OUTRAS_INFORMACOES', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'Número', 
		'Código Verificação', 
		'Data/Hora Emissão', 
		'Mês/Ano Competência', 
		'Número Substituída', 
		'Natureza Operação', 
		'Regime Especial Tributação', 
		'Optante Simples Nacional', 
		'Incentivador Cultural', 
		'Número RPS', 
		'Série RPS', 
		'Tipo RPS', 
		'Data de Emissão do RPS', 
		'Outras Informações', 
	];

	NfseCabecalho.fromJson(Map<String, dynamic> jsonDados) {
		id = jsonDados['id'];
		idCliente = jsonDados['idCliente'];
		idOsAbertura = jsonDados['idOsAbertura'];
		numero = jsonDados['numero'];
		codigoVerificacao = jsonDados['codigoVerificacao'];
		dataHoraEmissao = jsonDados['dataHoraEmissao'] != null ? DateTime.tryParse(jsonDados['dataHoraEmissao']) : null;
		competencia = jsonDados['competencia'];
		numeroSubstituida = jsonDados['numeroSubstituida'];
		naturezaOperacao = getNaturezaOperacao(jsonDados['naturezaOperacao']);
		regimeEspecialTributacao = getRegimeEspecialTributacao(jsonDados['regimeEspecialTributacao']);
		optanteSimplesNacional = getOptanteSimplesNacional(jsonDados['optanteSimplesNacional']);
		incentivadorCultural = getIncentivadorCultural(jsonDados['incentivadorCultural']);
		numeroRps = jsonDados['numeroRps'];
		serieRps = jsonDados['serieRps'];
		tipoRps = getTipoRps(jsonDados['tipoRps']);
		dataEmissaoRps = jsonDados['dataEmissaoRps'] != null ? DateTime.tryParse(jsonDados['dataEmissaoRps']) : null;
		outrasInformacoes = jsonDados['outrasInformacoes'];
		nfseIntermediario = jsonDados['nfseIntermediario'] == null ? null : new NfseIntermediario.fromJson(jsonDados['nfseIntermediario']);
		cliente = jsonDados['cliente'] == null ? null : new Cliente.fromJson(jsonDados['cliente']);
		osAbertura = jsonDados['osAbertura'] == null ? null : new OsAbertura.fromJson(jsonDados['osAbertura']);
		listaNfseDetalhe = (jsonDados['listaNfseDetalhe'] as Iterable)?.map((m) => NfseDetalhe.fromJson(m))?.toList() ?? [];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = new Map<String, dynamic>();

		jsonDados['id'] = this.id ?? 0;
		jsonDados['idCliente'] = this.idCliente ?? 0;
		jsonDados['idOsAbertura'] = this.idOsAbertura ?? 0;
		jsonDados['numero'] = this.numero;
		jsonDados['codigoVerificacao'] = this.codigoVerificacao;
		jsonDados['dataHoraEmissao'] = this.dataHoraEmissao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.dataHoraEmissao) : null;
		jsonDados['competencia'] = Biblioteca.removerMascara(this.competencia);
		jsonDados['numeroSubstituida'] = this.numeroSubstituida;
		jsonDados['naturezaOperacao'] = setNaturezaOperacao(this.naturezaOperacao);
		jsonDados['regimeEspecialTributacao'] = setRegimeEspecialTributacao(this.regimeEspecialTributacao);
		jsonDados['optanteSimplesNacional'] = setOptanteSimplesNacional(this.optanteSimplesNacional);
		jsonDados['incentivadorCultural'] = setIncentivadorCultural(this.incentivadorCultural);
		jsonDados['numeroRps'] = this.numeroRps;
		jsonDados['serieRps'] = this.serieRps;
		jsonDados['tipoRps'] = setTipoRps(this.tipoRps);
		jsonDados['dataEmissaoRps'] = this.dataEmissaoRps != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.dataEmissaoRps) : null;
		jsonDados['outrasInformacoes'] = this.outrasInformacoes;
		jsonDados['nfseIntermediario'] = this.nfseIntermediario == null ? null : this.nfseIntermediario.toJson;
		jsonDados['cliente'] = this.cliente == null ? null : this.cliente.toJson;
		jsonDados['osAbertura'] = this.osAbertura == null ? null : this.osAbertura.toJson;
		

		var listaNfseDetalheLocal = [];
		for (NfseDetalhe objeto in this.listaNfseDetalhe ?? []) {
			listaNfseDetalheLocal.add(objeto.toJson);
		}
		jsonDados['listaNfseDetalhe'] = listaNfseDetalheLocal;
	
		return jsonDados;
	}
	
    getNaturezaOperacao(String naturezaOperacao) {
    	switch (naturezaOperacao) {
    		case '1':
    			return '1=Tributação no município';
    			break;
    		case '2':
    			return '2=Tributação fora do município';
    			break;
    		case '3':
    			return '3=Isenção';
    			break;
    		case '4':
    			return '4=Imune';
    			break;
    		case '5':
    			return '5=Exigibilidade suspensa por decisão judicial';
    			break;
    		case '6':
    			return '6=Exigibilidade suspensa por procedimento administrativo';
    			break;
    		default:
    			return null;
    		}
    	}

    setNaturezaOperacao(String naturezaOperacao) {
    	switch (naturezaOperacao) {
    		case '1=Tributação no município':
    			return '1';
    			break;
    		case '2=Tributação fora do município':
    			return '2';
    			break;
    		case '3=Isenção':
    			return '3';
    			break;
    		case '4=Imune':
    			return '4';
    			break;
    		case '5=Exigibilidade suspensa por decisão judicial':
    			return '5';
    			break;
    		case '6=Exigibilidade suspensa por procedimento administrativo':
    			return '6';
    			break;
    		default:
    			return null;
    		}
    	}

    getRegimeEspecialTributacao(String regimeEspecialTributacao) {
    	switch (regimeEspecialTributacao) {
    		case '1':
    			return '1=Microempresa Municipal';
    			break;
    		case '2':
    			return '2=Estimativa';
    			break;
    		case '3':
    			return '3=Sociedade de Profissionais';
    			break;
    		case '4':
    			return '4=Cooperativa';
    			break;
    		default:
    			return null;
    		}
    	}

    setRegimeEspecialTributacao(String regimeEspecialTributacao) {
    	switch (regimeEspecialTributacao) {
    		case '1=Microempresa Municipal':
    			return '1';
    			break;
    		case '2=Estimativa':
    			return '2';
    			break;
    		case '3=Sociedade de Profissionais':
    			return '3';
    			break;
    		case '4=Cooperativa':
    			return '4';
    			break;
    		default:
    			return null;
    		}
    	}

    getOptanteSimplesNacional(String optanteSimplesNacional) {
    	switch (optanteSimplesNacional) {
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

    setOptanteSimplesNacional(String optanteSimplesNacional) {
    	switch (optanteSimplesNacional) {
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

    getIncentivadorCultural(String incentivadorCultural) {
    	switch (incentivadorCultural) {
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

    setIncentivadorCultural(String incentivadorCultural) {
    	switch (incentivadorCultural) {
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

    getTipoRps(String tipoRps) {
    	switch (tipoRps) {
    		case '1':
    			return '1=Recibo Provisório de Serviços';
    			break;
    		case '2':
    			return '2=RPS  Nota Fiscal Conjugada (Mista)';
    			break;
    		case '3':
    			return '3=Cupom';
    			break;
    		default:
    			return null;
    		}
    	}

    setTipoRps(String tipoRps) {
    	switch (tipoRps) {
    		case '1=Recibo Provisório de Serviços':
    			return '1';
    			break;
    		case '2=RPS  Nota Fiscal Conjugada (Mista)':
    			return '2';
    			break;
    		case '3=Cupom':
    			return '3';
    			break;
    		default:
    			return null;
    		}
    	}


	String objetoEncodeJson(NfseCabecalho objeto) {
	  final jsonDados = objeto.toJson;
	  return json.encode(jsonDados);
	}
	
}