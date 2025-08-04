import 'dart:typed_data';

import 'package:pdf/widgets.dart' as pw;

import '../models/event.dart';
import '../models/task.dart';
import '../models/user.dart';
import 'analytics_service.dart';

/// Generates statistics and PDF reports for administrators.
class ReportService {
  /// Builds a simple PDF report summarizing [tasks] and [events].
  Future<Uint8List> generatePdf(
      {required List<Task> tasks, required List<Event> events}) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Tasks', style: pw.TextStyle(fontSize: 18)),
            ...tasks.map((t) => pw.Text('- ${t.description}')),
            pw.SizedBox(height: 20),
            pw.Text('Events', style: pw.TextStyle(fontSize: 18)),
            ...events.map((e) => pw.Text('- ${e.title}')),
          ],
        ),
      ),
    );
    return pdf.save();
  }

  /// Builds a PDF summarizing user role distribution.
  Future<Uint8List> generateUserStatsPdf(List<User> users) async {
    final stats = AnalyticsService().buildUserStats(users);
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('User Statistics', style: pw.TextStyle(fontSize: 18)),
            pw.Text('Total users: ${stats.totalUsers}'),
            pw.Text('Admins: ${stats.adminCount}'),
            pw.Text('Leaders: ${stats.leaderCount}'),
            pw.Text('Assistants: ${stats.assistantCount}'),
          ],
        ),
      ),
    );
    return pdf.save();
  }
}
