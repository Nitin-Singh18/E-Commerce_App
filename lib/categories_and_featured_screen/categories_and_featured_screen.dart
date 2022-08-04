import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home_screen/model/categories_model.dart';
import '../item-screen/items_screen.dart';

class CategoriesAndFeaturedScreen extends StatelessWidget {
  List<CategoriesModel> model;

  CategoriesAndFeaturedScreen({Key? key, required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(8, 42, 58, 1),
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          title: const Text("All Categories"),
          backgroundColor: Colors.blueAccent,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          child: GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: model.length,
            itemBuilder: (context, index) {
              return gridViewBuilderItems(Get.size, model[index]);
            },
          ),
        ),
      )),
    );
  }

  Widget gridViewBuilderItems(Size size, CategoriesModel categroies) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () {
          Get.to(() => const ItemsScreen());
        },
        child: SizedBox(
          height: size.height / 7,
          width: size.width / 4.2,
          child: Column(
            children: [
              Container(
                height: size.height / 8,
                width: size.width / 2.2,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(categroies.image),
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 30,
              ),
              Expanded(
                child: SizedBox(
                  child: Text(
                    categroies.title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
