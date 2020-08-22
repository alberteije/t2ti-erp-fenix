/*
Title: T2Ti ERP Fenix                                                                
Description: AbaDetalhe ListaPage relacionada à tabela [TRIBUT_ICMS_UF] 
                                                                                
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
import 'package:flutter/material.dart';

import 'package:fenix/src/model/model.dart';
import 'package:fenix/src/view/shared/view_util_lib.dart';
import 'package:fenix/src/infra/constantes.dart';
import 'tribut_icms_uf_detalhe_page.dart';
import 'tribut_icms_uf_persiste_page.dart';

class TributIcmsUfListaPage extends StatefulWidget {
  final TributConfiguraOfGt tributConfiguraOfGt;

  const TributIcmsUfListaPage({Key key, this.tributConfiguraOfGt}) : super(key: key);

  @override
  _TributIcmsUfListaPageState createState() => _TributIcmsUfListaPageState();
}

class _TributIcmsUfListaPageState extends State<TributIcmsUfListaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
          child: ViewUtilLib.getIconBotaoInserir(),
          onPressed: () {
            var tributIcmsUf = new TributIcmsUf();
            widget.tributConfiguraOfGt.listaTributIcmsUf.add(tributIcmsUf);
            Navigator.of(context)
                .push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        TributIcmsUfPersistePage(
                            tributConfiguraOfGt: widget.tributConfiguraOfGt,
                            tributIcmsUf: tributIcmsUf,
                            title: 'Tribut Icms Uf - Inserindo',
                            operacao: 'I')))
                .then((_) {
              setState(() {
                if (tributIcmsUf.ufDestino == null || tributIcmsUf.ufDestino == "") { // se esse atributo estiver vazio, o objeto será removido
                  widget.tributConfiguraOfGt.listaTributIcmsUf.remove(tributIcmsUf);
                }
                getRows();
              });
            });
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: Scrollbar(
        child: ListView(
          padding: const EdgeInsets.all(2.0),
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Card(
                color: Colors.white,
                elevation: 2.0,
                child: DataTable(columns: getColumns(), rows: getRows()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<DataColumn> getColumns() {
    List<DataColumn> lista = [];
	lista.add(DataColumn(numeric: true, label: Text('Id')));
	lista.add(DataColumn(label: Text('UF')));
	lista.add(DataColumn(numeric: true, label: Text('CFOP')));
	lista.add(DataColumn(label: Text('CSOSN')));
	lista.add(DataColumn(label: Text('CST')));
	lista.add(DataColumn(label: Text('Modalidade Base Cálculo')));
	lista.add(DataColumn(numeric: true, label: Text('Alíquota')));
	lista.add(DataColumn(numeric: true, label: Text('Valor Pauta')));
	lista.add(DataColumn(numeric: true, label: Text('Valor Preço Máximo')));
	lista.add(DataColumn(numeric: true, label: Text('Valor MVA')));
	lista.add(DataColumn(numeric: true, label: Text('Porcento Base Cálculo')));
	lista.add(DataColumn(label: Text('Modalidade Base Cálculo ST')));
	lista.add(DataColumn(numeric: true, label: Text('Alíquota Interna ST')));
	lista.add(DataColumn(numeric: true, label: Text('Alíquota Interestadual ST')));
	lista.add(DataColumn(numeric: true, label: Text('Porcento Base Cálculo ST')));
	lista.add(DataColumn(numeric: true, label: Text('Alíquota ICMS ST')));
	lista.add(DataColumn(numeric: true, label: Text('Valor Pauta ST')));
	lista.add(DataColumn(numeric: true, label: Text('Valor Preço Máximo ST')));
    return lista;
  }

  List<DataRow> getRows() {
    if (widget.tributConfiguraOfGt.listaTributIcmsUf == null) {
      widget.tributConfiguraOfGt.listaTributIcmsUf = [];
    }
    List<DataRow> lista = [];
    for (var tributIcmsUf in widget.tributConfiguraOfGt.listaTributIcmsUf) {
      List<DataCell> celulas = new List<DataCell>();

      celulas = [
        DataCell(Text('${ tributIcmsUf.id ?? ''}'), onTap: () {
          detalharTributIcmsUf(widget.tributConfiguraOfGt, tributIcmsUf, context);
        }),
		DataCell(Text('${tributIcmsUf.ufDestino ?? ''}'), onTap: () {
			detalharTributIcmsUf(widget.tributConfiguraOfGt, tributIcmsUf, context);
		}),
		DataCell(Text('${tributIcmsUf.cfop ?? ''}'), onTap: () {
			detalharTributIcmsUf(widget.tributConfiguraOfGt, tributIcmsUf, context);
		}),
		DataCell(Text('${tributIcmsUf.csosn ?? ''}'), onTap: () {
			detalharTributIcmsUf(widget.tributConfiguraOfGt, tributIcmsUf, context);
		}),
		DataCell(Text('${tributIcmsUf.cst ?? ''}'), onTap: () {
			detalharTributIcmsUf(widget.tributConfiguraOfGt, tributIcmsUf, context);
		}),
		DataCell(Text('${tributIcmsUf.modalidadeBc ?? ''}'), onTap: () {
			detalharTributIcmsUf(widget.tributConfiguraOfGt, tributIcmsUf, context);
		}),
		DataCell(Text('${tributIcmsUf.aliquota != null ? Constantes.formatoDecimalTaxa.format(tributIcmsUf.aliquota) : 0.toStringAsFixed(Constantes.decimaisTaxa)}'), onTap: () {
			detalharTributIcmsUf(widget.tributConfiguraOfGt, tributIcmsUf, context);
		}),
		DataCell(Text('${tributIcmsUf.valorPauta != null ? Constantes.formatoDecimalValor.format(tributIcmsUf.valorPauta) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharTributIcmsUf(widget.tributConfiguraOfGt, tributIcmsUf, context);
		}),
		DataCell(Text('${tributIcmsUf.valorPrecoMaximo != null ? Constantes.formatoDecimalValor.format(tributIcmsUf.valorPrecoMaximo) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharTributIcmsUf(widget.tributConfiguraOfGt, tributIcmsUf, context);
		}),
		DataCell(Text('${tributIcmsUf.mva != null ? Constantes.formatoDecimalValor.format(tributIcmsUf.mva) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharTributIcmsUf(widget.tributConfiguraOfGt, tributIcmsUf, context);
		}),
		DataCell(Text('${tributIcmsUf.porcentoBc != null ? Constantes.formatoDecimalTaxa.format(tributIcmsUf.porcentoBc) : 0.toStringAsFixed(Constantes.decimaisTaxa)}'), onTap: () {
			detalharTributIcmsUf(widget.tributConfiguraOfGt, tributIcmsUf, context);
		}),
		DataCell(Text('${tributIcmsUf.modalidadeBcSt ?? ''}'), onTap: () {
			detalharTributIcmsUf(widget.tributConfiguraOfGt, tributIcmsUf, context);
		}),
		DataCell(Text('${tributIcmsUf.aliquotaInternaSt != null ? Constantes.formatoDecimalTaxa.format(tributIcmsUf.aliquotaInternaSt) : 0.toStringAsFixed(Constantes.decimaisTaxa)}'), onTap: () {
			detalharTributIcmsUf(widget.tributConfiguraOfGt, tributIcmsUf, context);
		}),
		DataCell(Text('${tributIcmsUf.aliquotaInterestadualSt != null ? Constantes.formatoDecimalTaxa.format(tributIcmsUf.aliquotaInterestadualSt) : 0.toStringAsFixed(Constantes.decimaisTaxa)}'), onTap: () {
			detalharTributIcmsUf(widget.tributConfiguraOfGt, tributIcmsUf, context);
		}),
		DataCell(Text('${tributIcmsUf.porcentoBcSt != null ? Constantes.formatoDecimalTaxa.format(tributIcmsUf.porcentoBcSt) : 0.toStringAsFixed(Constantes.decimaisTaxa)}'), onTap: () {
			detalharTributIcmsUf(widget.tributConfiguraOfGt, tributIcmsUf, context);
		}),
		DataCell(Text('${tributIcmsUf.aliquotaIcmsSt != null ? Constantes.formatoDecimalTaxa.format(tributIcmsUf.aliquotaIcmsSt) : 0.toStringAsFixed(Constantes.decimaisTaxa)}'), onTap: () {
			detalharTributIcmsUf(widget.tributConfiguraOfGt, tributIcmsUf, context);
		}),
		DataCell(Text('${tributIcmsUf.valorPautaSt != null ? Constantes.formatoDecimalValor.format(tributIcmsUf.valorPautaSt) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharTributIcmsUf(widget.tributConfiguraOfGt, tributIcmsUf, context);
		}),
		DataCell(Text('${tributIcmsUf.valorPrecoMaximoSt != null ? Constantes.formatoDecimalValor.format(tributIcmsUf.valorPrecoMaximoSt) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharTributIcmsUf(widget.tributConfiguraOfGt, tributIcmsUf, context);
		}),
      ];

      lista.add(DataRow(cells: celulas));
    }
    return lista;
  }

  detalharTributIcmsUf(
      TributConfiguraOfGt tributConfiguraOfGt, TributIcmsUf tributIcmsUf, BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (BuildContext context) => TributIcmsUfDetalhePage(
                  tributConfiguraOfGt: tributConfiguraOfGt,
                  tributIcmsUf: tributIcmsUf,
                ))).then((_) {
				  setState(() {
					getRows();
				  });
				});
  }
}