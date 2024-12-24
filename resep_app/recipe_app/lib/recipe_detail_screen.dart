import 'package:flutter/material.dart';
import 'add_recipe_screen.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Map<String, dynamic> recipe;

  const RecipeDetailScreen({required this.recipe, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe['name']),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddRecipeScreen(recipe: recipe),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Preparation Time: ${recipe['preparation_time']}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text('Ingredients:\n${recipe['ingredients']}'),
            const SizedBox(height: 10),
            Text('Instructions:\n${recipe['instructions']}'),
          ],
        ),
      ),
    );
  }
}
