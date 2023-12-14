import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/components/main_drawer.dart';
import 'package:meals/providers/favourites_provider.dart';
import 'package:meals/providers/filters_provider.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/filters_screen.dart';
import 'package:meals/screens/meals_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentScreenIndex = 0;

  void _onDrawerSelection(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == "filters") {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final favourtieMeals = ref.watch(favouriteMealsProvider);
    final availableMeals = ref.watch(filteredMealsProvider);

    final List<Widget> screens = [
      CategoriesScreen(
        availableMeals: availableMeals,
      ),
      MealsScreen(meals: favourtieMeals)
    ];

    final List<String> titles = [
      "Categories",
      "Your Favourites",
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(titles[_currentScreenIndex]),
      ),
      drawer: MainDrawer(
        onSelection: _onDrawerSelection,
      ),
      body: screens[_currentScreenIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentScreenIndex,
        onTap: (int index) {
          setState(() {
            _currentScreenIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favourites',
          ),
        ],
      ),
    );
  }
}
