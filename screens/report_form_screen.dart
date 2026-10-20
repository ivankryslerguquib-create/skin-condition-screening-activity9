import 'package:flutter/material.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';

enum ReportUiState {
  idle,
  loading,
  success,
  empty,
  error,
}

class ReportFormScreen extends StatefulWidget {
  const ReportFormScreen({super.key});

  @override
  State<ReportFormScreen> createState() =>
      _ReportFormScreenState();
}

class _ReportFormScreenState extends State<ReportFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  String _category = 'Skin irritation';
  ReportUiState _state = ReportUiState.idle;
  bool _simulateError = false;
  String _submittedTitle = '';

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  String? _validateTitle(String? value) {
    final title = value?.trim() ?? '';

    if (title.isEmpty) {
      return 'Report title is required.';
    }

    if (title.length < 3) {
      return 'Enter at least 3 characters.';
    }

    return null;
  }

  String? _validateDescription(String? value) {
    final description = value?.trim() ?? '';

    if (description.isEmpty) {
      return 'Description is required.';
    }

    if (description.length < 10) {
      return 'Enter at least 10 characters.';
    }

    return null;
  }

  Future<void> _submitReport() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _state = ReportUiState.loading;
    });

    try {
      // Simulates a pending API request for Activity 9.
      await Future<void>.delayed(
        const Duration(seconds: 3),
      );

      if (!mounted) return;

      if (_simulateError) {
        throw Exception('Simulated request failure.');
      }

      setState(() {
        _submittedTitle = _titleController.text.trim();
        _state = ReportUiState.success;
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _state = ReportUiState.error;
      });
    }
  }

  void _showEmptyState() {
    setState(() {
      _state = ReportUiState.empty;
    });
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _titleController.clear();
    _descriptionController.clear();

    setState(() {
      _category = 'Skin irritation';
      _state = ReportUiState.idle;
      _simulateError = false;
    });
  }

  Widget _buildStateMessage() {
    switch (_state) {
      case ReportUiState.idle:
        return const SizedBox.shrink();

      case ReportUiState.loading:
        return _stateCard(
          color: Colors.blue,
          icon: Icons.hourglass_top,
          title: 'Loading...',
          message: 'Submitting your report. Please wait.',
        );

      case ReportUiState.success:
        return _stateCard(
          color: Colors.green,
          icon: Icons.check_circle_outline,
          title: 'Report Submitted Successfully',
          message:
              'The demo accepted "$_submittedTitle". '
              'No database record was saved.',
          action: TextButton(
            onPressed: _resetForm,
            child: const Text('Create Another Report'),
          ),
        );

      case ReportUiState.empty:
        return _stateCard(
          color: Colors.blueGrey,
          icon: Icons.inbox_outlined,
          title: 'No Reports Available',
          message:
              'There are currently no saved reports in this demo.',
          action: TextButton(
            onPressed: () {
              setState(() {
                _state = ReportUiState.idle;
              });
            },
            child: const Text('Create First Report'),
          ),
        );

      case ReportUiState.error:
        return _stateCard(
          color: Colors.red,
          icon: Icons.error_outline,
          title: 'Unable to Submit Report',
          message:
              'The simulated request failed. You can retry '
              'after turning off the error simulation.',
          action: TextButton(
            onPressed: () {
              setState(() {
                _simulateError = false;
                _state = ReportUiState.idle;
              });
              _submitReport();
            },
            child: const Text('Retry Submission'),
          ),
        );
    }
  }

  Widget _stateCard({
    required Color color,
    required IconData icon,
    required String title,
    required String message,
    Widget? action,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 18),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        border: Border.all(
          color: color.withOpacity(0.4),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(message),
          if (action != null)
            Align(
              alignment: Alignment.centerLeft,
              child: action,
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = _state == ReportUiState.loading;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Skin Screening Report'),
        backgroundColor: const Color(0xFF167D68),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              const Icon(
                Icons.health_and_safety_outlined,
                size: 48,
                color: Color(0xFF167D68),
              ),
              const SizedBox(height: 10),
              const Text(
                'Report a Skin Concern',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF17594D),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Describe your concern for preliminary screening. '
                'This educational demo does not diagnose skin conditions.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextField(
                      controller: _titleController,
                      label: 'Report Title',
                      hint: 'Example: Dry patch on arm',
                      prefixIcon: Icons.edit_note,
                      validator: _validateTitle,
                    ),
                    const SizedBox(height: 16),

                    DropdownButtonFormField<String>(
                      value: _category,
                      decoration: InputDecoration(
                        labelText: 'Concern Category',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'Skin irritation',
                          child: Text('Skin irritation'),
                        ),
                        DropdownMenuItem(
                          value: 'Rash or redness',
                          child: Text('Rash or redness'),
                        ),
                        DropdownMenuItem(
                          value: 'Acne-like concern',
                          child: Text('Acne-like concern'),
                        ),
                        DropdownMenuItem(
                          value: 'Other concern',
                          child: Text('Other concern'),
                        ),
                      ],
                      onChanged: isLoading
                          ? null
                          : (value) {
                              if (value != null) {
                                setState(() {
                                  _category = value;
                                });
                              }
                            },
                    ),
                    const SizedBox(height: 16),

                    AppTextField(
                      controller: _descriptionController,
                      label: 'Description and Symptoms',
                      hint: 'Describe the concern and symptoms',
                      prefixIcon: Icons.notes,
                      maxLines: 4,
                      validator: _validateDescription,
                    ),
                    const SizedBox(height: 16),

                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Simulate an error'),
                      subtitle: const Text(
                        'Enable this to demonstrate the Error state.',
                      ),
                      value: _simulateError,
                      onChanged: isLoading
                          ? null
                          : (value) {
                              setState(() {
                                _simulateError = value;
                              });
                            },
                    ),
                    const SizedBox(height: 12),

                    AppButton(
                      label: 'Submit Report',
                      icon: Icons.send,
                      isLoading: isLoading,
                      onPressed:
                          isLoading ? null : _submitReport,
                    ),
                    const SizedBox(height: 8),

                    OutlinedButton.icon(
                      onPressed:
                          isLoading ? null : _showEmptyState,
                      icon: const Icon(Icons.inbox_outlined),
                      label: const Text(
                        'Preview Empty Report List',
                      ),
                    ),

                    _buildStateMessage(),

                    const SizedBox(height: 20),
                    const Text(
                      'Activity 9 demo: requests and responses are '
                      'simulated. No real image upload, medical '
                      'analysis, API request, or database save occurs.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}