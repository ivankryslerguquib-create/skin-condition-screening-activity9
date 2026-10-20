import '../models/skin_report.dart';

class ReportService {
  Future<SkinReport> submitReport(
    SkinReport report, {
    bool simulateError = false,
  }) async {
    // Simulate a network request.
    await Future<void>.delayed(
      const Duration(seconds: 3),
    );

    if (simulateError) {
      throw Exception('Unable to submit report.');
    }

    // Demo only: returns the report without saving it.
    return report;
  }

  Future<List<SkinReport>> getReports() async {
    // Demo only: no records have been loaded.
    await Future<void>.delayed(
      const Duration(seconds: 1),
    );

    return [];
  }
}