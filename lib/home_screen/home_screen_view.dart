import 'package:e_commerce/const/const.dart';
import 'package:e_commerce/home_screen/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreenView extends StatelessWidget {
  const HomeScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = Get.size;

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Ecommerce App"),
            backgroundColor: const Color.fromRGBO(8, 42, 58, 1),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.shopping_cart),
              )
            ],
          ),
          drawer: const HomeScreenDrawer(),
          body: SizedBox(
            height: size.height,
            width: size.width,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //Banner

                  SizedBox(
                    height: size.height / 3.5,
                    width: size.width,
                    child: PageView.builder(
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(bannerImage))),
                          ),
                        );
                      },
                    ),
                  ),

                  //Indicator

                  SizedBox(
                    height: size.height / 25,
                    width: size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < 4; i++) indicator(size, false)
                      ],
                    ),
                  ),

                  //Categories

                  categoriesTitle(size, "All Cateogories", () {}),

                  listViewBuilder(size),

                  SizedBox(
                    height: size.height / 25,
                  ),

                  categoriesTitle(size, "Featured", () {}),

                  listViewBuilder(size),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget listViewBuilder(Size size) {
    return SizedBox(
      height: size.height / 7,
      width: size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) {
          return listViewBuilderItems(size, images[index]);
        },
      ),
    );
  }

  Widget listViewBuilderItems(Size size, Categories categories) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        height: size.height / 7,
        width: size.width / 4.2,
        child: Column(
          children: [
            Container(
              height: size.height / 10,
              width: size.width / 2.2,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(categories.imageUrl))),
            ),
            Expanded(
              child: SizedBox(
                child: Text(
                  categories.title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget categoriesTitle(Size size, String title, Function function) {
    return SizedBox(
      height: size.height / 17,
      width: size.width / 1.05,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          TextButton(
            onPressed: () => function,
            child: const Text(
              "View More",
              style: TextStyle(
                  color: Color.fromRGBO(31, 108, 171, 1), fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget indicator(Size size, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        height: isSelected ? size.height / 80 : size.height / 100,
        width: isSelected ? size.width / 80 : size.height / 100,
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.black),
      ),
    );
  }
}
