/*
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [VENDA_FRETE] 
                                                                                
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

class VendaFrete {
	int id;
	int idVendaCabecalho;
	int idTransportadora;
	int conhecimento;
	String responsavel;
	String placa;
	String ufPlaca;
	int seloFiscal;
	double quantidadeVolume;
	String marcaVolume;
	String especieVolume;
	double pesoBruto;
	double pesoLiquido;
	VendaCabecalho vendaCabecalho;
	Transportadora transportadora;

	VendaFrete({
			this.id,
			this.idVendaCabecalho,
			this.idTransportadora,
			this.conhecimento,
			this.responsavel,
			this.placa,
			this.ufPlaca,
			this.seloFiscal,
			this.quantidadeVolume,
			this.marcaVolume,
			this.especieVolume,
			this.pesoBruto,
			this.pesoLiquido,
			this.vendaCabecalho,
			this.transportadora,
		});

	static List<String> campos = <String>[
		'ID', 
		'CONHECIMENTO', 
		'RESPONSAVEL', 
		'PLACA', 
		'UF_PLACA', 
		'SELO_FISCAL', 
		'QUANTIDADE_VOLUME', 
		'MARCA_VOLUME', 
		'ESPECIE_VOLUME', 
		'PESO_BRUTO', 
		'PESO_LIQUIDO', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'Conhecimento', 
		'Responsável', 
		'Placa', 
		'UF', 
		'Selo Fiscal', 
		'Quantidade de Volumes', 
		'Marca Volume', 
		'Espécie do Volume', 
		'Peso Bruto', 
		'Peso Líquido', 
	];

	VendaFrete.fromJson(Map<String, dynamic> jsonDados) {
		id = jsonDados['id'];
		idVendaCabecalho = jsonDados['idVendaCabecalho'];
		idTransportadora = jsonDados['idTransportadora'];
		conhecimento = jsonDados['conhecimento'];
		responsavel = getResponsavel(jsonDados['responsavel']);
		placa = jsonDados['placa'];
		ufPlaca = jsonDados['ufPlaca'] == '' ? null : jsonDados['ufPlaca'];
		seloFiscal = jsonDados['seloFiscal'];
		quantidadeVolume = jsonDados['quantidadeVolume'] != null ? jsonDados['quantidadeVolume'].toDouble() : null;
		marcaVolume = jsonDados['marcaVolume'];
		especieVolume = jsonDados['especieVolume'];
		pesoBruto = jsonDados['pesoBruto'] != null ? jsonDados['pesoBruto'].toDouble() : null;
		pesoLiquido = jsonDados['pesoLiquido'] != null ? jsonDados['pesoLiquido'].toDouble() : null;
		vendaCabecalho = jsonDados['vendaCabecalho'] == null ? null : new VendaCabecalho.fromJson(jsonDados['vendaCabecalho']);
		transportadora = jsonDados['transportadora'] == null ? null : new Transportadora.fromJson(jsonDados['transportadora']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = new Map<String, dynamic>();

		jsonDados['id'] = this.id ?? 0;
		jsonDados['idVendaCabecalho'] = this.idVendaCabecalho ?? 0;
		jsonDados['idTransportadora'] = this.idTransportadora ?? 0;
		jsonDados['conhecimento'] = this.conhecimento ?? 0;
		jsonDados['responsavel'] = setResponsavel(this.responsavel);
		jsonDados['placa'] = this.placa;
		jsonDados['ufPlaca'] = this.ufPlaca;
		jsonDados['seloFiscal'] = this.seloFiscal ?? 0;
		jsonDados['quantidadeVolume'] = this.quantidadeVolume;
		jsonDados['marcaVolume'] = this.marcaVolume;
		jsonDados['especieVolume'] = this.especieVolume;
		jsonDados['pesoBruto'] = this.pesoBruto;
		jsonDados['pesoLiquido'] = this.pesoLiquido;
		jsonDados['vendaCabecalho'] = this.vendaCabecalho == null ? null : this.vendaCabecalho.toJson;
		jsonDados['transportadora'] = this.transportadora == null ? null : this.transportadora.toJson;
	
		return jsonDados;
	}
	
    getResponsavel(String responsavel) {
    	switch (responsavel) {
    		case '1':
    			return '1-Emitente';
    			break;
    		case '2':
    			return '2-Destinatário';
    			break;
    		default:
    			return null;
    		}
    	}

    setResponsavel(String responsavel) {
    	switch (responsavel) {
    		case '1-Emitente':
    			return '1';
    			break;
    		case '2-Destinatário':
    			return '2';
    			break;
    		default:
    			return null;
    		}
    	}


	String objetoEncodeJson(VendaFrete objeto) {
	  final jsonDados = objeto.toJson;
	  return json.encode(jsonDados);
	}
	
}