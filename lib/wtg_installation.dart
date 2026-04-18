import 'package:flutter/material.dart';
import 'tower1.dart'; // Import the new Tower1 screen

class WtgInstallationScreen extends StatelessWidget {
  const WtgInstallationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Using a very light background color as seen in the image
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        // Flutter automatically adds the back button when this page is navigated to
        title: const Text(
          'WTG Installation',
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
            title: 'Tower1',
            icon: Icons.foundation,
          ),
          const SizedBox(height: 12),
          _buildListItem(
            context: context,
            title: 'Tower Installation',
            icon: Icons.construction,
          ),
          const SizedBox(height: 12),
          _buildListItem(
            context: context,
            title: 'Nacelle Installation',
            icon: Icons.settings_applications,
          ),
          const SizedBox(height: 12),
          _buildListItem(
            context: context,
            title: 'Rotor Hub',
            icon: Icons.cyclone,
          ),
          const SizedBox(height: 12),
          _buildListItem(
            context: context,
            title: 'Blade Installation',
            icon: Icons.air,
          ),
        ],
      ),
    );
  }

  // Reusable helper method to create the list items matching the uploaded image design
  Widget _buildListItem({
    required BuildContext context,
    required String title,
    required IconData icon,
  }) {
    return InkWell(
      onTap: () {
        if (title == 'Tower1') {
          // Navigate to the Tower1 Installation Screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Tower1Screen()),
          );
        } else {
          // Placeholder action for other menu items
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
// class WtgInstallationScreen extends StatelessWidget {
//   const WtgInstallationScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // Using a very light background color as seen in the image
//       backgroundColor: const Color(0xFFF8F9FA),
//       appBar: AppBar(
//         // Flutter automatically adds the back button when this page is navigated to
//         title: const Text(
//           'WTG Installation',
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
//             title: 'Tower1',
//             icon: Icons.foundation,
//           ),
//           const SizedBox(height: 12),
//           _buildListItem(
//             context: context,
//             title: 'Tower Installation',
//             icon: Icons.construction,
//           ),
//           const SizedBox(height: 12),
//           _buildListItem(
//             context: context,
//             title: 'Nacelle Installation',
//             icon: Icons.settings_applications,
//           ),
//           const SizedBox(height: 12),
//           _buildListItem(
//             context: context,
//             title: 'Rotor Hub',
//             icon: Icons.cyclone,
//           ),
//           const SizedBox(height: 12),
//           _buildListItem(
//             context: context,
//             title: 'Blade Installation',
//             icon: Icons.air,
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Reusable helper method to create the list items matching the uploaded image design
//   Widget _buildListItem({
//     required BuildContext context,
//     required String title,
//     required IconData icon,
//   }) {
//     return InkWell(
//       onTap: () {
//         // Placeholder action: You can replace this with actual navigation later
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Opening $title...')),
//         );
//       },
//       borderRadius: BorderRadius.circular(12),
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//         decoration: BoxDecoration(
//           color: Colors.grey.shade200, // Light grey background like the image
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Row(
//           children: [
//             Icon(
//               icon,
//               color: Colors.blue.shade700, // Blue icon color matching the image
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
//               color: Colors.black54, // Arrow indicator on the right
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }