import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repositories/dishes_repository.dart';
import '../domain/models/dish_of_destiny.dart';

class DisplayAllDishes extends StateNotifier<Future<List<DishOfDestiny>>> {
  final DishesRepository repository;

  DisplayAllDishes({required this.repository}) : super(Future.value([])) {
    execute();
  }

  void execute() {
    state = _fetchDishes();
  }

  Future<List<DishOfDestiny>> _fetchDishes() async {
    try {
      final dishes = await repository.fetchAllDishes();
      return dishes;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<DishOfDestiny>> get currentState => state;
}
