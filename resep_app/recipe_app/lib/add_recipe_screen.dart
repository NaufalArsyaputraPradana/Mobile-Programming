import 'package:flutter/material.dart';
import 'database_helper.dart';

class AddRecipeScreen extends StatefulWidget {
  final Map<String, dynamic>? recipe;

  const AddRecipeScreen({this.recipe, super.key});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _nameController = TextEditingController();
  final _prepTimeController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _instructionsController = TextEditingController();
  final dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    if (widget.recipe != null) {
      _nameController.text = widget.recipe!['name'];
      _prepTimeController.text = widget.recipe!['preparation_time'];
      _ingredientsController.text = widget.recipe!['ingredients'];
      _instructionsController.text = widget.recipe!['instructions'];
    }
  }

  void saveRecipe() async {
    if (_nameController.text.isNotEmpty &&
        _prepTimeController.text.isNotEmpty) {
      final recipe = {
        'name': _nameController.text,
        'preparation_time': _prepTimeController.text,
        'ingredients': _ingredientsController.text,
        'instructions': _instructionsController.text,
      };
      if (widget.recipe == null) {
        await dbHelper.addRecipe(recipe);
      } else {
        recipe['id'] = widget.recipe!['id'];
        await dbHelper.updateRecipe(recipe);
      }
      Navigator.pop(context);
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Name and Preparation Time are required.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Recipe'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Recipe Name'),
            ),
            TextField(
              controller: _prepTimeController,
              decoration: const InputDecoration(labelText: 'Preparation Time'),
            ),
            TextField(
              controller: _ingredientsController,
              decoration: const InputDecoration(labelText: 'Ingredients'),
              maxLines: 3,
            ),
            TextField(
              controller: _instructionsController,
              decoration: const InputDecoration(labelText: 'Instructions'),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveRecipe,
              child: const Text('Save Recipe'),
            ),
          ],
        ),
      ),
    );
  }
}
