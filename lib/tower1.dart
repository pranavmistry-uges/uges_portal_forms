import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class Tower1Screen extends StatefulWidget {
  const Tower1Screen({super.key});

  @override
  State<Tower1Screen> createState() => _Tower1ScreenState();
}

class _Tower1ScreenState extends State<Tower1Screen> {
  // Top Dropdowns
  String? _selectedProject;
  String? _selectedWindfarm;
  String? _selectedCluster;

  // Form Key for validation
  final _formKey = GlobalKey<FormState>();

  // Dropdown States
  String? _turbine;
  String? _contractor;
  String? _supervisor;
  String? _weather;
  String? _status;

  // Text Controllers
  final TextEditingController _levelingCtrl = TextEditingController();
  final TextEditingController _alignmentCtrl = TextEditingController();
  final TextEditingController _boltsCtrl = TextEditingController();
  final TextEditingController _boltSizeCtrl = TextEditingController();
  final TextEditingController _torqueCtrl = TextEditingController();
  final TextEditingController _instrumentCtrl = TextEditingController();
  final TextEditingController _groutingCtrl = TextEditingController();
  final TextEditingController _groutingCuringCtrl = TextEditingController();
  final TextEditingController _groutMaterialCtrl = TextEditingController();
  final TextEditingController _batchNoCtrl = TextEditingController();
  final TextEditingController _curingDaysCtrl = TextEditingController();
  final TextEditingController _remarksCtrl = TextEditingController();

  // Date States
  DateTime? _liftingStart;
  DateTime? _liftingEnd;

  // File Upload and Checkbox States
  String? _documentName;
  bool _isVerified = false;

  @override
  void dispose() {
    _levelingCtrl.dispose();
    _alignmentCtrl.dispose();
    _boltsCtrl.dispose();
    _boltSizeCtrl.dispose();
    _torqueCtrl.dispose();
    _instrumentCtrl.dispose();
    _groutingCtrl.dispose();
    _groutingCuringCtrl.dispose();
    _groutMaterialCtrl.dispose();
    _batchNoCtrl.dispose();
    _curingDaysCtrl.dispose();
    _remarksCtrl.dispose();
    super.dispose();
  }

  // --- Actions ---

  void _resetForm() {
    _formKey.currentState?.reset();
    _levelingCtrl.clear();
    _alignmentCtrl.clear();
    _boltsCtrl.clear();
    _boltSizeCtrl.clear();
    _torqueCtrl.clear();
    _instrumentCtrl.clear();
    _groutingCtrl.clear();
    _groutingCuringCtrl.clear();
    _groutMaterialCtrl.clear();
    _batchNoCtrl.clear();
    _curingDaysCtrl.clear();
    _remarksCtrl.clear();

    setState(() {
      _turbine = null;
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
        const SnackBar(content: Text('Tower1 Installation data submitted successfully!')),
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
        title: const Text('Tower1', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
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
            _buildDropdown('Cluster', ['Cluster 1', 'Cluster 2'], _selectedCluster, (val) => setState(() => _selectedCluster = val)),

            const Divider(height: 40, thickness: 1),

            // Show Form conditionally
            if (_selectedProject != null && _selectedWindfarm != null && _selectedCluster != null) ...[
              const Text(
                'T1 Installation Details',
                style: TextStyle(color: Colors.lightBlue, fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildFormDropdown('Turbine', ['T-01', 'T-02', 'T-03'], _turbine, (v) => setState(() => _turbine = v)),
                    const SizedBox(height: 16),
                    _buildFormDropdown('Contractor', ['Contractor X', 'Contractor Y'], _contractor, (v) => setState(() => _contractor = v)),
                    const SizedBox(height: 16),
                    _buildFormDropdown('Supervisor', ['John Doe', 'Jane Smith'], _supervisor, (v) => setState(() => _supervisor = v)),
                    const SizedBox(height: 16),
                    _buildTextField('Leveling', _levelingCtrl),
                    const SizedBox(height: 16),
                    _buildTextField('Alignment Check', _alignmentCtrl),
                    const SizedBox(height: 16),
                    _buildTextField('No. of Bolts', _boltsCtrl, isNumber: true),
                    const SizedBox(height: 16),
                    _buildTextField('Bolt Size', _boltSizeCtrl),
                    const SizedBox(height: 16),
                    _buildTextField('Torque Value', _torqueCtrl, isNumber: true),
                    const SizedBox(height: 16),
                    _buildTextField('Instrument Used', _instrumentCtrl),
                    const SizedBox(height: 16),
                    _buildTextField('Grouting', _groutingCtrl),
                    const SizedBox(height: 16),
                    _buildTextField('Grouting Curing', _groutingCuringCtrl),
                    const SizedBox(height: 16),
                    _buildTextField('Grout Material Type', _groutMaterialCtrl),
                    const SizedBox(height: 16),
                    _buildTextField('Batch No.', _batchNoCtrl),
                    const SizedBox(height: 16),
                    _buildTextField('Grouting Curing Days', _curingDaysCtrl, isNumber: true),
                    const SizedBox(height: 16),

                    // Date Pickers
                    _buildDateField('Lifting Start', _liftingStart, () => _selectDate(context, true)),
                    const SizedBox(height: 16),
                    _buildDateField('Lifting End', _liftingEnd, () => _selectDate(context, false)),
                    const SizedBox(height: 16),

                    _buildFormDropdown('Weather Condition', ['Sunny', 'Cloudy', 'Rainy', 'Windy'], _weather, (v) => setState(() => _weather = v)),
                    const SizedBox(height: 16),
                    _buildFormDropdown('Status', ['Pending', 'In Progress', 'Completed'], _status, (v) => setState(() => _status = v)),
                    const SizedBox(height: 16),

                    // Textarea
                    TextFormField(
                      controller: _remarksCtrl,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Remarks',
                        alignLabelWithHint: true,
                        border: const OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.grey.shade50,
                      ),
                    ),
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
                            label: const Text('Upload Documents'),
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
                        if (value != true) return 'This verification is required to proceed.';
                        return null;
                      },
                      builder: (FormFieldState<bool> state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CheckboxListTile(
                              title: const Text(
                                'Ensure alignment, bolt tightening, and base readiness are verified before proceeding.',
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
                      child: const Text('Submit Tower1', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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

// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
//
// class Tower1Screen extends StatefulWidget {
//   const Tower1Screen({super.key});
//
//   @override
//   State<Tower1Screen> createState() => _Tower1ScreenState();
// }
//
// class _Tower1ScreenState extends State<Tower1Screen> {
//   // Top Dropdowns
//   String? _selectedProject;
//   String? _selectedWindfarm;
//   String? _selectedCluster;
//
//   // Form Key for validation
//   final _formKey = GlobalKey<FormState>();
//
//   // Dropdown States
//   String? _turbine;
//   String? _contractor;
//   String? _supervisor;
//   String? _weather;
//   String? _status;
//
//   // Text Controllers
//   final TextEditingController _levelingCtrl = TextEditingController();
//   final TextEditingController _alignmentCtrl = TextEditingController();
//   final TextEditingController _boltsCtrl = TextEditingController();
//   final TextEditingController _boltSizeCtrl = TextEditingController();
//   final TextEditingController _torqueCtrl = TextEditingController();
//   final TextEditingController _instrumentCtrl = TextEditingController();
//   final TextEditingController _groutingCtrl = TextEditingController();
//   final TextEditingController _groutingCuringCtrl = TextEditingController();
//   final TextEditingController _groutMaterialCtrl = TextEditingController();
//   final TextEditingController _batchNoCtrl = TextEditingController();
//   final TextEditingController _curingDaysCtrl = TextEditingController();
//   final TextEditingController _remarksCtrl = TextEditingController();
//
//   // Date States
//   DateTime? _liftingStart;
//   DateTime? _liftingEnd;
//
//   // File Upload and Checkbox States
//   String? _documentName;
//   bool _isVerified = false;
//
//   @override
//   void dispose() {
//     _levelingCtrl.dispose();
//     _alignmentCtrl.dispose();
//     _boltsCtrl.dispose();
//     _boltSizeCtrl.dispose();
//     _torqueCtrl.dispose();
//     _instrumentCtrl.dispose();
//     _groutingCtrl.dispose();
//     _groutingCuringCtrl.dispose();
//     _groutMaterialCtrl.dispose();
//     _batchNoCtrl.dispose();
//     _curingDaysCtrl.dispose();
//     _remarksCtrl.dispose();
//     super.dispose();
//   }
//
//   // --- Actions ---
//
//   void _submitForm() {
//     if (_formKey.currentState?.validate() ?? false) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Tower1 Installation data submitted successfully!')),
//       );
//     }
//   }
//
//   Future<void> _pickDocument() async {
//     try {
//       FilePickerResult? result = await FilePicker.platform.pickFiles(
//         type: FileType.custom,
//         allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'png', 'xls', 'xlsx'],
//       );
//
//       if (result != null && result.files.isNotEmpty) {
//         setState(() {
//           _documentName = result.files.single.name;
//         });
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Failed to pick document')),
//         );
//       }
//     }
//   }
//
//   Future<void> _selectDate(BuildContext context, bool isStart) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null) {
//       setState(() {
//         if (isStart) {
//           _liftingStart = picked;
//         } else {
//           _liftingEnd = picked;
//         }
//       });
//     }
//   }
//
//   String _formatDate(DateTime? date) {
//     if (date == null) return 'Select Date';
//     return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
//   }
//
//   // --- UI Builder ---
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text('Tower1', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
//         backgroundColor: Colors.blue.shade800,
//         foregroundColor: Colors.white,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // Top Main Selection Dropdowns
//             _buildDropdown('Project', ['Project A', 'Project B'], _selectedProject, (val) => setState(() => _selectedProject = val)),
//             const SizedBox(height: 12),
//             _buildDropdown('Windfarm', ['Windfarm North', 'Windfarm South'], _selectedWindfarm, (val) => setState(() => _selectedWindfarm = val)),
//             const SizedBox(height: 12),
//             _buildDropdown('Cluster', ['Cluster 1', 'Cluster 2'], _selectedCluster, (val) => setState(() => _selectedCluster = val)),
//
//             const Divider(height: 40, thickness: 1),
//
//             // Show Form conditionally
//             if (_selectedProject != null && _selectedWindfarm != null && _selectedCluster != null) ...[
//               const Text(
//                 'T1 Installation Details',
//                 style: TextStyle(color: Colors.lightBlue, fontSize: 22, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 20),
//
//               Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     _buildFormDropdown('Turbine', ['T-01', 'T-02', 'T-03'], _turbine, (v) => setState(() => _turbine = v)),
//                     const SizedBox(height: 16),
//                     _buildFormDropdown('Contractor', ['Contractor X', 'Contractor Y'], _contractor, (v) => setState(() => _contractor = v)),
//                     const SizedBox(height: 16),
//                     _buildFormDropdown('Supervisor', ['John Doe', 'Jane Smith'], _supervisor, (v) => setState(() => _supervisor = v)),
//                     const SizedBox(height: 16),
//                     _buildTextField('Leveling', _levelingCtrl),
//                     const SizedBox(height: 16),
//                     _buildTextField('Alignment Check', _alignmentCtrl),
//                     const SizedBox(height: 16),
//                     _buildTextField('No. of Bolts', _boltsCtrl, isNumber: true),
//                     const SizedBox(height: 16),
//                     _buildTextField('Bolt Size', _boltSizeCtrl),
//                     const SizedBox(height: 16),
//                     _buildTextField('Torque Value', _torqueCtrl, isNumber: true),
//                     const SizedBox(height: 16),
//                     _buildTextField('Instrument Used', _instrumentCtrl),
//                     const SizedBox(height: 16),
//                     _buildTextField('Grouting', _groutingCtrl),
//                     const SizedBox(height: 16),
//                     _buildTextField('Grouting Curing', _groutingCuringCtrl),
//                     const SizedBox(height: 16),
//                     _buildTextField('Grout Material Type', _groutMaterialCtrl),
//                     const SizedBox(height: 16),
//                     _buildTextField('Batch No.', _batchNoCtrl),
//                     const SizedBox(height: 16),
//                     _buildTextField('Grouting Curing Days', _curingDaysCtrl, isNumber: true),
//                     const SizedBox(height: 16),
//
//                     // Date Pickers
//                     _buildDateField('Lifting Start', _liftingStart, () => _selectDate(context, true)),
//                     const SizedBox(height: 16),
//                     _buildDateField('Lifting End', _liftingEnd, () => _selectDate(context, false)),
//                     const SizedBox(height: 16),
//
//                     _buildFormDropdown('Weather Condition', ['Sunny', 'Cloudy', 'Rainy', 'Windy'], _weather, (v) => setState(() => _weather = v)),
//                     const SizedBox(height: 16),
//                     _buildFormDropdown('Status', ['Pending', 'In Progress', 'Completed'], _status, (v) => setState(() => _status = v)),
//                     const SizedBox(height: 16),
//
//                     // Textarea
//                     TextFormField(
//                       controller: _remarksCtrl,
//                       maxLines: 3,
//                       decoration: InputDecoration(
//                         labelText: 'Remarks',
//                         alignLabelWithHint: true,
//                         border: const OutlineInputBorder(),
//                         filled: true,
//                         fillColor: Colors.grey.shade50,
//                       ),
//                     ),
//                     const SizedBox(height: 24),
//
//                     // Document Upload Section
//                     Container(
//                       padding: const EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.grey.shade400),
//                         borderRadius: BorderRadius.circular(4),
//                         color: Colors.grey.shade50,
//                       ),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: Text(
//                               _documentName ?? 'No document selected',
//                               style: TextStyle(color: _documentName == null ? Colors.grey : Colors.black87),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                           const SizedBox(width: 8),
//                           ElevatedButton.icon(
//                             onPressed: _pickDocument,
//                             icon: const Icon(Icons.upload_file, size: 18),
//                             label: const Text('Upload Documents'),
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.blue.shade100,
//                               foregroundColor: Colors.blue.shade900,
//                               elevation: 0,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//
//                     // Validation Checkbox
//                     FormField<bool>(
//                       initialValue: _isVerified,
//                       validator: (value) {
//                         if (value != true) return 'This verification is required to proceed.';
//                         return null;
//                       },
//                       builder: (FormFieldState<bool> state) {
//                         return Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             CheckboxListTile(
//                               title: const Text(
//                                 'Ensure alignment, bolt tightening, and base readiness are verified before proceeding.',
//                                 style: TextStyle(fontSize: 14),
//                               ),
//                               value: state.value,
//                               onChanged: (val) {
//                                 setState(() => _isVerified = val ?? false);
//                                 state.didChange(val);
//                               },
//                               controlAffinity: ListTileControlAffinity.leading,
//                               contentPadding: EdgeInsets.zero,
//                               activeColor: Colors.lightBlue,
//                             ),
//                             if (state.hasError)
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 32.0, top: 4.0),
//                                 child: Text(
//                                   state.errorText!,
//                                   style: const TextStyle(color: Colors.red, fontSize: 12),
//                                 ),
//                               ),
//                           ],
//                         );
//                       },
//                     ),
//                     const SizedBox(height: 30),
//
//                     // Submit Button
//                     ElevatedButton(
//                       onPressed: _submitForm,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue.shade800,
//                         foregroundColor: Colors.white,
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                       ),
//                       child: const Text('Submit Tower1', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
//
//   // --- Helper Widgets ---
//
//   Widget _buildDropdown(String label, List<String> items, String? value, ValueChanged<String?> onChanged) {
//     return DropdownButtonFormField<String>(
//       decoration: InputDecoration(
//         labelText: label,
//         border: const OutlineInputBorder(),
//         contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//       ),
//       value: value,
//       items: items.map((i) => DropdownMenuItem(value: i, child: Text(i))).toList(),
//       onChanged: onChanged,
//     );
//   }
//
//   Widget _buildFormDropdown(String label, List<String> items, String? value, ValueChanged<String?> onChanged) {
//     return DropdownButtonFormField<String>(
//       decoration: InputDecoration(
//         labelText: label,
//         border: const OutlineInputBorder(),
//         filled: true,
//         fillColor: Colors.grey.shade50,
//       ),
//       value: value,
//       validator: (val) => val == null ? 'Required' : null,
//       items: items.map((i) => DropdownMenuItem(value: i, child: Text(i))).toList(),
//       onChanged: onChanged,
//     );
//   }
//
//   Widget _buildTextField(String label, TextEditingController controller, {bool isNumber = false}) {
//     return TextFormField(
//       controller: controller,
//       keyboardType: isNumber ? TextInputType.number : TextInputType.text,
//       decoration: InputDecoration(
//         labelText: label,
//         border: const OutlineInputBorder(),
//         filled: true,
//         fillColor: Colors.grey.shade50,
//       ),
//       validator: (val) => val == null || val.isEmpty ? 'Required' : null,
//     );
//   }
//
//   Widget _buildDateField(String label, DateTime? date, VoidCallback onTap) {
//     return InkWell(
//       onTap: onTap,
//       child: InputDecorator(
//         decoration: InputDecoration(
//           labelText: label,
//           border: const OutlineInputBorder(),
//           filled: true,
//           fillColor: Colors.grey.shade50,
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               _formatDate(date),
//               style: TextStyle(color: date == null ? Colors.grey.shade700 : Colors.black87),
//             ),
//             const Icon(Icons.calendar_today, color: Colors.blue, size: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }