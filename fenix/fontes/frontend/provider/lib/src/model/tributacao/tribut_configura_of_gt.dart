/*
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [TRIBUT_CONFIGURA_OF_GT] 
                                                                                
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

class TributConfiguraOfGt {
	int id;
	int idTributGrupoTributario;
	int idTributOperacaoFiscal;
	TributCofins tributCofins;
	TributIpi tributIpi;
	TributPis tributPis;
	TributGrupoTributario tributGrupoTributario;
	TributOperacaoFiscal tributOperacaoFiscal;
	List<TributIcmsUf> listaTributIcmsUf = [];

	TributConfiguraOfGt({
			this.id,
			this.idTributGrupoTributario,
			this.idTributOperacaoFiscal,
			this.tributCofins,
			this.tributIpi,
			this.tributPis,
			this.tributGrupoTributario,
			this.tributOperacaoFiscal,
			this.listaTributIcmsUf,
		});

	static List<String> campos = <String>[
		'ID', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
	];

	TributConfiguraOfGt.fromJson(Map<String, dynamic> jsonDados) {
		id = jsonDados['id'];
		idTributGrupoTributario = jsonDados['idTributGrupoTributario'];
		idTributOperacaoFiscal = jsonDados['idTributOperacaoFiscal'];
		tributCofins = jsonDados['tributCofins'] == null ? null : new TributCofins.fromJson(jsonDados['tributCofins']);
		tributIpi = jsonDados['tributIpi'] == null ? null : new TributIpi.fromJson(jsonDados['tributIpi']);
		tributPis = jsonDados['tributPis'] == null ? null : new TributPis.fromJson(jsonDados['tributPis']);
		tributGrupoTributario = jsonDados['tributGrupoTributario'] == null ? null : new TributGrupoTributario.fromJson(jsonDados['tributGrupoTributario']);
		tributOperacaoFiscal = jsonDados['tributOperacaoFiscal'] == null ? null : new TributOperacaoFiscal.fromJson(jsonDados['tributOperacaoFiscal']);
		listaTributIcmsUf = (jsonDados['listaTributIcmsUf'] as Iterable)?.map((m) => TributIcmsUf.fromJson(m))?.toList() ?? [];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = new Map<String, dynamic>();

		jsonDados['id'] = this.id ?? 0;
		jsonDados['idTributGrupoTributario'] = this.idTributGrupoTributario ?? 0;
		jsonDados['idTributOperacaoFiscal'] = this.idTributOperacaoFiscal ?? 0;
		jsonDados['tributCofins'] = this.tributCofins == null ? null : this.tributCofins.toJson;
		jsonDados['tributIpi'] = this.tributIpi == null ? null : this.tributIpi.toJson;
		jsonDados['tributPis'] = this.tributPis == null ? null : this.tributPis.toJson;
		jsonDados['tributGrupoTributario'] = this.tributGrupoTributario == null ? null : this.tributGrupoTributario.toJson;
		jsonDados['tributOperacaoFiscal'] = this.tributOperacaoFiscal == null ? null : this.tributOperacaoFiscal.toJson;
		

		var listaTributIcmsUfLocal = [];
		for (TributIcmsUf objeto in this.listaTributIcmsUf ?? []) {
			listaTributIcmsUfLocal.add(objeto.toJson);
		}
		jsonDados['listaTributIcmsUf'] = listaTributIcmsUfLocal;
	
		return jsonDados;
	}
	

	String objetoEncodeJson(TributConfiguraOfGt objeto) {
	  final jsonDados = objeto.toJson;
	  return json.encode(jsonDados);
	}
	
}