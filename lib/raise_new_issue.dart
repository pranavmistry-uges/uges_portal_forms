import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:uges_portal_forms/core/utils/local_storage_service.dart';

class RaiseNewIssueScreen extends StatefulWidget {
  const RaiseNewIssueScreen({super.key});

  @override
  State<RaiseNewIssueScreen> createState() => _RaiseNewIssueScreenState();
}

class _RaiseNewIssueScreenState extends State<RaiseNewIssueScreen> {
  final _formKey = GlobalKey<FormState>();

  // 1. Location Details States
  String? _selectedProject;
  String? _selectedWindfarm;
  String? _selectedCluster;
  String? _selectedTurbine;

  // 2. Issue Classification States
  String? _issueType; // Radio button state
  String? _processType;
  String? _activity;
  DateTime? _observationDate;
  final TextEditingController _notesCtrl = TextEditingController();

  // 3. Evidence & Resolution States
  String? _photoName;

  @override
  void dispose() {
    _notesCtrl.dispose();
    super.dispose();
  }

  // --- Actions ---

  void _resetForm() {
    _formKey.currentState?.reset();
    _notesCtrl.clear();

    setState(() {
      _selectedProject = null;
      _selectedWindfarm = null;
      _selectedCluster = null;
      _selectedTurbine = null;
      _issueType = null;
      _processType = null;
      _activity = null;
      _observationDate = null;
      _photoName = null;
    });
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      final formData = {
        "project": _selectedProject,
        "windfarm": _selectedWindfarm,
        "cluster": _selectedCluster,
        "turbine": _selectedTurbine,
        "issueType": _issueType,
        "processType": _processType,
        "activity": _activity,
        "observationDate": _observationDate?.toIso8601String(),
        "detailsNotes": _notesCtrl.text,
      };

      String jsonData = jsonEncode(formData);

      await LocalStorageService.saveFormData(runtimeType.toString(), jsonData);

      print(jsonData);

      if (_issueType == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Please select an Issue Classification (Safety or Quality)',
            ),
          ),
        );
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('SQ record submitted successfully!')),
      );
      // Automatically reset the form after successful submission
      _resetForm();
    }
  }

  Future<void> _pickPhoto() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png'],
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _photoName = result.files.single.name;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Failed to pick photo')));
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _observationDate = picked;
      });
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Select Date';
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  // --- UI Builder ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Raise new issue',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- SECTION 1 ---
              const Text(
                '1. Location details',
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildFormDropdown(
                'Project',
                ['Project A', 'Project B'],
                _selectedProject,
                (val) => setState(() => _selectedProject = val),
              ),
              const SizedBox(height: 12),
              _buildFormDropdown(
                'Windfarm',
                ['Windfarm North', 'Windfarm South'],
                _selectedWindfarm,
                (val) => setState(() => _selectedWindfarm = val),
              ),
              const SizedBox(height: 12),
              _buildFormDropdown(
                'Cluster',
                ['Cluster 1', 'Cluster 2'],
                _selectedCluster,
                (val) => setState(() => _selectedCluster = val),
              ),
              const SizedBox(height: 12),
              _buildFormDropdown(
                'Specific Turbine',
                ['T-01', 'T-02', 'T-03'],
                _selectedTurbine,
                (val) => setState(() => _selectedTurbine = val),
              ),

              const SizedBox(height: 32),

              // --- SECTION 2 ---
              const Text(
                '2. Issue Classification',
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Radio Buttons for Safety/Quality
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Safety'),
                      value: 'Safety',
                      groupValue: _issueType,
                      onChanged: (val) => setState(() => _issueType = val),
                      contentPadding: EdgeInsets.zero,
                      activeColor: Colors.blue,
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Quality'),
                      value: 'Quality',
                      groupValue: _issueType,
                      onChanged: (val) => setState(() => _issueType = val),
                      contentPadding: EdgeInsets.zero,
                      activeColor: Colors.blue,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              _buildFormDropdown(
                'Process type',
                ['Installation', 'Maintenance', 'Transportation'],
                _processType,
                (val) => setState(() => _processType = val),
              ),
              const SizedBox(height: 12),
              _buildFormDropdown(
                'Activity',
                [
                  'Tower Lifting',
                  'Nacelle Mounting',
                  'Blade Attachment',
                  'General',
                ],
                _activity,
                (val) => setState(() => _activity = val),
              ),
              const SizedBox(height: 12),

              _buildDateField(
                'Observation date',
                _observationDate,
                () => _selectDate(context),
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _notesCtrl,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Detailed observation notes',
                  alignLabelWithHint: true,
                  border: const OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                ),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Required' : null,
              ),

              const SizedBox(height: 32),

              // --- Section 3 ---
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade800,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildFormDropdown(
    String label,
    List<String> items,
    String? value,
    ValueChanged<String?> onChanged,
  ) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),
      initialValue: value,
      validator: (val) => val == null ? 'Required' : null,
      items: items
          .map((i) => DropdownMenuItem(value: i, child: Text(i)))
          .toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildDateField(String label, DateTime? date, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          filled: true,
          fillColor: Colors.grey.shade50,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _formatDate(date),
              style: TextStyle(
                color: date == null ? Colors.grey.shade700 : Colors.black87,
              ),
            ),
            const Icon(Icons.calendar_today, color: Colors.blue, size: 20),
          ],
        ),
      ),
    );
  }
}
