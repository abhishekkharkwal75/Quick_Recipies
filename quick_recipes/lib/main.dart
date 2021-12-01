import 'package:flutter/material.dart';
import 'package:quick_recipes/dummy_data.dart';
import 'package:quick_recipes/screens/Taps_Screens.dart';
import 'package:quick_recipes/screens/categories_screen.dart';
import 'package:quick_recipes/category_item.dart';
import 'package:quick_recipes/screens/category_meal_screen.dart';
import 'package:quick_recipes/screens/filters_screen.dart';
import 'package:quick_recipes/screens/meal_detail_screen.dart';

import 'models.dart/meal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegen': false,
    'vegetarian': false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];
  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegen'] && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final excistingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (excistingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(excistingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(
          DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),
        );
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((meal)=>meal.id==id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        // backgroundColor: Colors.lime,
        // accentColor: Colors.black,
      ),
      //home: CategoriesScreen(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TapsScreen(favoriteMeals: _favoriteMeals),
        CategoryMealScreen.routename: (ctx) =>
            CategoryMealScreen(availableMeals: _availableMeals),
        MealDetailScreen.routeName: (ctx) =>
            MealDetailScreen(toggleFavorite: _toggleFavorite,isFavorite: _isMealFavorite,),
        FiltersScreen.routeName: (ctx) => FiltersScreen(
              saveFilter: _setFilters,
              currentFilters: _filters,
            ),
      },
      // onGenerateRoute: (settings) {
      //   print(settings.arguments);
      //   return MaterialPageRoute(builder: (ctx)=> CategoriesScreen());
      // }

      onUnknownRoute: (settings) {
        print(settings.arguments);
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
