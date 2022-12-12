//import 'dart:async';
import 'dart:typed_data';

//import 'package:fl_chart/fl_chart.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
// import 'package:universal_html/html.dart' as html;
// import 'dart:html' as html;

//import 'package:teoria_dos_jogos/public_goods/widgets/graphicPg.dart';
// import 'package:pdf_render/pdf_render.dart';
// import 'package:printing/printing.dart';

class Pdf {
  final pdfFile = pw.Document();

  createPdf(Uint8List image) {
    pdfFile.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
              // child: pw.Container(
              //child:
              //pw.Image(PdfImage.file(pdfFile.document, bytes: image))
              //),
              );
        }));
    salvePdf();
  }

  salvePdf() async {
    /*final dir = await getExternalStorageDirectory();
    print("Directoryyyyyyyyy:${dir.path}");
    final String path = "${dir.path}/graphic.pdf";
     final file = File(path);
      await file.writeAsBytes(pdfFile.save());
      await OpenFile.open(path,type: "application/pdf");
*/
  }
}

class PdfWeb {
  // final pdf = pw.Document();

  // createPdf(Uint8List image){

  //   pdf.addPage(pw.Page(
  //     pageFormat: PdfPageFormat.a4,
  //     build: (pw.Context context) {
  //       return pw.Center(
  //           child://pw.Text("hello")
  //           //pw.Image(PdfImage.file(pdf.document, bytes: image))
  //           pw.Image(PdfImage.file(pdf.document, bytes: image))
  //       );
  //     }));
  //     //salvePdf();
  //      final bytes = pdf.save();
  //      final blob = html.Blob([bytes], 'application/pdf');
  //      return blob;
  // }

  // static openPdf(blob){
  //   final url = html.Url.createObjectUrlFromBlob(blob);
  //               html.window.open(url, "_blank");
  //               html.Url.revokeObjectUrl(url);
  // }
  // static download(blob){
  //   final url = html.Url.createObjectUrlFromBlob(blob);
  //               final anchor =
  //                   html.document.createElement('a') as html.AnchorElement
  //                     ..href = url
  //                     ..style.display = 'none'
  //                     ..download = 'some_name.pdf';
  //               html.document.body.children.add(anchor);
  //               anchor.click();
  //               html.document.body.children.remove(anchor);
  //               html.Url.revokeObjectUrl(url);
  // }

  //  getImage(width,height)async{

  //    final canvas = html.CanvasElement(width: width, height: height,);
  //     var context = canvas.context2D;
  //     // context.draw...();
  //     final blob = await canvas.toBlob('image/jpeg', 0.8);

  //     download(blob);
  //     var image =await _getBlobData(blob);
  //     return image;
  //     //createPdf(image);
  //  }
  //  Future<Uint8List> _getBlobData(html.Blob blob) {
  //   final completer = Completer<Uint8List>();
  //   final reader = html.FileReader();
  //   reader.readAsArrayBuffer(blob);
  //   reader.onLoad.listen((_) => completer.complete(reader.result));
  //   return completer.future;
  // }

}
