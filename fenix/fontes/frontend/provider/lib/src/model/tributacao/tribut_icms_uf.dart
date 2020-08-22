/*
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [TRIBUT_ICMS_UF] 
                                                                                
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


class TributIcmsUf {
	int id;
	int idTributConfiguraOfGt;
	String ufDestino;
	int cfop;
	String csosn;
	String cst;
	String modalidadeBc;
	double aliquota;
	double valorPauta;
	double valorPrecoMaximo;
	double mva;
	double porcentoBc;
	String modalidadeBcSt;
	double aliquotaInternaSt;
	double aliquotaInterestadualSt;
	double porcentoBcSt;
	double aliquotaIcmsSt;
	double valorPautaSt;
	double valorPrecoMaximoSt;

	TributIcmsUf({
			this.id,
			this.idTributConfiguraOfGt,
			this.ufDestino,
			this.cfop,
			this.csosn,
			this.cst,
			this.modalidadeBc,
			this.aliquota,
			this.valorPauta,
			this.valorPrecoMaximo,
			this.mva,
			this.porcentoBc,
			this.modalidadeBcSt,
			this.aliquotaInternaSt,
			this.aliquotaInterestadualSt,
			this.porcentoBcSt,
			this.aliquotaIcmsSt,
			this.valorPautaSt,
			this.valorPrecoMaximoSt,
		});

	static List<String> campos = <String>[
		'ID', 
		'UF_DESTINO', 
		'CFOP', 
		'CSOSN', 
		'CST', 
		'MODALIDADE_BC', 
		'ALIQUOTA', 
		'VALOR_PAUTA', 
		'VALOR_PRECO_MAXIMO', 
		'MVA', 
		'PORCENTO_BC', 
		'MODALIDADE_BC_ST', 
		'ALIQUOTA_INTERNA_ST', 
		'ALIQUOTA_INTERESTADUAL_ST', 
		'PORCENTO_BC_ST', 
		'ALIQUOTA_ICMS_ST', 
		'VALOR_PAUTA_ST', 
		'VALOR_PRECO_MAXIMO_ST', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'UF', 
		'CFOP', 
		'CSOSN', 
		'CST', 
		'Modalidade Base Cálculo', 
		'Alíquota', 
		'Valor Pauta', 
		'Valor Preço Máximo', 
		'Valor MVA', 
		'Porcento Base Cálculo', 
		'Modalidade Base Cálculo ST', 
		'Alíquota Interna ST', 
		'Alíquota Interestadual ST', 
		'Porcento Base Cálculo ST', 
		'Alíquota ICMS ST', 
		'Valor Pauta ST', 
		'Valor Preço Máximo ST', 
	];

	TributIcmsUf.fromJson(Map<String, dynamic> jsonDados) {
		id = jsonDados['id'];
		idTributConfiguraOfGt = jsonDados['idTributConfiguraOfGt'];
		ufDestino = jsonDados['ufDestino'] == '' ? null : jsonDados['ufDestino'];
		cfop = jsonDados['cfop'];
		csosn = jsonDados['csosn'];
		cst = jsonDados['cst'];
		modalidadeBc = getModalidadeBc(jsonDados['modalidadeBc']);
		aliquota = jsonDados['aliquota'] != null ? jsonDados['aliquota'].toDouble() : null;
		valorPauta = jsonDados['valorPauta'] != null ? jsonDados['valorPauta'].toDouble() : null;
		valorPrecoMaximo = jsonDados['valorPrecoMaximo'] != null ? jsonDados['valorPrecoMaximo'].toDouble() : null;
		mva = jsonDados['mva'] != null ? jsonDados['mva'].toDouble() : null;
		porcentoBc = jsonDados['porcentoBc'] != null ? jsonDados['porcentoBc'].toDouble() : null;
		modalidadeBcSt = getModalidadeBcSt(jsonDados['modalidadeBcSt']);
		aliquotaInternaSt = jsonDados['aliquotaInternaSt'] != null ? jsonDados['aliquotaInternaSt'].toDouble() : null;
		aliquotaInterestadualSt = jsonDados['aliquotaInterestadualSt'] != null ? jsonDados['aliquotaInterestadualSt'].toDouble() : null;
		porcentoBcSt = jsonDados['porcentoBcSt'] != null ? jsonDados['porcentoBcSt'].toDouble() : null;
		aliquotaIcmsSt = jsonDados['aliquotaIcmsSt'] != null ? jsonDados['aliquotaIcmsSt'].toDouble() : null;
		valorPautaSt = jsonDados['valorPautaSt'] != null ? jsonDados['valorPautaSt'].toDouble() : null;
		valorPrecoMaximoSt = jsonDados['valorPrecoMaximoSt'] != null ? jsonDados['valorPrecoMaximoSt'].toDouble() : null;
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = new Map<String, dynamic>();

		jsonDados['id'] = this.id ?? 0;
		jsonDados['idTributConfiguraOfGt'] = this.idTributConfiguraOfGt ?? 0;
		jsonDados['ufDestino'] = this.ufDestino;
		jsonDados['cfop'] = this.cfop ?? 0;
		jsonDados['csosn'] = this.csosn;
		jsonDados['cst'] = this.cst;
		jsonDados['modalidadeBc'] = setModalidadeBc(this.modalidadeBc);
		jsonDados['aliquota'] = this.aliquota;
		jsonDados['valorPauta'] = this.valorPauta;
		jsonDados['valorPrecoMaximo'] = this.valorPrecoMaximo;
		jsonDados['mva'] = this.mva;
		jsonDados['porcentoBc'] = this.porcentoBc;
		jsonDados['modalidadeBcSt'] = setModalidadeBcSt(this.modalidadeBcSt);
		jsonDados['aliquotaInternaSt'] = this.aliquotaInternaSt;
		jsonDados['aliquotaInterestadualSt'] = this.aliquotaInterestadualSt;
		jsonDados['porcentoBcSt'] = this.porcentoBcSt;
		jsonDados['aliquotaIcmsSt'] = this.aliquotaIcmsSt;
		jsonDados['valorPautaSt'] = this.valorPautaSt;
		jsonDados['valorPrecoMaximoSt'] = this.valorPrecoMaximoSt;
	
		return jsonDados;
	}
	
    getModalidadeBc(String modalidadeBc) {
    	switch (modalidadeBc) {
    		case '0':
    			return '0-Margem Valor Agregado (%)';
    			break;
    		case '1':
    			return '1-Pauta (Valor)';
    			break;
    		case '2':
    			return '2-Preço Tabelado Máx. (valor)';
    			break;
    		case '3':
    			return '3-Valor da Operação';
    			break;
    		default:
    			return null;
    		}
    	}

    setModalidadeBc(String modalidadeBc) {
    	switch (modalidadeBc) {
    		case '0-Margem Valor Agregado (%)':
    			return '0';
    			break;
    		case '1-Pauta (Valor)':
    			return '1';
    			break;
    		case '2-Preço Tabelado Máx. (valor)':
    			return '2';
    			break;
    		case '3-Valor da Operação':
    			return '3';
    			break;
    		default:
    			return null;
    		}
    	}

    getModalidadeBcSt(String modalidadeBcSt) {
    	switch (modalidadeBcSt) {
    		case '0':
    			return '0-Preço tabelado ou máximo sugerido';
    			break;
    		case '1':
    			return '1-Lista Negativa (valor)';
    			break;
    		case '2':
    			return '2-Lista Positiva (valor)';
    			break;
    		case '3':
    			return '3-Lista Neutra (valor)';
    			break;
    		case '4':
    			return '4-Margem Valor Agregado (%)';
    			break;
    		case '5':
    			return '5-Pauta (valor)';
    			break;
    		default:
    			return null;
    		}
    	}

    setModalidadeBcSt(String modalidadeBcSt) {
    	switch (modalidadeBcSt) {
    		case '0-Preço tabelado ou máximo sugerido':
    			return '0';
    			break;
    		case '1-Lista Negativa (valor)':
    			return '1';
    			break;
    		case '2-Lista Positiva (valor)':
    			return '2';
    			break;
    		case '3-Lista Neutra (valor)':
    			return '3';
    			break;
    		case '4-Margem Valor Agregado (%)':
    			return '4';
    			break;
    		case '5-Pauta (valor)':
    			return '5';
    			break;
    		default:
    			return null;
    		}
    	}


	String objetoEncodeJson(TributIcmsUf objeto) {
	  final jsonDados = objeto.toJson;
	  return json.encode(jsonDados);
	}
	
}