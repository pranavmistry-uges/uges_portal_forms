import 'package:flutter/material.dart';
import 'tower1.dart';
import 'tower_installation.dart';
import 'nacelle_installation.dart';
import 'rotor_hub_installation.dart'; // Import the new Rotor Hub Installation screen

class WtgInstallationScreen extends StatelessWidget {
  const WtgInstallationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
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

  Widget _buildListItem({
    required BuildContext context,
    required String title,
    required IconData icon,
  }) {
    return InkWell(
      onTap: () {
        if (title == 'Tower1') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Tower1Screen()),
          );
        } else if (title == 'Tower Installation') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TowerInstallationScreen()),
          );
        } else if (title == 'Nacelle Installation') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NacelleInstallationScreen()),
          );
        } else if (title == 'Rotor Hub') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RotorHubInstallationScreen()),
          );
        } else {
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
// import 'tower1.dart';
// import 'tower_installation.dart'; // Import the Tower Installation screen
// import 'nacelle_installation.dart'; // Import the new Nacelle Installation screen
//
// class WtgInstallationScreen extends StatelessWidget {
//   const WtgInstallationScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8F9FA),
//       appBar: AppBar(
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
//   Widget _buildListItem({
//     required BuildContext context,
//     required String title,
//     required IconData icon,
//   }) {
//     return InkWell(
//       onTap: () {
//         if (title == 'Tower1') {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => const Tower1Screen()),
//           );
//         } else if (title == 'Tower Installation') {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => const TowerInstallationScreen()),
//           );
//         } else if (title == 'Nacelle Installation') {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => const NacelleInstallationScreen()),
//           );
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Opening $title...')),
//           );
//         }
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
