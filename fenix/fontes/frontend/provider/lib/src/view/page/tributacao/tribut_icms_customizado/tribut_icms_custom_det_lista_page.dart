/*
Title: T2Ti ERP Fenix                                                                
Description: AbaDetalhe ListaPage relacionada à tabela [TRIBUT_ICMS_CUSTOM_DET] 
                                                                                
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
import 'tribut_icms_custom_det_detalhe_page.dart';
import 'tribut_icms_custom_det_persiste_page.dart';

class TributIcmsCustomDetListaPage extends StatefulWidget {
  final TributIcmsCustomCab tributIcmsCustomCab;

  const TributIcmsCustomDetListaPage({Key key, this.tributIcmsCustomCab}) : super(key: key);

  @override
  _TributIcmsCustomDetListaPageState createState() => _TributIcmsCustomDetListaPageState();
}

class _TributIcmsCustomDetListaPageState extends State<TributIcmsCustomDetListaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
          child: ViewUtilLib.getIconBotaoInserir(),
          onPressed: () {
            var tributIcmsCustomDet = new TributIcmsCustomDet();
            widget.tributIcmsCustomCab.listaTributIcmsCustomDet.add(tributIcmsCustomDet);
            Navigator.of(context)
                .push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        TributIcmsCustomDetPersistePage(
                            tributIcmsCustomCab: widget.tributIcmsCustomCab,
                            tributIcmsCustomDet: tributIcmsCustomDet,
                            title: 'Tribut Icms Custom Det - Inserindo',
                            operacao: 'I')))
                .then((_) {
              setState(() {
                if (tributIcmsCustomDet.ufDestino == null || tributIcmsCustomDet.ufDestino == "") { // se esse atributo estiver vazio, o objeto será removido
                  widget.tributIcmsCustomCab.listaTributIcmsCustomDet.remove(tributIcmsCustomDet);
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
    if (widget.tributIcmsCustomCab.listaTributIcmsCustomDet == null) {
      widget.tributIcmsCustomCab.listaTributIcmsCustomDet = [];
    }
    List<DataRow> lista = [];
    for (var tributIcmsCustomDet in widget.tributIcmsCustomCab.listaTributIcmsCustomDet) {
      List<DataCell> celulas = new List<DataCell>();

      celulas = [
        DataCell(Text('${ tributIcmsCustomDet.id ?? ''}'), onTap: () {
          detalharTributIcmsCustomDet(widget.tributIcmsCustomCab, tributIcmsCustomDet, context);
        }),
		DataCell(Text('${tributIcmsCustomDet.ufDestino ?? ''}'), onTap: () {
			detalharTributIcmsCustomDet(widget.tributIcmsCustomCab, tributIcmsCustomDet, context);
		}),
		DataCell(Text('${tributIcmsCustomDet.cfop ?? ''}'), onTap: () {
			detalharTributIcmsCustomDet(widget.tributIcmsCustomCab, tributIcmsCustomDet, context);
		}),
		DataCell(Text('${tributIcmsCustomDet.csosn ?? ''}'), onTap: () {
			detalharTributIcmsCustomDet(widget.tributIcmsCustomCab, tributIcmsCustomDet, context);
		}),
		DataCell(Text('${tributIcmsCustomDet.cst ?? ''}'), onTap: () {
			detalharTributIcmsCustomDet(widget.tributIcmsCustomCab, tributIcmsCustomDet, context);
		}),
		DataCell(Text('${tributIcmsCustomDet.modalidadeBc ?? ''}'), onTap: () {
			detalharTributIcmsCustomDet(widget.tributIcmsCustomCab, tributIcmsCustomDet, context);
		}),
		DataCell(Text('${tributIcmsCustomDet.aliquota != null ? Constantes.formatoDecimalTaxa.format(tributIcmsCustomDet.aliquota) : 0.toStringAsFixed(Constantes.decimaisTaxa)}'), onTap: () {
			detalharTributIcmsCustomDet(widget.tributIcmsCustomCab, tributIcmsCustomDet, context);
		}),
		DataCell(Text('${tributIcmsCustomDet.valorPauta != null ? Constantes.formatoDecimalValor.format(tributIcmsCustomDet.valorPauta) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharTributIcmsCustomDet(widget.tributIcmsCustomCab, tributIcmsCustomDet, context);
		}),
		DataCell(Text('${tributIcmsCustomDet.valorPrecoMaximo != null ? Constantes.formatoDecimalValor.format(tributIcmsCustomDet.valorPrecoMaximo) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharTributIcmsCustomDet(widget.tributIcmsCustomCab, tributIcmsCustomDet, context);
		}),
		DataCell(Text('${tributIcmsCustomDet.mva != null ? Constantes.formatoDecimalValor.format(tributIcmsCustomDet.mva) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharTributIcmsCustomDet(widget.tributIcmsCustomCab, tributIcmsCustomDet, context);
		}),
		DataCell(Text('${tributIcmsCustomDet.porcentoBc != null ? Constantes.formatoDecimalTaxa.format(tributIcmsCustomDet.porcentoBc) : 0.toStringAsFixed(Constantes.decimaisTaxa)}'), onTap: () {
			detalharTributIcmsCustomDet(widget.tributIcmsCustomCab, tributIcmsCustomDet, context);
		}),
		DataCell(Text('${tributIcmsCustomDet.modalidadeBcSt ?? ''}'), onTap: () {
			detalharTributIcmsCustomDet(widget.tributIcmsCustomCab, tributIcmsCustomDet, context);
		}),
		DataCell(Text('${tributIcmsCustomDet.aliquotaInternaSt != null ? Constantes.formatoDecimalTaxa.format(tributIcmsCustomDet.aliquotaInternaSt) : 0.toStringAsFixed(Constantes.decimaisTaxa)}'), onTap: () {
			detalharTributIcmsCustomDet(widget.tributIcmsCustomCab, tributIcmsCustomDet, context);
		}),
		DataCell(Text('${tributIcmsCustomDet.aliquotaInterestadualSt != null ? Constantes.formatoDecimalTaxa.format(tributIcmsCustomDet.aliquotaInterestadualSt) : 0.toStringAsFixed(Constantes.decimaisTaxa)}'), onTap: () {
			detalharTributIcmsCustomDet(widget.tributIcmsCustomCab, tributIcmsCustomDet, context);
		}),
		DataCell(Text('${tributIcmsCustomDet.porcentoBcSt != null ? Constantes.formatoDecimalTaxa.format(tributIcmsCustomDet.porcentoBcSt) : 0.toStringAsFixed(Constantes.decimaisTaxa)}'), onTap: () {
			detalharTributIcmsCustomDet(widget.tributIcmsCustomCab, tributIcmsCustomDet, context);
		}),
		DataCell(Text('${tributIcmsCustomDet.aliquotaIcmsSt != null ? Constantes.formatoDecimalTaxa.format(tributIcmsCustomDet.aliquotaIcmsSt) : 0.toStringAsFixed(Constantes.decimaisTaxa)}'), onTap: () {
			detalharTributIcmsCustomDet(widget.tributIcmsCustomCab, tributIcmsCustomDet, context);
		}),
		DataCell(Text('${tributIcmsCustomDet.valorPautaSt != null ? Constantes.formatoDecimalValor.format(tributIcmsCustomDet.valorPautaSt) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharTributIcmsCustomDet(widget.tributIcmsCustomCab, tributIcmsCustomDet, context);
		}),
		DataCell(Text('${tributIcmsCustomDet.valorPrecoMaximoSt != null ? Constantes.formatoDecimalValor.format(tributIcmsCustomDet.valorPrecoMaximoSt) : 0.toStringAsFixed(Constantes.decimaisValor)}'), onTap: () {
			detalharTributIcmsCustomDet(widget.tributIcmsCustomCab, tributIcmsCustomDet, context);
		}),
      ];

      lista.add(DataRow(cells: celulas));
    }
    return lista;
  }

  detalharTributIcmsCustomDet(
      TributIcmsCustomCab tributIcmsCustomCab, TributIcmsCustomDet tributIcmsCustomDet, BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (BuildContext context) => TributIcmsCustomDetDetalhePage(
                  tributIcmsCustomCab: tributIcmsCustomCab,
                  tributIcmsCustomDet: tributIcmsCustomDet,
                ))).then((_) {
				  setState(() {
					getRows();
				  });
				});
  }
}