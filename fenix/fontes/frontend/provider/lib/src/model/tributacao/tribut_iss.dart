/*
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [TRIBUT_ISS] 
                                                                                
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

class TributIss {
	int id;
	int idTributOperacaoFiscal;
	String modalidadeBaseCalculo;
	double porcentoBaseCalculo;
	double aliquotaPorcento;
	double aliquotaUnidade;
	double valorPrecoMaximo;
	double valorPautaFiscal;
	int itemListaServico;
	String codigoTributacao;
	TributOperacaoFiscal tributOperacaoFiscal;

	TributIss({
			this.id,
			this.idTributOperacaoFiscal,
			this.modalidadeBaseCalculo,
			this.porcentoBaseCalculo,
			this.aliquotaPorcento,
			this.aliquotaUnidade,
			this.valorPrecoMaximo,
			this.valorPautaFiscal,
			this.itemListaServico,
			this.codigoTributacao,
			this.tributOperacaoFiscal,
		});

	static List<String> campos = <String>[
		'ID', 
		'MODALIDADE_BASE_CALCULO', 
		'PORCENTO_BASE_CALCULO', 
		'ALIQUOTA_PORCENTO', 
		'ALIQUOTA_UNIDADE', 
		'VALOR_PRECO_MAXIMO', 
		'VALOR_PAUTA_FISCAL', 
		'ITEM_LISTA_SERVICO', 
		'CODIGO_TRIBUTACAO', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'Modalidade Base Cálculo', 
		'Porcento Base Cálculo', 
		'Alíquota Porcento', 
		'Alíquota Unidade', 
		'Valor Preço Máximo', 
		'Valor Pauta Fiscal', 
		'Item Lista Serviço', 
		'Código Tributação', 
	];

	TributIss.fromJson(Map<String, dynamic> jsonDados) {
		id = jsonDados['id'];
		idTributOperacaoFiscal = jsonDados['idTributOperacaoFiscal'];
		modalidadeBaseCalculo = getModalidadeBaseCalculo(jsonDados['modalidadeBaseCalculo']);
		porcentoBaseCalculo = jsonDados['porcentoBaseCalculo'] != null ? jsonDados['porcentoBaseCalculo'].toDouble() : null;
		aliquotaPorcento = jsonDados['aliquotaPorcento'] != null ? jsonDados['aliquotaPorcento'].toDouble() : null;
		aliquotaUnidade = jsonDados['aliquotaUnidade'] != null ? jsonDados['aliquotaUnidade'].toDouble() : null;
		valorPrecoMaximo = jsonDados['valorPrecoMaximo'] != null ? jsonDados['valorPrecoMaximo'].toDouble() : null;
		valorPautaFiscal = jsonDados['valorPautaFiscal'] != null ? jsonDados['valorPautaFiscal'].toDouble() : null;
		itemListaServico = jsonDados['itemListaServico'];
		codigoTributacao = getCodigoTributacao(jsonDados['codigoTributacao']);
		tributOperacaoFiscal = jsonDados['tributOperacaoFiscal'] == null ? null : new TributOperacaoFiscal.fromJson(jsonDados['tributOperacaoFiscal']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = new Map<String, dynamic>();

		jsonDados['id'] = this.id ?? 0;
		jsonDados['idTributOperacaoFiscal'] = this.idTributOperacaoFiscal ?? 0;
		jsonDados['modalidadeBaseCalculo'] = setModalidadeBaseCalculo(this.modalidadeBaseCalculo);
		jsonDados['porcentoBaseCalculo'] = this.porcentoBaseCalculo;
		jsonDados['aliquotaPorcento'] = this.aliquotaPorcento;
		jsonDados['aliquotaUnidade'] = this.aliquotaUnidade;
		jsonDados['valorPrecoMaximo'] = this.valorPrecoMaximo;
		jsonDados['valorPautaFiscal'] = this.valorPautaFiscal;
		jsonDados['itemListaServico'] = this.itemListaServico ?? 0;
		jsonDados['codigoTributacao'] = setCodigoTributacao(this.codigoTributacao);
		jsonDados['tributOperacaoFiscal'] = this.tributOperacaoFiscal == null ? null : this.tributOperacaoFiscal.toJson;
	
		return jsonDados;
	}
	
    getModalidadeBaseCalculo(String modalidadeBaseCalculo) {
    	switch (modalidadeBaseCalculo) {
    		case '0':
    			return '0-Valor Operação';
    			break;
    		case '9':
    			return '9-Outros';
    			break;
    		default:
    			return null;
    		}
    	}

    setModalidadeBaseCalculo(String modalidadeBaseCalculo) {
    	switch (modalidadeBaseCalculo) {
    		case '0-Valor Operação':
    			return '0';
    			break;
    		case '9-Outros':
    			return '9';
    			break;
    		default:
    			return null;
    		}
    	}

    getCodigoTributacao(String codigoTributacao) {
    	switch (codigoTributacao) {
    		case 'N':
    			return 'Normal';
    			break;
    		case 'R':
    			return 'Retida';
    			break;
    		case 'S':
    			return 'Substituta';
    			break;
    		case 'I':
    			return 'Isenta';
    			break;
    		default:
    			return null;
    		}
    	}

    setCodigoTributacao(String codigoTributacao) {
    	switch (codigoTributacao) {
    		case 'Normal':
    			return 'N';
    			break;
    		case 'Retida':
    			return 'R';
    			break;
    		case 'Substituta':
    			return 'S';
    			break;
    		case 'Isenta':
    			return 'I';
    			break;
    		default:
    			return null;
    		}
    	}


	String objetoEncodeJson(TributIss objeto) {
	  final jsonDados = objeto.toJson;
	  return json.encode(jsonDados);
	}
	
}