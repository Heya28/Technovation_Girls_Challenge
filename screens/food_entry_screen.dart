// --- screens/food_entry_screen.dart ---
// loggind daily food intake screen

import 'package:flutter/material.dart';

// single food entry model - to update 
class FoodLogItem {
  String foodName;
  String portion;
  String feeling; // enum later ( good bad alright )

  FoodLogItem({required this.foodName, required this.portion, required this.feeling});
}

class FoodEntryScreen extends StatefulWidget {
  const FoodEntryScreen({super.key});

  @override
  State<FoodEntryScreen> createState() => _FoodEntryScreenState();
}

class _FoodEntryScreenState extends State<FoodEntryScreen> {
  // list food items of day store
  final List<FoodLogItem> _foodLog = [];
  final _foodNameController = TextEditingController();
  final _portionController = TextEditingController();
  final _feelingController = TextEditingController(); // simple text for now - chnage later 

  @override
  void dispose() {
    _foodNameController.dispose();
    _portionController.dispose();
    _feelingController.dispose();
    super.dispose();
  }

  void _addFoodItem() {
    // Basic validation
    if (_foodNameController.text.isNotEmpty &&
        _portionController.text.isNotEmpty &&
        _feelingController.text.isNotEmpty) {
      setState(() {
        _foodLog.add(FoodLogItem(
          foodName: _foodNameController.text,
          portion: _portionController.text,
          feeling: _feelingController.text,
        ));
        // Clear the fields after adding
        _foodNameController.clear();
        _portionController.clear();
        _feelingController.clear();
      });
       // Hide keyboard
       FocusScope.of(context).unfocus();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Food item added!'), backgroundColor: Colors.green),
        );
    } else {
       ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill all fields'), backgroundColor: Colors.orange),
        );
    }
  }

   void _removeFoodItem(int index) {
    setState(() {
      _foodLog.removeAt(index);
    });
     ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Food item removed'), backgroundColor: Colors.redAccent),
      );
  }


  @override
  Widget build(BuildContext context) {
     final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Today's Entry", // Title from prototype
            style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.primary),
          ),
          const SizedBox(height: 8),
          Text(
            "Log the foods you've tried today. One bite at a time!", // Subtitle
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),

          // --- Input Section ---
          Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Food Tried Field (Could use search/autocomplete later)
                  TextField(
                    controller: _foodNameController,
                    decoration: const InputDecoration(
                      labelText: 'Food Tried',
                      hintText: 'e.g., Banana, Chicken nugget',
                      prefixIcon: Icon(Icons.search), // Mimics search icon
                      border: OutlineInputBorder(), // Add border for clarity
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Portion Field
                  TextField(
                    controller: _portionController,
                    decoration: const InputDecoration(
                      labelText: 'Portion',
                      hintText: 'e.g., 1 slice, 2 bites, 100g',
                      prefixIcon: Icon(Icons.pie_chart_outline),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Feeling After Field (Could be dropdown/slider later)
                  TextField(
                    controller: _feelingController,
                    decoration: const InputDecoration(
                      labelText: 'Feeling After',
                      hintText: 'e.g., Good, Anxious, Okay, Proud',
                      prefixIcon: Icon(Icons.sentiment_satisfied_alt_outlined),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Add Food Button
                  ElevatedButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text('Add Food Item'),
                    onPressed: _addFoodItem,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.secondary, // Use secondary color
                      foregroundColor: theme.textTheme.labelLarge?.color, // Use button text color from theme
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 16),

          // --- Logged Items List ---
          Text(
            'Logged Items (${_foodLog.length})',
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          _foodLog.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: Text(
                      'No food items logged yet for today.',
                      style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true, // Important inside SingleChildScrollView
                  physics: const NeverScrollableScrollPhysics(), // Disable ListView scrolling
                  itemCount: _foodLog.length,
                  itemBuilder: (context, index) {
                    final item = _foodLog[index];
                    return Card(
                       margin: const EdgeInsets.symmetric(vertical: 6.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                          child: Icon(Icons.food_bank_outlined, color: theme.colorScheme.primary),
                        ),
                        title: Text(item.foodName, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('Portion: ${item.portion}\nFeeling: ${item.feeling}'),
                        isThreeLine: true, // Allows more space for subtitle
                        trailing: IconButton(
                          icon: Icon(Icons.delete_outline, color: Colors.redAccent[100]),
                          tooltip: 'Remove Item',
                          onPressed: () => _removeFoodItem(index),
                        ),
                      ),
                    );
                  },
                ),
           const SizedBox(height: 20), // Add some bottom padding
        ],
      ),
    );
  }
}