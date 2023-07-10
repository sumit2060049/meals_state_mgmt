//The idea here is to build a provider that simply stores all these favorite meals in a list of favorite meals.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_state_mgmt/models/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]);
  //when you are using StateNotifier you're not allowed to edit an existing value in memeory , instead you must always create a new one.

  bool toggleMealFavoriteStatus(Meal meal) {
    final mealIsFavorite = state.contains(meal);

    if (mealIsFavorite) {
      state = state
          .where((m) => m.id != meal.id)
          .toList(); //where gives us new list
      return false;
    } else {
      state = [...state, meal];
      return true;
    }

    //state = [];
  }
}

//Now we just need to connect it ot this actual provider so that we can use this data in our widgets.
final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((ref) {
  return FavoriteMealsNotifier();
});//for complex state to manage and where data can change