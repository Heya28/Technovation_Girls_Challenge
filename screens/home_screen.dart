// --- screens/home_screen.dart ---
// Main screen with bottom navigation bar.

import 'package:flutter/material.dart';
import 'food_entry_screen.dart';
import 'meal_plan_screen.dart';
import 'community_screen.dart';
//here to import other screens if required 

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Index for the selected tab

  // List of widgets to display for each tab
  static const List<Widget> _widgetOptions = <Widget>[
    FoodEntryScreen(), // Tab 0
    MealPlanScreen(),  // Tab 1
    CommunityScreen(), // Tab 2
    // Add Profile/Settings Screen here if needed
  ];

  // Titles for the AppBar corresponding to each tab
  static const List<String> _appBarTitles = <String>[
    'Daily Food Entry',
    'Meal Suggestions',
    'ARFID Circle',
    // Add Profile/Settings Title
  ];


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Get theme

    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitles[_selectedIndex]), // Dynamic title
        // Optional: Add actions like logout or settings
        actions: [
           if (_selectedIndex == 0) // Example: Add action only on first tab
             IconButton(
                icon: const Icon(Icons.history),
                tooltip: 'View Past Entries',
                onPressed: () {
                  // TODO: Implement navigation to history screen
                   ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('History feature not implemented yet.'))
                   );
                },
              ),
           IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Log Out',
            onPressed: () {
              // Simulate logout
              Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
            },
          ),
        ],
      ),
      body: Center(
        // Display the widget corresponding to the selected tab
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu), // Food Entry
            label: 'Log Food',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today), // Meal Plan
            label: 'Meals',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt_outlined), // Community
            label: 'Community',
          ),
          // Add Profile/Settings Item if needed
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.settings),
          //   label: 'Settings',
          // ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        // Use theme colors
        // selectedItemColor: theme.bottomNavigationBarTheme.selectedItemColor,
        // unselectedItemColor: theme.bottomNavigationBarTheme.unselectedItemColor,
        // backgroundColor: theme.bottomNavigationBarTheme.backgroundColor,
        // type: theme.bottomNavigationBarTheme.type,
      ),
    );
  }
}
