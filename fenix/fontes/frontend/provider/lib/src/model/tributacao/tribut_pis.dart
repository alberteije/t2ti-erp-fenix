/*
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [TRIBUT_PIS] 
                                                                                
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


class TributPis {
	int id;
	int idTributConfiguraOfGt;
	String cstPis;
	String efdTabela435;
	String modalidadeBaseCalculo;
	double porcentoBaseCalculo;
	double aliquotaPorcento;
	double aliquotaUnidade;
	double valorPrecoMaximo;
	double valorPautaFiscal;

	TributPis({
			this.id,
			this.idTributConfiguraOfGt,
			this.cstPis,
			this.efdTabela435,
			this.modalidadeBaseCalculo,
			this.porcentoBaseCalculo,
			this.aliquotaPorcento,
			this.aliquotaUnidade,
			this.valorPrecoMaximo,
			this.valorPautaFiscal,
		});

	static List<String> campos = <String>[
		'ID', 
		'CST_PIS', 
		'EFD_TABELA_435', 
		'MODALIDADE_BASE_CALCULO', 
		'PORCENTO_BASE_CALCULO', 
		'ALIQUOTA_PORCENTO', 
		'ALIQUOTA_UNIDADE', 
		'VALOR_PRECO_MAXIMO', 
		'VALOR_PAUTA_FISCAL', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'CST PIS', 
		'EFD 435', 
		'Modalidade Base Cálculo', 
		'Porcento Base Cálculo', 
		'Alíquota Porcento', 
		'Alíquota Unidade', 
		'Valor Preço Máximo', 
		'Valor Pauta Fiscal', 
	];

	TributPis.fromJson(Map<String, dynamic> jsonDados) {
		id = jsonDados['id'];
		idTributConfiguraOfGt = jsonDados['idTributConfiguraOfGt'];
		cstPis = jsonDados['cstPis'];
		efdTabela435 = jsonDados['efdTabela435'];
		modalidadeBaseCalculo = getModalidadeBaseCalculo(jsonDados['modalidadeBaseCalculo']);
		porcentoBaseCalculo = jsonDados['porcentoBaseCalculo'] != null ? jsonDados['porcentoBaseCalculo'].toDouble() : null;
		aliquotaPorcento = jsonDados['aliquotaPorcento'] != null ? jsonDados['aliquotaPorcento'].toDouble() : null;
		aliquotaUnidade = jsonDados['aliquotaUnidade'] != null ? jsonDados['aliquotaUnidade'].toDouble() : null;
		valorPrecoMaximo = jsonDados['valorPrecoMaximo'] != null ? jsonDados['valorPrecoMaximo'].toDouble() : null;
		valorPautaFiscal = jsonDados['valorPautaFiscal'] != null ? jsonDados['valorPautaFiscal'].toDouble() : null;
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = new Map<String, dynamic>();

		jsonDados['id'] = this.id ?? 0;
		jsonDados['idTributConfiguraOfGt'] = this.idTributConfiguraOfGt ?? 0;
		jsonDados['cstPis'] = this.cstPis;
		jsonDados['efdTabela435'] = this.efdTabela435;
		jsonDados['modalidadeBaseCalculo'] = setModalidadeBaseCalculo(this.modalidadeBaseCalculo);
		jsonDados['porcentoBaseCalculo'] = this.porcentoBaseCalculo;
		jsonDados['aliquotaPorcento'] = this.aliquotaPorcento;
		jsonDados['aliquotaUnidade'] = this.aliquotaUnidade;
		jsonDados['valorPrecoMaximo'] = this.valorPrecoMaximo;
		jsonDados['valorPautaFiscal'] = this.valorPautaFiscal;
	
		return jsonDados;
	}
	
    getModalidadeBaseCalculo(String modalidadeBaseCalculo) {
    	switch (modalidadeBaseCalculo) {
    		case '0':
    			return '0-Percentual';
    			break;
    		case '1':
    			return '1-Unidade';
    			break;
    		default:
    			return null;
    		}
    	}

    setModalidadeBaseCalculo(String modalidadeBaseCalculo) {
    	switch (modalidadeBaseCalculo) {
    		case '0-Percentual':
    			return '0';
    			break;
    		case '1-Unidade':
    			return '1';
    			break;
    		default:
    			return null;
    		}
    	}


	String objetoEncodeJson(TributPis objeto) {
	  final jsonDados = objeto.toJson;
	  return json.encode(jsonDados);
	}
	
}