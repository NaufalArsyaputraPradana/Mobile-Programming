import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'add_recipe_screen.dart';
import 'recipe_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> recipeList = [];
  final dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    fetchRecipes();
  }

  void fetchRecipes() async {
    final recipes = await dbHelper.getAllRecipes();
    setState(() {
      recipeList = recipes;
    });
  }

  void deleteRecipe(int id) async {
    await dbHelper.deleteRecipe(id);
    fetchRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recipes')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddRecipeScreen(),
            ),
          ).then((_) => fetchRecipes());
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: recipeList.length,
        itemBuilder: (context, index) {
          final recipe = recipeList[index];
          return ListTile(
            title: Text(recipe['name']),
            subtitle: Text('Preparation Time: ${recipe['preparation_time']}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => deleteRecipe(recipe['id']),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RecipeDetailScreen(recipe: recipe),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
