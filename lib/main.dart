import 'package:flutter/material.dart';
import 'crane_installation.dart'; // Import the Crane Installation screen
import 'wtg_installation.dart'; // Import the new WTG Installation screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wind Farm App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The body contains a Container with our requested blue-to-purple gradient
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade800, Colors.purple.shade800],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Dashboard',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50),

                // Card 1: Crane Platform
                _buildClickableCard(
                  context: context,
                  title: 'Crane Platform',
                  icon: Icons.precision_manufacturing,
                ),
                const SizedBox(height: 20),

                // Card 2: WTG Installation
                _buildClickableCard(
                  context: context,
                  title: 'WTG Installation',
                  icon: Icons.wind_power,
                ),
                const SizedBox(height: 20),

                // Card 3: Safety & Quality
                _buildClickableCard(
                  context: context,
                  title: 'Safety & Quality',
                  icon: Icons.health_and_safety,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // A reusable method to generate identical white clickable cards
  Widget _buildClickableCard({
    required BuildContext context,
    required String title,
    required IconData icon,
  }) {
    return Card(
      color: Colors.white,
      elevation: 8,
      shadowColor: Colors.black45,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        // Rounded border for the ripple effect so it doesn't overflow
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          // Navigate to specific page based on title
          Widget nextScreen;
          if (title == 'Crane Platform') {
            nextScreen = const CraneInstallationScreen();
          } else if (title == 'WTG Installation') {
            nextScreen = const WtgInstallationScreen();
          } else {
            nextScreen = DetailScreen(pageTitle: title);
          }

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => nextScreen,
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 32, color: Colors.blue.shade800),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Detail Page that opens when a generic card is clicked (Fallback for Safety & Quality)
class DetailScreen extends StatelessWidget {
  final String pageTitle;

  const DetailScreen({super.key, required this.pageTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Flutter's AppBar automatically handles the back button (implied leading widget)
        // when pushed onto a Navigation stack.
        title: Text(
          pageTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        elevation: 4,
        shadowColor: Colors.black45,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.dashboard_customize,
              size: 80,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 20),
            Text(
              '$pageTitle Details',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Content for this section will go here.',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'crane_installation.dart'; // Importing the new Crane Installation screen
// import 'wtg_installation.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Wind Farm App',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
//         useMaterial3: true,
//       ),
//       home: const MainScreen(),
//     );
//   }
// }
//
// class MainScreen extends StatelessWidget {
//   const MainScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // The body contains a Container with our requested blue-to-purple gradient
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.blue.shade800, Colors.purple.shade800],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 const Text(
//                   'Dashboard',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 36,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 50),
//
//                 // Card 1: Crane Platform
//                 _buildClickableCard(
//                   context: context,
//                   title: 'Crane Platform',
//                   icon: Icons.precision_manufacturing,
//                 ),
//                 const SizedBox(height: 20),
//
//                 // Card 2: WTG Installation
//                 _buildClickableCard(
//                   context: context,
//                   title: 'WTG Installation',
//                   icon: Icons.wind_power,
//                 ),
//                 const SizedBox(height: 20),
//
//                 // Card 3: Safety & Quality
//                 _buildClickableCard(
//                   context: context,
//                   title: 'Safety & Quality',
//                   icon: Icons.health_and_safety,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // A reusable method to generate identical white clickable cards
//   Widget _buildClickableCard({
//     required BuildContext context,
//     required String title,
//     required IconData icon,
//   }) {
//     return Card(
//       color: Colors.white,
//       elevation: 8,
//       shadowColor: Colors.black45,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: InkWell(
//         // Rounded border for the ripple effect so it doesn't overflow
//         borderRadius: BorderRadius.circular(16),
//         onTap: () {
//           // Navigate to specific page based on title
//           Widget nextScreen;
//           if (title == 'Crane Platform') {
//             nextScreen = const CraneInstallationScreen();
//           } else {
//             nextScreen = DetailScreen(pageTitle: title);
//           }
//
//           if (title == 'WTG Installation') {
//             nextScreen = const WtgInstallationScreen();
//           } else {
//             nextScreen = DetailScreen(pageTitle: title);
//           }
//
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => nextScreen,
//             ),
//           );
//         },
//         child: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Colors.blue.shade50,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Icon(icon, size: 32, color: Colors.blue.shade800),
//               ),
//               const SizedBox(width: 20),
//               Expanded(
//                 child: Text(
//                   title,
//                   style: const TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black87,
//                   ),
//                 ),
//               ),
//               const Icon(
//                 Icons.arrow_forward_ios,
//                 color: Colors.grey,
//                 size: 20,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // Detail Page that opens when a card is clicked (Fallback for other cards)
// class DetailScreen extends StatelessWidget {
//   final String pageTitle;
//
//   const DetailScreen({super.key, required this.pageTitle});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // Flutter's AppBar automatically handles the back button (implied leading widget)
//         // when pushed onto a Navigation stack.
//         title: Text(
//           pageTitle,
//           style: const TextStyle(fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.blue.shade800,
//         foregroundColor: Colors.white,
//         elevation: 4,
//         shadowColor: Colors.black45,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.dashboard_customize,
//               size: 80,
//               color: Colors.grey.shade400,
//             ),
//             const SizedBox(height: 20),
//             Text(
//               '$pageTitle Details',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.grey.shade800,
//               ),
//             ),
//             const SizedBox(height: 10),
//             const Text(
//               'Content for this section will go here.',
//               style: TextStyle(color: Colors.grey),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }