/*
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [VIEW_FIN_CHEQUE_NAO_COMPENSADO] 
                                                                                
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

class ViewFinChequeNaoCompensado {
	int id;
	int idContaCaixa;
	String nomeContaCaixa;
	String talao;
	int numeroTalao;
	int numeroCheque;
	String statusCheque;
	DateTime dataStatus;
	double valor;

	ViewFinChequeNaoCompensado({
			this.id,
			this.idContaCaixa,
			this.nomeContaCaixa,
			this.talao,
			this.numeroTalao,
			this.numeroCheque,
			this.statusCheque,
			this.dataStatus,
			this.valor,
		});

	static List<String> campos = <String>[
		'ID', 
		'NOME_CONTA_CAIXA', 
		'TALAO', 
		'NUMERO_TALAO', 
		'NUMERO_CHEQUE', 
		'STATUS_CHEQUE', 
		'DATA_STATUS', 
		'VALOR', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'Nome', 
		'Código do Talão', 
		'Número do Talão', 
		'Número', 
		'Status', 
		'Data do Status', 
		'Valor', 
	];

	ViewFinChequeNaoCompensado.fromJson(Map<String, dynamic> jsonDados) {
		id = jsonDados['id'];
		idContaCaixa = jsonDados['idContaCaixa'];
		nomeContaCaixa = jsonDados['nomeContaCaixa'];
		talao = jsonDados['talao'];
		numeroTalao = jsonDados['numeroTalao'];
		numeroCheque = jsonDados['numeroCheque'];
		statusCheque = getStatusCheque(jsonDados['statusCheque']);
		dataStatus = jsonDados['dataStatus'] != null ? DateTime.tryParse(jsonDados['dataStatus']) : null;
		valor = jsonDados['valor'] != null ? jsonDados['valor'].toDouble() : null;
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = new Map<String, dynamic>();

		jsonDados['id'] = this.id ?? 0;
		jsonDados['idContaCaixa'] = this.idContaCaixa ?? 0;
		jsonDados['nomeContaCaixa'] = this.nomeContaCaixa;
		jsonDados['talao'] = this.talao;
		jsonDados['numeroTalao'] = this.numeroTalao ?? 0;
		jsonDados['numeroCheque'] = this.numeroCheque ?? 0;
		jsonDados['statusCheque'] = setStatusCheque(this.statusCheque);
		jsonDados['dataStatus'] = this.dataStatus != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.dataStatus) : null;
		jsonDados['valor'] = this.valor;
	
		return jsonDados;
	}
	
    getStatusCheque(String statusCheque) {
    	switch (statusCheque) {
    		case '0':
    			return 'Em Ser';
    			break;
    		case '1':
    			return 'Baixado';
    			break;
    		case '2':
    			return 'Utilizado';
    			break;
    		case '3':
    			return 'Compensado';
    			break;
    		case '4':
    			return 'Cancelado';
    			break;
    		default:
    			return null;
    		}
    	}

    setStatusCheque(String statusCheque) {
    	switch (statusCheque) {
    		case 'Em Ser':
    			return '0';
    			break;
    		case 'Baixado':
    			return '1';
    			break;
    		case 'Utilizado':
    			return '2';
    			break;
    		case 'Compensado':
    			return '3';
    			break;
    		case 'Cancelado':
    			return '4';
    			break;
    		default:
    			return null;
    		}
    	}


	String objetoEncodeJson(ViewFinChequeNaoCompensado objeto) {
	  final jsonDados = objeto.toJson;
	  return json.encode(jsonDados);
	}
	
}