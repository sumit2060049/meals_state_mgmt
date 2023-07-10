import 'package:flutter/material.dart';
import 'package:meals_state_mgmt/data/dummy_data.dart';
import 'package:meals_state_mgmt/models/meal.dart';
import 'package:meals_state_mgmt/screens/meals.dart';
import 'package:meals_state_mgmt/widgets/category_grid_item.dart';
import 'package:meals_state_mgmt/models/category.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen(
      {super.key,
      //required this.onToggleFavorite,
      required this.availableMeals});

  //final void Function(Meal meal) onToggleFavorite;
  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync:
          this, //this parameter is responsible for making sure that this animation executes for every frame.
      duration: Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

//Here , we're doing something  we haven't really done before.we are adding a method to a stateless widget.
  void _selectCategory(BuildContext context, CAtegory category) {
    //Now we want to navigate to a different screen and this can be done using push method.
    //Navigator.push(context, route);or
    final filteredMeals = widget.availableMeals //dummyMeals(initially)
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
          //onToggleFavorite: onToggleFavorite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
        padding: EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ), //setting the number of columns

        children: [
          //here we wanna use the category_grid_item widget which we created.
          //Using for loop is an alternative
          //availableCategories.map((category)=>CategoryGridItem(category:category)).toList();
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelectCategory: () {
                _selectCategory(context, category);
              },
            ),
        ],
      ),
      builder: (context, child) => SlideTransition(
        position: Tween(
          begin: Offset(0, 0.3),
          end: Offset(0, 0),
        ).animate(
          CurvedAnimation(
              parent: _animationController, curve: Curves.easeInOut),
        ),
        //_animationController.drive(
        child: child,
        // Padding(
        //   padding: EdgeInsets.only(
        //     top: 100 - _animationController.value * 100,
        //   ),
        //   child: child,
        // ),
      ),
    );
  }
}
