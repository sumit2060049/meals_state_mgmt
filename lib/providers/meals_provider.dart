import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_state_mgmt/data/dummy_data.dart';

//instantiating this provider clause will create such a provider object,
//which we then can listen to from inside our widgets.
//and we should therefore store this object in some variable
//so that we do store this object and we can access this object later.

//Setting up a provider.and we can now use it in widgets that need the data that is provided by this provider.
//so in this case ,we can use this provider in widgets that need our meals.
final mealsprovider = Provider((ref) {//used to manage state that not changes mostly
  return dummyMeals;
  //inside of this function,we now should return the value that we wanna provide.
});//i'll name it mealsProvider because i plan on providing my meals data here and later we're also going to add more complex providers.