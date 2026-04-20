import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class NacelleInstallationScreen extends StatefulWidget {
  const NacelleInstallationScreen({super.key});

  @override
  State<NacelleInstallationScreen> createState() => _NacelleInstallationScreenState();
}

class _NacelleInstallationScreenState extends State<NacelleInstallationScreen> {
  // Top Dropdowns
  String? _selectedProject;
  String? _selectedWindfarm;
  String? _selectedCluster;

  // Form Key for validation
  final _formKey = GlobalKey<FormState>();

  // Dropdown States
  String? _nacelleId;
  String? _turbine;
  String? _generatorId;
  String? _gearBoxId;
  String? _liftId;
  String? _boltId;
  String? _contractor;
  String? _supervisor;
  String? _weather;
  String? _status;

  // Text Controllers
  final TextEditingController _boltsCtrl = TextEditingController();
  final TextEditingController _torqueCtrl = TextEditingController();
  final TextEditingController _instrumentCtrl = TextEditingController();
  final TextEditingController _slewingRimCtrl = TextEditingController();
  final TextEditingController _yawDriveCtrl = TextEditingController();
  final TextEditingController _alignmentCtrl = TextEditingController();

  // Date States
  DateTime? _liftingStart;
  DateTime? _liftingEnd;

  // File Upload and Checkbox States
  String? _documentName;
  bool _isVerified = false;

  @override
  void dispose() {
    _boltsCtrl.dispose();
    _torqueCtrl.dispose();
    _instrumentCtrl.dispose();
    _slewingRimCtrl.dispose();
    _yawDriveCtrl.dispose();
    _alignmentCtrl.dispose();
    super.dispose();
  }

  // --- Actions ---

  void _resetForm() {
    _formKey.currentState?.reset();
    _boltsCtrl.clear();
    _torqueCtrl.clear();
    _instrumentCtrl.clear();
    _slewingRimCtrl.clear();
    _yawDriveCtrl.clear();
    _alignmentCtrl.clear();

    setState(() {
      _nacelleId = null;
      _turbine = null;
      _generatorId = null;
      _gearBoxId = null;
      _liftId = null;
      _boltId = null;
      _contractor = null;
      _supervisor = null;
      _weather = null;
      _status = null;
      _liftingStart = null;
      _liftingEnd = null;
      _documentName = null;
      _isVerified = false;
    });
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nacelle Installation data submitted successfully!')),
      );
      // Automatically reset the form after successful submission
      _resetForm();
    }
  }

  Future<void> _pickDocument() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'png', 'xls', 'xlsx'],
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _documentName = result.files.single.name;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to pick document')),
        );
      }
    }
  }

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _liftingStart = picked;
        } else {
          _liftingEnd = picked;
        }
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
        title: const Text('Nacelle Installation', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top Main Selection Dropdowns
            _buildDropdown('Project', ['Project A', 'Project B'], _selectedProject, (val) => setState(() => _selectedProject = val)),
            const SizedBox(height: 12),
            _buildDropdown('Windfarm', ['Windfarm North', 'Windfarm South'], _selectedWindfarm, (val) => setState(() => _selectedWindfarm = val)),
            const SizedBox(height: 12),
            _buildDropdown('Clusters', ['Cluster 1', 'Cluster 2'], _selectedCluster, (val) => setState(() => _selectedCluster = val)),

            const Divider(height: 40, thickness: 1),

            // Show Form conditionally
            if (_selectedProject != null && _selectedWindfarm != null && _selectedCluster != null) ...[
              const Text(
                'Nacelle Installation form',
                style: TextStyle(color: Colors.lightBlue, fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildFormDropdown('Nacelle ID', ['N-101', 'N-102', 'N-103'], _nacelleId, (v) => setState(() => _nacelleId = v)),
                    const SizedBox(height: 16),
                    _buildFormDropdown('Turbine', ['T-01', 'T-02', 'T-03'], _turbine, (v) => setState(() => _turbine = v)),
                    const SizedBox(height: 16),
                    _buildFormDropdown('Generator ID', ['G-01', 'G-02', 'G-03'], _generatorId, (v) => setState(() => _generatorId = v)),
                    const SizedBox(height: 16),
                    _buildFormDropdown('Gear Box ID', ['GB-01', 'GB-02', 'GB-03'], _gearBoxId, (v) => setState(() => _gearBoxId = v)),
                    const SizedBox(height: 16),
                    _buildFormDropdown('Lift ID', ['L-01', 'L-02'], _liftId, (v) => setState(() => _liftId = v)),
                    const SizedBox(height: 16),
                    _buildFormDropdown('Bolt ID', ['B-01', 'B-02', 'B-03'], _boltId, (v) => setState(() => _boltId = v)),
                    const SizedBox(height: 16),

                    _buildTextField('No. of Bolts', _boltsCtrl, isNumber: true),
                    const SizedBox(height: 16),
                    _buildTextField('Torque Value', _torqueCtrl, isNumber: true),
                    const SizedBox(height: 16),
                    _buildTextField('Instrument Used', _instrumentCtrl),
                    const SizedBox(height: 16),
                    _buildTextField('Slewing Rim', _slewingRimCtrl),
                    const SizedBox(height: 16),
                    _buildTextField('Yaw Drive Details', _yawDriveCtrl),
                    const SizedBox(height: 16),
                    _buildTextField('Alignment Check', _alignmentCtrl),
                    const SizedBox(height: 16),

                    // Date Pickers
                    _buildDateField('Lifting Start', _liftingStart, () => _selectDate(context, true)),
                    const SizedBox(height: 16),
                    _buildDateField('Lifting End', _liftingEnd, () => _selectDate(context, false)),
                    const SizedBox(height: 16),

                    _buildFormDropdown('Contractor', ['Contractor X', 'Contractor Y'], _contractor, (v) => setState(() => _contractor = v)),
                    const SizedBox(height: 16),
                    _buildFormDropdown('Supervisor', ['Supervisor 1', 'Supervisor 2'], _supervisor, (v) => setState(() => _supervisor = v)),
                    const SizedBox(height: 16),
                    _buildFormDropdown('Weather', ['Sunny', 'Cloudy', 'Rainy', 'Windy'], _weather, (v) => setState(() => _weather = v)),
                    const SizedBox(height: 16),
                    _buildFormDropdown('Status', ['Pending', 'In Progress', 'Completed'], _status, (v) => setState(() => _status = v)),
                    const SizedBox(height: 24),

                    // Document Upload Section
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.grey.shade50,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              _documentName ?? 'No document selected',
                              style: TextStyle(color: _documentName == null ? Colors.grey : Colors.black87),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton.icon(
                            onPressed: _pickDocument,
                            icon: const Icon(Icons.upload_file, size: 18),
                            label: const Text('Upload Document'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue.shade100,
                              foregroundColor: Colors.blue.shade900,
                              elevation: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Validation Checkbox
                    FormField<bool>(
                      initialValue: _isVerified,
                      validator: (value) {
                        if (value != true) return 'Verification is required to proceed.';
                        return null;
                      },
                      builder: (FormFieldState<bool> state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CheckboxListTile(
                              title: const Text(
                                'Verify mechanical and electrical connections, alignment, and safety checks.',
                                style: TextStyle(fontSize: 14),
                              ),
                              value: state.value,
                              onChanged: (val) {
                                setState(() => _isVerified = val ?? false);
                                state.didChange(val);
                              },
                              controlAffinity: ListTileControlAffinity.leading,
                              contentPadding: EdgeInsets.zero,
                              activeColor: Colors.lightBlue,
                            ),
                            if (state.hasError)
                              Padding(
                                padding: const EdgeInsets.only(left: 32.0, top: 4.0),
                                child: Text(
                                  state.errorText!,
                                  style: const TextStyle(color: Colors.red, fontSize: 12),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 30),

                    // Submit Button
                    ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade800,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Submit nacelle', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildDropdown(String label, List<String> items, String? value, ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
      value: value,
      items: items.map((i) => DropdownMenuItem(value: i, child: Text(i))).toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildFormDropdown(String label, List<String> items, String? value, ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),
      value: value,
      validator: (val) => val == null ? 'Required' : null,
      items: items.map((i) => DropdownMenuItem(value: i, child: Text(i))).toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool isNumber = false}) {
    return TextFormField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),
      validator: (val) => val == null || val.isEmpty ? 'Required' : null,
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
              style: TextStyle(color: date == null ? Colors.grey.shade700 : Colors.black87),
            ),
            const Icon(Icons.calendar_today, color: Colors.blue, size: 20),
          ],
        ),
      ),
    );
  }
}