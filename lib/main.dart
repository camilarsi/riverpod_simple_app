import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_eg/src/application/display_all_dishes.dart';
import 'package:riverpod_eg/src/application/display_dish_of_destiny.dart';
import 'package:riverpod_eg/src/data/repositories/dishes_repository.dart';
import 'package:riverpod_eg/src/domain/models/dish_of_destiny.dart';
import 'package:riverpod_eg/src/presentation/widgets/custom_card.dart';
import 'package:riverpod_eg/src/presentation/widgets/custom_drawer.dart';
import 'package:riverpod_eg/src/utils/ui_constants.dart';

// Wrapped app by a PROVIDER SCOPE
void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

// Use cases providers

// Provider immutable

final displayAllDishesProvider = Provider<DisplayAllDishes>((ref) {
  final repository = ref.watch(dishesRepository);
  return DisplayAllDishes(repository: repository);
});

// Mutable provider

final displayDishOfDestinyProvider =
    StateNotifierProvider<DisplayDishOfDestiny, Future<DishOfDestiny>>((ref) {
  final repository = ref.watch(dishesRepository);
  return DisplayDishOfDestiny(
    repository: repository,
  );
});

//  Provider consumer widget (CONSUMER or CONSUMER-WIDGET)
class MyApp extends ConsumerWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(
        title: UiConstants.homeTitle,
      ),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  final String title;
  const MyHomePage({
    super.key,
    required this.title,
  });

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // watching a provider
    final displayDishOfDestiny = ref.watch(displayDishOfDestinyProvider);
    final isCardEmpty =
        ref.read(displayDishOfDestinyProvider.notifier).currentState ==
            Future.value(
              DishOfDestiny.empty(),
            );
    print(ref.read(displayDishOfDestinyProvider.notifier).currentState);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      drawer: const CustomDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const CustomCard(),
            UiConstants.mainText,
            ElevatedButton(
              onPressed: () {
                // calling a provider updater data function
                ref.read(displayDishOfDestinyProvider.notifier).execute();
              },
              child: const Text(
                UiConstants.sortingButtonText,
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
