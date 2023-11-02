import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_eg/src/domain/models/dish_of_destiny.dart';

import '../../../main.dart';
import '../../utils/ui_constants.dart';

// Consumer provider widget
class CustomCard extends ConsumerWidget {
  const CustomCard({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //Listening provider
    final provider = ref.watch(displayDishOfDestinyProvider);
    //building from provider state
    return FutureBuilder<DishOfDestiny>(
      future: provider,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final data = snapshot.data;
          if (data != DishOfDestiny.empty()) {
            return SizedBox(
              height: 395,
              width: 350,
              child: Card(
                color: Colors.yellowAccent,
                child: Column(
                  children: [
                    Text(
                      data!.name,
                      style: UiConstants.cardNameTextStyle,
                    ),
                    Text(
                      data.emoji,
                      style: UiConstants.cardEmojiTextStyle,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        }
      },
    );
  }
}
