import 'package:flutter/material.dart';
import 'raise_new_issue.dart'; // Import the new Raise New Issue screen

class SafetyQualityScreen extends StatelessWidget {
  const SafetyQualityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'Safety & Quality',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildListItem(
            context: context,
            title: 'Raise new issue',
            icon: Icons.report_problem, // Alert/issue icon
          ),
          const SizedBox(height: 12),
          _buildListItem(
            context: context,
            title: 'View all records',
            icon: Icons.list_alt, // Records/list icon
          ),
        ],
      ),
    );
  }

  // Reusing the exact same UI component from WTG Installation
  Widget _buildListItem({
    required BuildContext context,
    required String title,
    required IconData icon,
  }) {
    return InkWell(
      onTap: () {
        if (title == 'Raise new issue') {
          // Navigate to the Raise New Issue Screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RaiseNewIssueScreen()),
          );
        } else {
          // Placeholder for future navigation (View all records)
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Opening $title...')),
          );
        }
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.blue.shade700,
              size: 26,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
//
// class SafetyQualityScreen extends StatelessWidget {
//   const SafetyQualityScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8F9FA),
//       appBar: AppBar(
//         title: const Text(
//           'Safety & Quality',
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//         ),
//         backgroundColor: Colors.blue.shade800,
//         foregroundColor: Colors.white,
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(16.0),
//         children: [
//           _buildListItem(
//             context: context,
//             title: 'Raise new issue',
//             icon: Icons.report_problem, // Alert/issue icon
//           ),
//           const SizedBox(height: 12),
//           _buildListItem(
//             context: context,
//             title: 'View all records',
//             icon: Icons.list_alt, // Records/list icon
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Reusing the exact same UI component from WTG Installation
//   Widget _buildListItem({
//     required BuildContext context,
//     required String title,
//     required IconData icon,
//   }) {
//     return InkWell(
//       onTap: () {
//         // Placeholder for future navigation
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Opening $title...')),
//         );
//       },
//       borderRadius: BorderRadius.circular(12),
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//         decoration: BoxDecoration(
//           color: Colors.grey.shade200,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Row(
//           children: [
//             Icon(
//               icon,
//               color: Colors.blue.shade700,
//               size: 26,
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Text(
//                 title,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.black87,
//                 ),
//               ),
//             ),
//             const Icon(
//               Icons.chevron_right,
//               color: Colors.black54,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }