import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:small_res/models/menuItem.model.dart';

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
            childAspectRatio: 9 / 14),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover,
                      'http://localhost:8080/api/res/${menuItem.data![index].imageUrl}'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          child: Text(
                            menuItem.data![index].category,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          child: Text(
                            "🌶️ BALANCE",
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w800,
                                fontSize: 10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        menuItem.data![index].name,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Text(
                            menuItem.data![index].price.toString(),
                            style: const TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 63, 145, 221),
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            menuItem.data![index].price.toString(),
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.w700,
                                decoration: TextDecoration.lineThrough),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(CupertinoIcons.add_circled_solid),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
