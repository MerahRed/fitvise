// lib/utils/pdf_generator.dart
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

class PdfGenerator {
  /// Generates the Result Sheet PDF and returns the saved File.
  /// Convert any numeric values to String when you call this.
  static Future<File> generateResultSheetPdf({
    required String currentUsername,
    required String currentHeight,
    required String currentWeight,
    required String userStatus,
    required String overall,
    required Map<String, dynamic> segak,
    String filename = 'segak_result.pdf',
  }) async {
    final pdf = pw.Document();

    // Build the label/value pairs based on your Table
    final List<List<String>> rows = [
      ['Name', currentUsername],
      ['Height (cm)', currentHeight],
      ['Weight (kg)', currentWeight],
      ['BMI', userStatus],
      ['Push Up Count', '${segak['Push up'] ?? ''}'],
      ['Sit Up Count', '${segak['Sit up'] ?? ''}'],
      ['Step test BPM', '${segak['Step test'] ?? ''}'],
      ['Sit and Reach Mark', '${segak['Sit and Reach'] ?? ''}'],
    ];

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(24),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
            children: [
              pw.SizedBox(height: 6),
              pw.Center(
                child: pw.Text(
                  'Result Sheet',
                  style: pw.TextStyle(
                    fontSize: 28,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.green,
                  ),
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Divider(color: PdfColors.green, thickness: 2),
              pw.SizedBox(height: 12),

              // Table
              pw.Table(
                border: pw.TableBorder.all(color: PdfColors.green, width: 1),
                columnWidths: {
                  0: const pw.FlexColumnWidth(2),
                  1: const pw.FlexColumnWidth(3),
                },
                children: [
                  // Build rows from the list. We'll use a light/dark pattern:
                  for (int i = 0; i < rows.length; i++)
                    pw.TableRow(
                      // alternate background for visual clarity; keep the theme green
                      decoration: pw.BoxDecoration(
                        color: (i % 2 == 0)
                            ? PdfColors.green.shade(0.08)
                            : PdfColors.white,
                      ),
                      children: [
                        pw.Padding(
                          padding: pw.EdgeInsets.all(8),
                          child: pw.Text(
                            rows[i][0],
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          ),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(8),
                          child: pw.Text(rows[i][1]),
                        ),
                      ],
                    ),

                  // OVERALL row (green background + white text)
                  pw.TableRow(
                    decoration: pw.BoxDecoration(color: PdfColors.green),
                    children: [
                      pw.Padding(
                        padding: pw.EdgeInsets.all(8),
                        child: pw.Text(
                          'OVERALL',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.white,
                          ),
                        ),
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(8),
                        child: pw.Text(
                          overall, // overall result - CHANGE THIS
                          style: pw.TextStyle(color: PdfColors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              pw.SizedBox(height: 18),
              pw.Text(
                'Keep up the good work and stay active!',
                style: pw.TextStyle(color: PdfColors.grey600),
              ),
            ],
          );
        },
      ),
    );

    // Save to device (app documents directory)
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(await pdf.save());
    return file;
  }
}
