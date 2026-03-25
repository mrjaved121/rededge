import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../domain/entities/job_entity.dart';
import '../../domain/entities/step_entity.dart';
import '../../../../core/widgets/status_badge.dart';

class PdfReportService {
  static Future<Uint8List> generateJobReport(JobEntity job) async {
    final pdf = pw.Document(
      title: '${job.title} - Installation Report',
      author: 'RED EDGE',
    );

    final redColor = PdfColor.fromHex('#D32F2F');
    final greenColor = PdfColor.fromHex('#2E7D32');
    final greyColor = PdfColor.fromHex('#757575');

    // Group steps by section
    final sectionGroups = <String, List<StepEntity>>{};
    for (final step in job.steps) {
      final section = step.section.isNotEmpty ? step.section : 'General';
      sectionGroups.putIfAbsent(section, () => []).add(step);
    }

    // Compute pass/fail
    final totalSteps = job.steps.where((s) => s.inputType != 'section_header').length;
    final completedSteps = job.steps.where((s) => s.isCompleted || s.inputValue.isNotEmpty).length;
    final allComplete = completedSteps == totalSteps && totalSteps > 0;

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        header: (context) => _buildHeader(job, redColor),
        footer: (context) => _buildFooter(context, greyColor),
        build: (context) => [
          // Job information table
          _buildInfoTable(job, allComplete, greenColor, redColor),
          pw.SizedBox(height: 16),

          // Pass/Fail summary
          _buildPassFailBanner(allComplete, completedSteps, totalSteps, greenColor, redColor),
          pw.SizedBox(height: 20),

          // Steps by section
          ...sectionGroups.entries.expand((entry) => [
                pw.Container(
                  width: double.infinity,
                  padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: pw.BoxDecoration(
                    color: PdfColor.fromHex('#ECEFF1'),
                    borderRadius: pw.BorderRadius.circular(4),
                  ),
                  child: pw.Text(
                    entry.key,
                    style: pw.TextStyle(
                      fontSize: 13,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColor.fromHex('#37474F'),
                    ),
                  ),
                ),
                pw.SizedBox(height: 6),
                ...entry.value.where((s) => s.inputType != 'section_header').map(
                    (step) => _buildStepRow(step, greenColor, redColor, greyColor)),
                pw.SizedBox(height: 12),
              ]),

          // Serial numbers / input values summary
          _buildInputSummary(job.steps, redColor),
        ],
      ),
    );

    return pdf.save();
  }

  static pw.Widget _buildHeader(JobEntity job, PdfColor redColor) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 16),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'RED EDGE',
                  style: pw.TextStyle(
                    fontSize: 22,
                    fontWeight: pw.FontWeight.bold,
                    color: redColor,
                  ),
                ),
                pw.Text(
                  'Installation Report',
                  style: pw.TextStyle(fontSize: 14, color: PdfColors.grey700),
                ),
              ],
            ),
          ),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Text(
                job.displayId,
                style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
              ),
              pw.Text(
                'Generated: ${_formatDate(DateTime.now())}',
                style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey600),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildFooter(pw.Context context, PdfColor greyColor) {
    return pw.Container(
      alignment: pw.Alignment.centerRight,
      margin: const pw.EdgeInsets.only(top: 8),
      child: pw.Text(
        'Page ${context.pageNumber} of ${context.pagesCount}',
        style: pw.TextStyle(fontSize: 9, color: greyColor),
      ),
    );
  }

  static pw.Widget _buildInfoTable(
      JobEntity job, bool allComplete, PdfColor greenColor, PdfColor redColor) {
    final statusColor = allComplete ? greenColor : PdfColor.fromHex('#F57C00');
    final statusText = job.status == JobStatus.completed
        ? 'Completed'
        : job.status == JobStatus.inProgress
            ? 'In Progress'
            : 'Pending';

    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
      columnWidths: {
        0: const pw.FlexColumnWidth(1),
        1: const pw.FlexColumnWidth(2),
      },
      children: [
        _infoRow('Job Title', job.title),
        _infoRow('Job ID', job.displayId),
        _infoRow('System Type', job.systemType),
        _infoRow('Location', job.location),
        _infoRow('Address', job.address),
        _infoRow('Company', job.company),
        _infoRow('Installer', job.assignedToName ?? 'Unassigned'),
        _infoRow('Date', job.formattedDate),
        pw.TableRow(children: [
          pw.Container(
            padding: const pw.EdgeInsets.all(6),
            color: PdfColors.grey100,
            child: pw.Text('Status',
                style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
          ),
          pw.Container(
            padding: const pw.EdgeInsets.all(6),
            child: pw.Text(statusText,
                style: pw.TextStyle(fontSize: 10, color: statusColor,
                    fontWeight: pw.FontWeight.bold)),
          ),
        ]),
      ],
    );
  }

  static pw.TableRow _infoRow(String label, String value) {
    return pw.TableRow(children: [
      pw.Container(
        padding: const pw.EdgeInsets.all(6),
        color: PdfColors.grey100,
        child: pw.Text(label,
            style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
      ),
      pw.Container(
        padding: const pw.EdgeInsets.all(6),
        child: pw.Text(value, style: const pw.TextStyle(fontSize: 10)),
      ),
    ]);
  }

  static pw.Widget _buildPassFailBanner(
      bool allComplete, int completed, int total, PdfColor green, PdfColor red) {
    final color = allComplete ? green : red;
    final label = allComplete ? 'PASS' : 'INCOMPLETE';
    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: pw.BoxDecoration(
        color: color,
        borderRadius: pw.BorderRadius.circular(6),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            label,
            style: pw.TextStyle(
              fontSize: 18,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.white,
            ),
          ),
          pw.Text(
            '$completed / $total steps completed',
            style: pw.TextStyle(
              fontSize: 12,
              color: PdfColors.white,
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildStepRow(
      StepEntity step, PdfColor green, PdfColor red, PdfColor grey) {
    final done = step.isCompleted || step.inputValue.isNotEmpty;
    final icon = done ? '✓' : '○';
    final iconColor = done ? green : grey;

    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      margin: const pw.EdgeInsets.only(bottom: 2),
      decoration: pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(color: PdfColors.grey200, width: 0.5),
        ),
      ),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Container(
            width: 16,
            child: pw.Text(icon,
                style: pw.TextStyle(
                    fontSize: 12, fontWeight: pw.FontWeight.bold, color: iconColor)),
          ),
          pw.SizedBox(width: 6),
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  '${step.number}. ${step.title}',
                  style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
                ),
                if (step.hasInput && step.inputValue.isNotEmpty)
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(top: 2),
                    child: pw.Text(
                      '${step.inputLabel}: ${step.inputValue}',
                      style: pw.TextStyle(fontSize: 9, color: green),
                    ),
                  ),
                if (step.hasPhoto)
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(top: 2),
                    child: pw.Text(
                      '${step.photoCount} photo(s) captured',
                      style: const pw.TextStyle(fontSize: 9, color: PdfColors.blue700),
                    ),
                  ),
                if (step.needsPhoto)
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(top: 2),
                    child: pw.Text(
                      '⚠ Photo required but not captured',
                      style: pw.TextStyle(fontSize: 9, color: red),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildInputSummary(List<StepEntity> steps, PdfColor redColor) {
    final inputSteps = steps.where((s) => s.hasInput && s.inputValue.isNotEmpty).toList();
    if (inputSteps.isEmpty) return pw.SizedBox();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Divider(color: PdfColors.grey300),
        pw.SizedBox(height: 8),
        pw.Text(
          'Recorded Values Summary',
          style: pw.TextStyle(
            fontSize: 14,
            fontWeight: pw.FontWeight.bold,
            color: redColor,
          ),
        ),
        pw.SizedBox(height: 8),
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
          columnWidths: {
            0: const pw.FlexColumnWidth(2),
            1: const pw.FlexColumnWidth(3),
          },
          children: [
            pw.TableRow(
              decoration: const pw.BoxDecoration(color: PdfColors.grey200),
              children: [
                pw.Padding(
                  padding: const pw.EdgeInsets.all(6),
                  child: pw.Text('Field',
                      style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(6),
                  child: pw.Text('Value',
                      style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
                ),
              ],
            ),
            ...inputSteps.map(
              (s) => pw.TableRow(children: [
                pw.Padding(
                  padding: const pw.EdgeInsets.all(6),
                  child: pw.Text(
                      s.inputLabel.isNotEmpty ? s.inputLabel : s.title,
                      style: const pw.TextStyle(fontSize: 9)),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(6),
                  child: pw.Text(s.inputValue,
                      style: const pw.TextStyle(fontSize: 9)),
                ),
              ]),
            ),
          ],
        ),
      ],
    );
  }

  static String _formatDate(DateTime d) {
    final months = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${months[d.month]} ${d.day}, ${d.year}';
  }
}
