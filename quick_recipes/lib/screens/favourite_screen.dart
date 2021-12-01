import 'package:flutter/material.dart';
import 'package:quick_recipes/models.dart/meal.dart';
import 'package:quick_recipes/widgets/meal_item.dart';

class FavouriteScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;

  const FavouriteScreen({Key key, this.favoriteMeals}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return Center(
        child: Text('You Have No Favourites Yet - start adding some!'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: favoriteMeals[index].id,
            title: favoriteMeals[index].title,
            imageUrl: favoriteMeals[index].imageUrl,
            duration: favoriteMeals[index].duration,
            complexity: favoriteMeals[index].complexity,
            affordibility: favoriteMeals[index].affordability,
            
          );
        },
        itemCount: favoriteMeals.length,
      );
    }
  }
}
