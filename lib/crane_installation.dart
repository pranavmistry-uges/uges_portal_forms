import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class CraneInstallationScreen extends StatefulWidget {
  const CraneInstallationScreen({super.key});

  @override
  State<CraneInstallationScreen> createState() => _CraneInstallationScreenState();
}

class _CraneInstallationScreenState extends State<CraneInstallationScreen> {
  // Top Dropdowns
  String? _selectedProject;
  String? _selectedWindfarm;
  String? _selectedCluster;

  // Form Key and Controllers
  final _formKey = GlobalKey<FormState>();

  // Form Fields State
  String? _turbineLocation;
  final TextEditingController _platformNameCtrl = TextEditingController();
  String? _platformType;
  final TextEditingController _lengthCtrl = TextEditingController();
  final TextEditingController _widthCtrl = TextEditingController();
  final TextEditingController _depthCtrl = TextEditingController();
  String? _craneModel;
  final TextEditingController _distanceCtrl = TextEditingController();
  String? _contractor;
  String? _activityStatus;

  // Mock File Attachments
  String? _fddFileName;
  String? _mddFileName;

  bool _drainageProvided = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _platformNameCtrl.dispose();
    _lengthCtrl.dispose();
    _widthCtrl.dispose();
    _depthCtrl.dispose();
    _distanceCtrl.dispose();
    super.dispose();
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _platformNameCtrl.clear();
    _lengthCtrl.clear();
    _widthCtrl.clear();
    _depthCtrl.clear();
    _distanceCtrl.clear();
    setState(() {
      _turbineLocation = null;
      _platformType = null;
      _craneModel = null;
      _contractor = null;
      _activityStatus = null;
      _fddFileName = null;
      _mddFileName = null;
      _drainageProvided = false;
    });
  }

  void _savePlatform() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Platform data saved successfully!')),
      );
      _resetForm();
    }
  }

  // Helper for actual file picking using file_explorer
  Future<void> _pickFile(bool isFDD) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        // Allowing common document formats
        allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'png', 'xls', 'xlsx'],
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          if (isFDD) {
            _fddFileName = result.files.single.name;
          } else {
            _mddFileName = result.files.single.name;
          }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Crane Installation', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Colors.blue, width: 2),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Platform Master', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 13)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Colors.purple, width: 2),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Platform DPR', style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold, fontSize: 13)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Main Selection Dropdowns (Stacked vertically for mobile)
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildDropdown('Project', ['Project A', 'Project B'], _selectedProject, (val) => setState(() => _selectedProject = val)),
                const SizedBox(height: 12),
                _buildDropdown('Windfarm', ['Windfarm North', 'Windfarm South'], _selectedWindfarm, (val) => setState(() => _selectedWindfarm = val)),
                const SizedBox(height: 12),
                _buildDropdown('Cluster', ['Cluster 1', 'Cluster 2'], _selectedCluster, (val) => setState(() => _selectedCluster = val)),
              ],
            ),

            const Divider(height: 40, thickness: 1),

            // Show Form only if all top dropdowns are selected
            if (_selectedProject != null && _selectedWindfarm != null && _selectedCluster != null) ...[
              const Text(
                'Platform Master',
                style: TextStyle(color: Colors.blue, fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              Form(
                key: _formKey,
                child: Column( // Using Column instead of Wrap for standard mobile scrolling form
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildFormDropdown('Turbine Location', ['Loc 1', 'Loc 2', 'Loc 3'], _turbineLocation, (v) => setState(() => _turbineLocation = v)),
                    const SizedBox(height: 16),
                    _buildTextField('Platform Name', _platformNameCtrl),
                    const SizedBox(height: 16),
                    _buildFormDropdown('Platform Type', ['Hardstand', 'Crane Pad', 'Temporary'], _platformType, (v) => setState(() => _platformType = v)),
                    const SizedBox(height: 16),
                    _buildTextField('Platform Length (m)', _lengthCtrl, isNumber: true),
                    const SizedBox(height: 16),
                    _buildTextField('Platform Width (m)', _widthCtrl, isNumber: true),
                    const SizedBox(height: 16),
                    _buildTextField('Platform Depth (m)', _depthCtrl, isNumber: true),
                    const SizedBox(height: 16),
                    _buildFormDropdown('Crane Model & Capacity', ['Model X - 500t', 'Model Y - 750t', 'Model Z - 1000t'], _craneModel, (v) => setState(() => _craneModel = v)),
                    const SizedBox(height: 16),
                    _buildTextField('Dist. from foundation center (m)', _distanceCtrl, isNumber: true),
                    const SizedBox(height: 16),
                    _buildFormDropdown('Contractor', ['Contractor A', 'Contractor B'], _contractor, (v) => setState(() => _contractor = v)),
                    const SizedBox(height: 16),
                    _buildFormDropdown('Activity Status', ['Planned', 'In progress', 'Completed'], _activityStatus, (v) => setState(() => _activityStatus = v)),
                    const SizedBox(height: 16),

                    // File Pickers
                    _buildFilePicker('FDD Attachment', _fddFileName, () => _pickFile(true)),
                    const SizedBox(height: 16),
                    _buildFilePicker('MDD Attachment', _mddFileName, () => _pickFile(false)),
                    const SizedBox(height: 16),

                    // Checkbox
                    FormField<bool>(
                      initialValue: _drainageProvided,
                      validator: (value) {
                        if (value != true) {
                          return 'You must confirm drainage is provided';
                        }
                        return null;
                      },
                      builder: (FormFieldState<bool> state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CheckboxListTile(
                              title: const Text('Drainage Provided'),
                              value: state.value,
                              onChanged: (val) {
                                setState(() => _drainageProvided = val ?? false);
                                state.didChange(val);
                              },
                              controlAffinity: ListTileControlAffinity.leading,
                              contentPadding: EdgeInsets.zero,
                              activeColor: Colors.blue,
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
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Action Buttons stacked for mobile view
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: _savePlatform,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade800,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Save Platform', style: TextStyle(fontSize: 16)),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: _resetForm,
                    style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                    child: const Text('Reset', style: TextStyle(color: Colors.grey, fontSize: 16)),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  // UI Helpers updated for full mobile width
  Widget _buildDropdown(String label, List<String> items, String? value, ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
      initialValue: value,
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
      initialValue: value,
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

  Widget _buildFilePicker(String label, String? fileName, VoidCallback onPick) {
    return InkWell(
      onTap: onPick,
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
            Expanded(
              child: Text(
                fileName ?? 'Choose file...',
                style: TextStyle(color: fileName == null ? Colors.grey : Colors.black87),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(Icons.upload_file, color: Colors.blue),
          ],
        ),
      ),
    );
  }
}