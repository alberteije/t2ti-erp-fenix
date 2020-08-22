/*
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [VENDA_CONDICOES_PAGAMENTO] 
                                                                                
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

class VendaCondicoesPagamento {
	int id;
	String nome;
	String descricao;
	double faturamentoMinimo;
	double faturamentoMaximo;
	double indiceCorrecao;
	int diasTolerancia;
	double valorTolerancia;
	int prazoMedio;
	String vistaPrazo;
	List<VendaCondicoesParcelas> listaVendaCondicoesParcelas = [];

	VendaCondicoesPagamento({
			this.id,
			this.nome,
			this.descricao,
			this.faturamentoMinimo,
			this.faturamentoMaximo,
			this.indiceCorrecao,
			this.diasTolerancia,
			this.valorTolerancia,
			this.prazoMedio,
			this.vistaPrazo,
			this.listaVendaCondicoesParcelas,
		});

	static List<String> campos = <String>[
		'ID', 
		'NOME', 
		'DESCRICAO', 
		'FATURAMENTO_MINIMO', 
		'FATURAMENTO_MAXIMO', 
		'INDICE_CORRECAO', 
		'DIAS_TOLERANCIA', 
		'VALOR_TOLERANCIA', 
		'PRAZO_MEDIO', 
		'VISTA_PRAZO', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'Nome', 
		'Descrição', 
		'Faturamento Mínimo', 
		'Faturamento Máximo', 
		'Índice de Correção', 
		'Dias de Tolerância', 
		'Valor Tolerância', 
		'Prazo Médio', 
		'Vista ou Prazo', 
	];

	VendaCondicoesPagamento.fromJson(Map<String, dynamic> jsonDados) {
		id = jsonDados['id'];
		nome = jsonDados['nome'];
		descricao = jsonDados['descricao'];
		faturamentoMinimo = jsonDados['faturamentoMinimo'] != null ? jsonDados['faturamentoMinimo'].toDouble() : null;
		faturamentoMaximo = jsonDados['faturamentoMaximo'] != null ? jsonDados['faturamentoMaximo'].toDouble() : null;
		indiceCorrecao = jsonDados['indiceCorrecao'] != null ? jsonDados['indiceCorrecao'].toDouble() : null;
		diasTolerancia = jsonDados['diasTolerancia'];
		valorTolerancia = jsonDados['valorTolerancia'] != null ? jsonDados['valorTolerancia'].toDouble() : null;
		prazoMedio = jsonDados['prazoMedio'];
		vistaPrazo = getVistaPrazo(jsonDados['vistaPrazo']);
		listaVendaCondicoesParcelas = (jsonDados['listaVendaCondicoesParcelas'] as Iterable)?.map((m) => VendaCondicoesParcelas.fromJson(m))?.toList() ?? [];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = new Map<String, dynamic>();

		jsonDados['id'] = this.id ?? 0;
		jsonDados['nome'] = this.nome;
		jsonDados['descricao'] = this.descricao;
		jsonDados['faturamentoMinimo'] = this.faturamentoMinimo;
		jsonDados['faturamentoMaximo'] = this.faturamentoMaximo;
		jsonDados['indiceCorrecao'] = this.indiceCorrecao;
		jsonDados['diasTolerancia'] = this.diasTolerancia ?? 0;
		jsonDados['valorTolerancia'] = this.valorTolerancia;
		jsonDados['prazoMedio'] = this.prazoMedio ?? 0;
		jsonDados['vistaPrazo'] = setVistaPrazo(this.vistaPrazo);
		

		var listaVendaCondicoesParcelasLocal = [];
		for (VendaCondicoesParcelas objeto in this.listaVendaCondicoesParcelas ?? []) {
			listaVendaCondicoesParcelasLocal.add(objeto.toJson);
		}
		jsonDados['listaVendaCondicoesParcelas'] = listaVendaCondicoesParcelasLocal;
	
		return jsonDados;
	}
	
    getVistaPrazo(String vistaPrazo) {
    	switch (vistaPrazo) {
    		case 'V':
    			return 'Vista';
    			break;
    		case 'P':
    			return 'Prazo';
    			break;
    		default:
    			return null;
    		}
    	}

    setVistaPrazo(String vistaPrazo) {
    	switch (vistaPrazo) {
    		case 'Vista':
    			return 'V';
    			break;
    		case 'Prazo':
    			return 'P';
    			break;
    		default:
    			return null;
    		}
    	}


	String objetoEncodeJson(VendaCondicoesPagamento objeto) {
	  final jsonDados = objeto.toJson;
	  return json.encode(jsonDados);
	}
	
}