import 'package:flutter/material.dart';
import 'package:small_res/models/menuItem.model.dart';
import 'package:transparent_image/transparent_image.dart';

class MenuItems extends StatelessWidget {
  const MenuItems({
    super.key,
    required this.menuItem,
  });

  final AsyncSnapshot<List<MenuItem>> menuItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 9 / 16),
        itemCount: menuItem.data!.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 5,
                      offset: Offset(3, 3))
                ]),
            child: Column(
              children: [
                Image.network(
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.cover,
                    'http://localhost:8080/api/res/${menuItem.data![index].imageUrl}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
