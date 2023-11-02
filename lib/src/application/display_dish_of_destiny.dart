import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repositories/dishes_repository.dart';
import '../domain/models/dish_of_destiny.dart';

class DisplayDishOfDestiny extends StateNotifier<Future<DishOfDestiny>> {
  final DishesRepository repository;

  DisplayDishOfDestiny({required this.repository})
      : super(
          Future.value(
            DishOfDestiny.empty(),
          ),
        );

  void execute() {
    final newDish = _fetchDishOfDestiny();
    state = newDish;
  }

  Future<DishOfDestiny> _fetchDishOfDestiny() async {
    final List<DishOfDestiny> allDishes = await repository.fetchAllDishes();
    final max = allDishes.length;
    final random = Random();
    final randomId = random.nextInt(max);
    return allDishes[randomId];
  }

  Future<DishOfDestiny> get currentState => state;
}
