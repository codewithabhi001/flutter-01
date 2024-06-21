// import 'package:flutter/material.dart';
// import './screens/create_slot_screen.dart';
// import './screens/download_slot_screen.dart';
// import './screens/edit_tournament_screen.dart';
// import './screens/home_screen.dart';
// import './screens/points_table_screen.dart';
// import './screens/RegistrationPage.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData.dark(),
//       initialRoute: '/',
//       routes: {
//         '/': (context) => MainPage(child: const HomeScreen()),
//         '/home': (context) => MainPage(child: const HomeScreen()),
//         '/download': (context) => MainPage(child: const DownloadSlotScreen()),
//         '/points_table': (context) =>
//             MainPage(child: const PointsTableScreen()),
//         '/create_slot': (context) => MainPage(child: CreateSlotScreen()),
//         '/edit_tournament': (context) =>
//             MainPage(child: const EditTournamentScreen()),
//         '/register': (context) => MainPage(child: RegistrationPage()),
//       },
//     );
//   }
// }

// class MainPage extends StatefulWidget {
//   final Widget child;

//   MainPage({required this.child});

//   @override
//   // ignore: library_private_types_in_public_api
//   _MainPageState createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   int _selectedIndex = 0;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     // Determine initial index based on initial route
//     switch (ModalRoute.of(context)!.settings.name) {
//       case '/':
//         _selectedIndex = 0;
//         break;
//       case '/home':
//         _selectedIndex = 0;
//         break;
//       case '/download':
//         _selectedIndex = 1;
//         break;
//       case '/create_slot':
//         _selectedIndex = 2;
//         break;
//       case '/points_table':
//         _selectedIndex = 3;
//         break;
//       case '/edit_tournament':
//         _selectedIndex = 4;
//         break;
//       default:
//         _selectedIndex = 0;
//     }
//   }

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//     switch (_selectedIndex) {
//       case 0:
//         Navigator.pushReplacementNamed(context, '/home');
//         break;
//       case 1:
//         Navigator.pushReplacementNamed(context, '/download');
//         break;
//       case 2:
//         Navigator.pushReplacementNamed(context, '/create_slot');
//         break;
//       case 3:
//         Navigator.pushReplacementNamed(context, '/points_table');
//         break;
//       case 4:
//         Navigator.pushReplacementNamed(context, '/edit_tournament');
//         break;
//     }
//   }

//   String _getAppBarTitle() {
//     switch (_selectedIndex) {
//       case 0:
//         return 'TournaTrack'; // Main page title
//       case 1:
//         return 'Download Slot';
//       case 2:
//         return 'Create Slot';
//       case 3:
//         return 'Points Table';
//       case 4:
//         return 'Edit Tournament';
//       default:
//         return 'TournaTrack'; // Default title
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           _getAppBarTitle(),
//           style: const TextStyle(fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.more_vert),
//             onPressed: () {
//               // Implement action for more icon if needed
//             },
//           ),
//         ],
//         flexibleSpace: Container(
//             // decoration: const BoxDecoration(
//             //   gradient: LinearGradient(
//             //     colors: [
//             //       Color.fromARGB(255, 243, 89, 33),
//             //       Color.fromARGB(255, 219, 67, 2),
//             //     ],
//             //     begin: Alignment.topLeft,
//             //     end: Alignment.bottomRight,
//             //   ),
//             // ),
//             ),
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: <Widget>[
//             DrawerHeader(
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     Color.fromARGB(255, 243, 89, 33),
//                     Color.fromARGB(255, 219, 67, 2),
//                   ],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.only(bottom: 0.0),
//                 child: Image.asset(
//                   'assets/images/logo.png', // Replace with your logo image path
//                   height: 10,
//                   width: 200,
//                   fit: BoxFit.fitWidth, // Adjust fit as needed
//                 ),
//               ),
//             ),
//             ListTile(
//               leading: const Icon(Icons.home),
//               title: const Text('Home'),
//               onTap: () {
//                 Navigator.pop(context);
//                 if (_selectedIndex != 0) {
//                   setState(() {
//                     _selectedIndex = 0;
//                   });
//                   Navigator.pushReplacementNamed(context, '/home');
//                 }
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.download),
//               title: const Text('Download'),
//               onTap: () {
//                 Navigator.pop(context);
//                 if (_selectedIndex != 1) {
//                   setState(() {
//                     _selectedIndex = 1;
//                   });
//                   Navigator.pushReplacementNamed(context, '/download');
//                 }
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.scatter_plot_sharp),
//               title: const Text('Create Slot'),
//               onTap: () {
//                 Navigator.pop(context);
//                 if (_selectedIndex != 2) {
//                   setState(() {
//                     _selectedIndex = 2;
//                   });
//                   Navigator.pushReplacementNamed(context, '/create_slot');
//                 }
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.table_chart),
//               title: const Text('Points Table'),
//               onTap: () {
//                 Navigator.pop(context);
//                 if (_selectedIndex != 3) {
//                   setState(() {
//                     _selectedIndex = 3;
//                   });
//                   Navigator.pushReplacementNamed(context, '/points_table');
//                 }
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.edit),
//               title: const Text('Edit Tournament'),
//               onTap: () {
//                 Navigator.pop(context);
//                 if (_selectedIndex != 4) {
//                   setState(() {
//                     _selectedIndex = 4;
//                   });
//                   Navigator.pushReplacementNamed(context, '/edit_tournament');
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//       body: widget.child,
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: Color.fromARGB(52, 95, 91, 91),
//         type: BottomNavigationBarType.fixed,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.download),
//             label: 'Download',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.scatter_plot_sharp),
//             label: 'Create Slot',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.table_chart),
//             label: 'Points Table',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.edit),
//             label: 'Edit Tournament',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.amber[800],
//         unselectedItemColor: Colors.white,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }
