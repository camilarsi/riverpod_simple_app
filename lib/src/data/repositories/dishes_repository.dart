import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_eg/src/domain/models/dish_of_destiny.dart';

class DishesRepository extends StateNotifier<Future<List<DishOfDestiny>>> {
  static const String dishDataSource = 'assets/source.json';

  DishesRepository() : super(Future.value([]));

  Future<List<DishOfDestiny>> fetchAllDishes() async {
    final String response = await rootBundle.loadString(dishDataSource);
    final json = await jsonDecode(response);
    final List<DishOfDestiny> dataDishes = [];
    for (var jsonObject in json) {
      dataDishes.add(
        DishOfDestiny.fromJson(jsonObject),
      );
    }
    return dataDishes;
  }

  @override
  set state(Future<List<DishOfDestiny>> state) {
    super.state = state;
  }
}

final dishesRepository = StateProvider<DishesRepository>(
  (ref) => DishesRepository(),
);
