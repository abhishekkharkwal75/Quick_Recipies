import 'package:flutter/material.dart';
import 'package:quick_recipes/models.dart/meal.dart';
import 'package:quick_recipes/screens/categories_screen.dart';
import 'package:quick_recipes/screens/favourite_screen.dart';
import 'package:quick_recipes/widgets/Main_Drawer.dart';

class TapsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;

  TapsScreen({this.favoriteMeals});
  @override
  _TapsScreenState createState() => _TapsScreenState();
}

class _TapsScreenState extends State<TapsScreen> {
   List<Map<String, Object>> _pages;

  int _selectPageIndex = 0;
  @override
  void initState() {
    _pages=[
    {
      'page': CategoriesScreen(),
      'title': 'Categories',
    },
    {
      'page': FavouriteScreen(favoriteMeals: widget.favoriteMeals),
      'title': 'Your Favorites',
    },
  ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectPageIndex]['title']),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Colors.purple,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.purple,
        currentIndex: _selectPageIndex,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            title: Text("Categories"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text("Favorites"),
          ),
        ],
      ),
    );
  }
}
