import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:teoria_dos_jogos/app_localizations.dart';
import 'package:teoria_dos_jogos/classes/resize.dart';

class PdfPage extends StatefulWidget {
  final String? pdfName;
  final Function? then;

  const PdfPage({this.pdfName, this.then});

  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  PdfViewerController? _pdfViewerController;
  bool read = false;
  bool readEnd = false;
  @override
  void initState() {
    _pdfViewerController = PdfViewerController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double longestSide = MediaQuery.of(context).size.longestSide;

    bool landscape = MediaQuery.of(context).size.aspectRatio > 1.5;
    double fontSize = landscape ? longestSide * 0.015 : longestSide * 0.03;
    double padding = landscape ? longestSide * 0.02 : longestSide * 0.03;

    return Scaffold(
        body:
            //  Container(
            //   child: pdfView()
            // ));
            //         Container(
            //   child: SfPdfViewer.network(
            //     // "https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf",
            //     'https://v1.begapp.com.br/files/pg61925.pdf',
            //     // "https://v1.begapp.com.br/loadPdf.php",
            //     // 'https://v1.begapp.com.br/files/${widget.pdfName}.pdf',
            //     controller: _pdfViewerController,
            //   ),
            // ));
            Flex(
      direction: Axis.vertical,
      children: [
        Expanded(
          flex: 4,
          child: Container(
            child: SfPdfViewer.network(
              //'https://v1.begapp.com.br/files/pg61925.pdf',
              'https://v1.begapp.com.br/files/${widget.pdfName}.pdf',
              controller: _pdfViewerController,
            ),
          ),
        ),
        // Expanded(flex: 1, child: Text("aa")),
        Row(
          children: [
            Checkbox(
              value: read,
              onChanged: (value) {
                setState(() {
                  readEnd = _pdfViewerController!.pageNumber ==
                      _pdfViewerController!.pageCount;

                  if (readEnd)
                    read = value!;
                  else
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              content: Text(
                                // "Você ainda não chegou até ao final do documento, termine a leitura para prosseguir.",
                                AppLocalizations.of(context)
                                    .translate('Didnt finished the read'),
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height /
                                            30),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate('ok'),
                                      style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              30),
                                    )),
                              ],
                            ));
                });
              },
            ),
            Text(
              // "Li e concordo com os termos",
              AppLocalizations.of(context).translate('Read and agreed'),
              style: TextStyle(fontSize: Resize.getWidth(context) * 0.05),
            )
          ],
        ),
        Container(
          // height: double.infinity,
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: padding, vertical: padding),
          padding: EdgeInsets.symmetric(vertical: padding / 2),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextButton(
            onPressed: () async {
              if (readEnd) //print("CHEGOU AO FIM");
                widget.then!();
            },
            child: Text(AppLocalizations.of(context).translate('next'),
                style: TextStyle(fontSize: fontSize, color: Colors.white)),
          ),
        ),
      ],
    ));
  }
}
