/*
Title: T2Ti ERP Fenix                                                                
Description: Model relacionado à tabela [OS_ABERTURA] 
                                                                                
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

class OsAbertura {
	int id;
	int idOsStatus;
	int idCliente;
	int idColaborador;
	String numero;
	DateTime dataInicio;
	String horaInicio;
	DateTime dataPrevisao;
	String horaPrevisao;
	DateTime dataFim;
	String horaFim;
	String nomeContato;
	String foneContato;
	String observacaoCliente;
	String observacaoAbertura;
	OsStatus osStatus;
	Cliente cliente;
	Colaborador colaborador;
	List<OsAberturaEquipamento> listaOsAberturaEquipamento = [];
	List<OsEvolucao> listaOsEvolucao = [];
	List<OsProdutoServico> listaOsProdutoServico = [];

	OsAbertura({
			this.id,
			this.idOsStatus,
			this.idCliente,
			this.idColaborador,
			this.numero,
			this.dataInicio,
			this.horaInicio,
			this.dataPrevisao,
			this.horaPrevisao,
			this.dataFim,
			this.horaFim,
			this.nomeContato,
			this.foneContato,
			this.observacaoCliente,
			this.observacaoAbertura,
			this.osStatus,
			this.cliente,
			this.colaborador,
			this.listaOsAberturaEquipamento,
			this.listaOsEvolucao,
			this.listaOsProdutoServico,
		});

	static List<String> campos = <String>[
		'ID', 
		'NUMERO', 
		'DATA_INICIO', 
		'HORA_INICIO', 
		'DATA_PREVISAO', 
		'HORA_PREVISAO', 
		'DATA_FIM', 
		'HORA_FIM', 
		'NOME_CONTATO', 
		'FONE_CONTATO', 
		'OBSERVACAO_CLIENTE', 
		'OBSERVACAO_ABERTURA', 
	];
	
	static List<String> colunas = <String>[
		'Id', 
		'Número', 
		'Data Inicial', 
		'Hora Inicial', 
		'Data Prevista', 
		'Hora Prevista', 
		'Data Final', 
		'Hora Final', 
		'Nome do Contato', 
		'Telefone do Contato', 
		'Observação Cliente', 
		'Observação Abertura', 
	];

	OsAbertura.fromJson(Map<String, dynamic> jsonDados) {
		id = jsonDados['id'];
		idOsStatus = jsonDados['idOsStatus'];
		idCliente = jsonDados['idCliente'];
		idColaborador = jsonDados['idColaborador'];
		numero = jsonDados['numero'];
		dataInicio = jsonDados['dataInicio'] != null ? DateTime.tryParse(jsonDados['dataInicio']) : null;
		horaInicio = jsonDados['horaInicio'];
		dataPrevisao = jsonDados['dataPrevisao'] != null ? DateTime.tryParse(jsonDados['dataPrevisao']) : null;
		horaPrevisao = jsonDados['horaPrevisao'];
		dataFim = jsonDados['dataFim'] != null ? DateTime.tryParse(jsonDados['dataFim']) : null;
		horaFim = jsonDados['horaFim'];
		nomeContato = jsonDados['nomeContato'];
		foneContato = jsonDados['foneContato'];
		observacaoCliente = jsonDados['observacaoCliente'];
		observacaoAbertura = jsonDados['observacaoAbertura'];
		osStatus = jsonDados['osStatus'] == null ? null : new OsStatus.fromJson(jsonDados['osStatus']);
		cliente = jsonDados['cliente'] == null ? null : new Cliente.fromJson(jsonDados['cliente']);
		colaborador = jsonDados['colaborador'] == null ? null : new Colaborador.fromJson(jsonDados['colaborador']);
		listaOsAberturaEquipamento = (jsonDados['listaOsAberturaEquipamento'] as Iterable)?.map((m) => OsAberturaEquipamento.fromJson(m))?.toList() ?? [];
		listaOsEvolucao = (jsonDados['listaOsEvolucao'] as Iterable)?.map((m) => OsEvolucao.fromJson(m))?.toList() ?? [];
		listaOsProdutoServico = (jsonDados['listaOsProdutoServico'] as Iterable)?.map((m) => OsProdutoServico.fromJson(m))?.toList() ?? [];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonDados = new Map<String, dynamic>();

		jsonDados['id'] = this.id ?? 0;
		jsonDados['idOsStatus'] = this.idOsStatus ?? 0;
		jsonDados['idCliente'] = this.idCliente ?? 0;
		jsonDados['idColaborador'] = this.idColaborador ?? 0;
		jsonDados['numero'] = this.numero;
		jsonDados['dataInicio'] = this.dataInicio != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.dataInicio) : null;
		jsonDados['horaInicio'] = Biblioteca.removerMascara(this.horaInicio);
		jsonDados['dataPrevisao'] = this.dataPrevisao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.dataPrevisao) : null;
		jsonDados['horaPrevisao'] = Biblioteca.removerMascara(this.horaPrevisao);
		jsonDados['dataFim'] = this.dataFim != null ? DateFormat('yyyy-MM-ddT00:00:00').format(this.dataFim) : null;
		jsonDados['horaFim'] = Biblioteca.removerMascara(this.horaFim);
		jsonDados['nomeContato'] = this.nomeContato;
		jsonDados['foneContato'] = Biblioteca.removerMascara(this.foneContato);
		jsonDados['observacaoCliente'] = this.observacaoCliente;
		jsonDados['observacaoAbertura'] = this.observacaoAbertura;
		jsonDados['osStatus'] = this.osStatus == null ? null : this.osStatus.toJson;
		jsonDados['cliente'] = this.cliente == null ? null : this.cliente.toJson;
		jsonDados['colaborador'] = this.colaborador == null ? null : this.colaborador.toJson;
		

		var listaOsAberturaEquipamentoLocal = [];
		for (OsAberturaEquipamento objeto in this.listaOsAberturaEquipamento ?? []) {
			listaOsAberturaEquipamentoLocal.add(objeto.toJson);
		}
		jsonDados['listaOsAberturaEquipamento'] = listaOsAberturaEquipamentoLocal;
		

		var listaOsEvolucaoLocal = [];
		for (OsEvolucao objeto in this.listaOsEvolucao ?? []) {
			listaOsEvolucaoLocal.add(objeto.toJson);
		}
		jsonDados['listaOsEvolucao'] = listaOsEvolucaoLocal;
		

		var listaOsProdutoServicoLocal = [];
		for (OsProdutoServico objeto in this.listaOsProdutoServico ?? []) {
			listaOsProdutoServicoLocal.add(objeto.toJson);
		}
		jsonDados['listaOsProdutoServico'] = listaOsProdutoServicoLocal;
	
		return jsonDados;
	}
	

	String objetoEncodeJson(OsAbertura objeto) {
	  final jsonDados = objeto.toJson;
	  return json.encode(jsonDados);
	}
	
}