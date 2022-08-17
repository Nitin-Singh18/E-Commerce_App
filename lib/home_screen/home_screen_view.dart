import 'package:e_commerce/cart_screen/cart_screen.dart';
import 'package:e_commerce/categories_and_featured_screen/categories_and_featured_screen.dart';
import 'package:e_commerce/home_screen/drawer.dart';
import 'package:e_commerce/home_screen/home_screen_controller.dart';
import 'package:e_commerce/home_screen/model/categories_model.dart';
import 'package:e_commerce/item-screen/items_screen.dart';
import 'package:e_commerce/item_details_screen/item_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreenView extends StatelessWidget {
  const HomeScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = Get.size;

    final controller = Get.put(HomeScreenController());

    return Container(
      color: Colors.white,
      child: SafeArea(child: GetBuilder<HomeScreenController>(
        builder: (value) {
          if (!value.isLoading) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Ecommerce App"),
                backgroundColor: const Color.fromRGBO(8, 42, 58, 1),
                actions: [
                  IconButton(
                    onPressed: () {
                      Get.to(
                        () => CartScreen(),
                      );
                    },
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
                          itemCount: controller.bannerData.length,
                          onPageChanged: controller.changeIndicator,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(controller
                                            .bannerData[index].image))),
                              ),
                            );
                          },
                        ),
                      ),

                      //Indicator

                      SizedBox(
                        height: size.height / 25,
                        width: size.width,
                        child: Obx(
                          () {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (int i = 0;
                                    i < controller.isSelected.length;
                                    i++)
                                  indicator(
                                      size, controller.isSelected[i].value)
                              ],
                            );
                          },
                        ),
                      ),

                      //Categories

                      categoriesTitle(size, "All Cateogories", () {
                        Get.to(() => CategoriesAndFeaturedScreen(
                            model: controller.categoriesData));
                      }),

                      listViewBuilder(size, controller.categoriesData, true),

                      SizedBox(
                        height: size.height / 25,
                      ),

                      categoriesTitle(size, "Featured", () {
                        Get.to(() => CategoriesAndFeaturedScreen(
                            model: controller.featuredData));
                      }),

                      listViewBuilder(size, controller.featuredData, false),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )),
    );
  }

  Widget listViewBuilder(
      Size size, List<CategoriesModel> data, bool isFeatured) {
    return SizedBox(
      height: size.height / 7,
      width: size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return listViewBuilderItems(size, data[index], isFeatured);
        },
      ),
    );
  }

  Widget listViewBuilderItems(
      Size size, CategoriesModel categories, bool isFeatured) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () {
          if (isFeatured) {
            Get.to(() => ItemsScreen(
                  categoryId: categories.id,
                  categoryTitle: categories.title,
                ));
          } else {
            Get.to(() => ItemDetailsScreen(id: categories.id));
          }
        },
        child: SizedBox(
          height: size.height / 7,
          width: size.width / 4.2,
          child: Column(
            children: [
              Container(
                height: size.height / 10,
                width: size.width / 2.2,
                decoration: BoxDecoration(
                    image:
                        DecorationImage(image: NetworkImage(categories.image))),
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
            onPressed: () => function(),
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
        height: isSelected ? size.height / 50 : size.height / 120,
        width: isSelected ? size.width / 50 : size.height / 120,
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.black),
      ),
    );
  }
}
