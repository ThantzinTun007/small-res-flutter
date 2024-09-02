import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:small_res/models/menuItem.model.dart';
import 'package:small_res/screens/menuitems_details.dart';

class MenuItems extends StatelessWidget {
  const MenuItems({
    super.key,
    required this.menuItem,
    required this.addMenuItem
  });

  final AsyncSnapshot<List<MenuItem>> menuItem;
  final void Function(MenuItem menuitem) addMenuItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 10 / 14),
        itemCount: menuItem.data!.length,
        itemBuilder: (context, index) {
          return Material(
            elevation: 3,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                      builder: (context) => MenuitemsDetails(
                            menuItem: menuItem.data![index],
                          )),
                );
              },
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 3, horizontal: 8),
                            child: Text(
                              menuItem.data![index].category.toUpperCase(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 12),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 3, horizontal: 8),
                            child: Text(
                              menuItem.data![index].category == 'appetizer' ||
                                      menuItem.data![index].category ==
                                          'main dish'
                                  ? "🌶️ Spicy"
                                  : "🧂 Suger",
                              style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 12),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: Text(
                          menuItem.data![index].name,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            ],
                          ),
                          IconButton(
                            onPressed: () {addMenuItem(menuItem.data![index]);},
                            icon: const Icon(CupertinoIcons.add_circled_solid),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
