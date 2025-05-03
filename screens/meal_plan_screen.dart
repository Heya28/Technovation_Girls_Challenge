// --- screens/meal_plan_screen.dart ---
// displaying ai meal suggestions

import 'package:flutter/material.dart';
import 'dart:math'; // For random generation

// Simple Meal model
class Meal {
  final String name;
  final String description;
  final IconData icon; // Optional icon

  Meal({required this.name, required this.description, this.icon = Icons.restaurant});
}

// Simple Meal Plan model
class MealPlan {
  final Meal breakfast;
  final Meal lunch;
  final Meal dinner;

  MealPlan({required this.breakfast, required this.lunch, required this.dinner});
}

class MealPlanScreen extends StatefulWidget {
  const MealPlanScreen({super.key});

  @override
  State<MealPlanScreen> createState() => _MealPlanScreenState();
}

class _MealPlanScreenState extends State<MealPlanScreen> {
  // --- Placeholder Data & Simulated AI ---
  final List<String> _safeFoods = ['Bananas', 'Yogurt', 'Rice', 'Grilled Chicken', 'Oatmeal', 'Carrots', 'Apple', 'Bread']; // Example safe foods
  List<String> _selectedSafeFoods = ['Bananas', 'Yogurt']; // Initially selected
  MealPlan? _currentMealPlan; // Holds the generated plan

  // Simulated lists of possible meal components based on broad categories
  final Map<String, List<String>> _mealComponents = {
    'Breakfast': ['Oatmeal', 'Yogurt', 'Toast', 'Scrambled Eggs (if safe)', 'Fruit Smoothie'],
    'Lunch': ['Grilled Chicken', 'Rice', 'Pasta (if safe)', 'Sandwich (if safe)', 'Soup (if safe)', 'Salad (simple)'],
    'Dinner': ['Baked Fish (if safe)', 'Steamed Vegetables', 'Rice', 'Pasta (if safe)', 'Chicken and Rice', 'Yogurt with Fruit'],
    'Sides/Additions': ['Carrots', 'Apple slices', 'Banana', 'Berries', 'Bread slice']
  };

  @override
  void initState() {
    super.initState();
    _generateMealPlan(); // Generate initial plan on load
  }

  // --- SIMULATED AI Meal Generation ---
  void _generateMealPlan() {
    final random = Random();

    // Basic simulation: Pick randomly from components, trying to include safe foods
    String pickRandom(List<String> list) => list[random.nextInt(list.length)];

    // Try to incorporate selected safe foods more often (simple bias)
    List<String> availableBreakfast = [..._mealComponents['Breakfast']!, ..._selectedSafeFoods];
    List<String> availableLunch = [..._mealComponents['Lunch']!, ..._selectedSafeFoods];
    List<String> availableDinner = [..._mealComponents['Dinner']!, ..._selectedSafeFoods];
    List<String> availableSides = [..._mealComponents['Sides/Additions']!, ..._selectedSafeFoods];

    // Construct meals (very basic combination)
    String breakfastDesc = pickRandom(availableBreakfast);
    if (random.nextBool() && availableSides.isNotEmpty) { // Add a side sometimes
      breakfastDesc += ' with ${pickRandom(availableSides)}';
    }

    String lunchDesc = pickRandom(availableLunch);
     if (random.nextBool() && availableSides.isNotEmpty) {
      lunchDesc += ', ${pickRandom(availableSides)}';
    }
     if (random.nextBool() && availableSides.isNotEmpty) { // Maybe another side
       lunchDesc += ', ${pickRandom(availableSides)}'.replaceAll(RegExp(r', , '), ', '); // Avoid double commas
    }


    String dinnerDesc = pickRandom(availableDinner);
     if (random.nextBool() && availableSides.isNotEmpty) {
      dinnerDesc += ' with ${pickRandom(availableSides)}';
    }

    setState(() {
      _currentMealPlan = MealPlan(
        breakfast: Meal(name: 'Breakfast', description: breakfastDesc, icon: Icons.free_breakfast),
        lunch: Meal(name: 'Lunch', description: lunchDesc, icon: Icons.lunch_dining),
        dinner: Meal(name: 'Dinner', description: dinnerDesc, icon: Icons.dinner_dining),
      );
    });
     ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('New meal suggestions generated!'), backgroundColor: Colors.blueAccent),
      );
  }

  void _showSafeFoodsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Use a StatefulWidget inside the dialog to manage its state
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Select Your Safe Foods'),
              content: SingleChildScrollView(
                child: Wrap(
                  spacing: 8.0, // gap between adjacent chips
                  runSpacing: 4.0, // gap between lines
                  children: _safeFoods.map((food) {
                    final bool isSelected = _selectedSafeFoods.contains(food);
                    return FilterChip(
                      label: Text(food),
                      selected: isSelected,
                      onSelected: (bool selected) {
                        setDialogState(() { // Use setDialogState to update the dialog's UI
                          if (selected) {
                            _selectedSafeFoods.add(food);
                          } else {
                            _selectedSafeFoods.remove(food);
                          }
                        });
                         // Update the main screen state as well when dialog changes
                         setState(() {});
                      },
                      selectedColor: Theme.of(context).colorScheme.secondary.withOpacity(0.7),
                      checkmarkColor: Theme.of(context).colorScheme.onSecondary,
                    );
                  }).toList(),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Done'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Optionally regenerate plan based on new safe foods
                    // _generateMealPlan();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }


  Widget _buildMealCard(Meal meal, Color cardColor) {
     final theme = Theme.of(context);
    return Card(
      color: cardColor.withOpacity(0.1), // Light background based on meal type
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(meal.icon, size: 30, color: cardColor),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal.name,
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: cardColor),
                  ),
                  const SizedBox(height: 4),
                  Text(meal.description, style: theme.textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Safe Foods Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Your Safe Foods', style: theme.textTheme.titleMedium),
                      TextButton.icon(
                         icon: const Icon(Icons.edit_outlined, size: 18),
                         label: const Text('Edit'),
                         onPressed: _showSafeFoodsDialog,
                         style: TextButton.styleFrom(
                            foregroundColor: theme.colorScheme.primary,
                            padding: EdgeInsets.zero,
                         ),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: _selectedSafeFoods.map((food) => Chip(
                      label: Text(food),
                      backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                      labelStyle: TextStyle(color: theme.colorScheme.primary),
                    )).toList(),
                  ),

                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Meal Suggestions Section
          Text(
            'AI Meal Suggestions for This Week', // Title from prototype
            style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.primary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          if (_currentMealPlan != null) ...[
            _buildMealCard(_currentMealPlan!.breakfast, Colors.orangeAccent), // Breakfast
            const SizedBox(height: 12),
            _buildMealCard(_currentMealPlan!.lunch, Colors.lightGreen), // Lunch
            const SizedBox(height: 12),
            _buildMealCard(_currentMealPlan!.dinner, Colors.lightBlueAccent), // Dinner
          ] else ...[
             const Center(child: CircularProgressIndicator()), // Show loading if plan not ready
          ],

          const SizedBox(height: 24),

          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.save_alt_outlined),
                label: const Text('Save Plan'),
                onPressed: () {
                  // TODO: Implement saving logic (e.g., to local storage or backend)
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Save plan feature not implemented yet.')),
                  );
                },
                 style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                 ),
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.refresh),
                label: const Text('Regenerate'),
                onPressed: _generateMealPlan, // Call the generation function
                 style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.secondary,
                    foregroundColor: theme.colorScheme.onSecondary,
                 ),
              ),
            ],
          ),
           const SizedBox(height: 20), // Bottom padding
        ],
      ),
    );
  }
}

