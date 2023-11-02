import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../main.dart';
import '../../domain/models/dish_of_destiny.dart';

//Consumer provider widget
class CustomDrawer extends ConsumerWidget {
  const CustomDrawer({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //Listening provider
    final provider = ref.watch(displayAllDishesProvider);

    //getting provider state
    final Future<List<DishOfDestiny>> allDishes = provider.currentState;

    //building from provider state
    return FutureBuilder<List<DishOfDestiny>>(
      future: allDishes,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Drawer(
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) => ListTile(
                title: Text(snapshot.data![index].name),
              ),
            ),
          );
        }
      },
    );
  }
}
