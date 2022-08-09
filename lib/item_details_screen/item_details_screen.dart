import 'package:e_commerce/cart_screen/cart_screen.dart';
import 'package:e_commerce/const/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemDetailsScreen extends StatelessWidget {
  const ItemDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = Get.size;

    return Container(
      color: const Color.fromRGBO(8, 42, 58, 1),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  Get.to(() => const CartScreen());
                },
                icon: const Icon(Icons.shopping_cart),
              ),
            ],
            backgroundColor: const Color.fromRGBO(8, 42, 58, 1),
          ),
          body: SizedBox(
            height: size.height,
            width: size.width,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height / 3.5,
                    width: size.width,
                    child: PageView.builder(
                      itemCount: 3,
                      //onPageChanged: controller.changeIndicator,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(image),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  //indicator

                  SizedBox(
                    height: size.height / 25,
                    width: size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < 3; i++) indicator(size, false)
                      ],
                    ),
                  ),

                  SizedBox(
                    height: size.height / 25,
                  ),

                  SizedBox(
                    width: size.width / 1.1,
                    child: const Text(
                      "LED TV",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: size.height / 35,
                  ),

                  SizedBox(
                    width: size.width / 1.1,
                    child: RichText(
                      text: const TextSpan(
                        text: "48,000 ",
                        style: TextStyle(
                          fontSize: 19,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.lineThrough,
                        ),
                        children: [
                          TextSpan(
                            text: "36,000",
                            style: TextStyle(
                              fontSize: 19,
                              color: Colors.black,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          TextSpan(
                            text: " 40% off",
                            style: TextStyle(
                                fontSize: 19,
                                color: Colors.green,
                                decoration: TextDecoration.none),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: size.height / 25,
                  ),

                  SizedBox(
                    width: size.width / 1.1,
                    child: const Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 25,
                  ),

                  SizedBox(
                    width: size.width / 1.1,
                    child: const Text(
                      description,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: size.height / 25,
                  ),

                  ListTile(
                    onTap: () {},
                    title: const Text("See Reviews"),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    leading: const Icon(Icons.star),
                  ),

                  SizedBox(
                    height: size.height / 25,
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: SizedBox(
            height: size.height / 15,
            width: size.width,
            child: Row(children: [
              Expanded(
                  child: customButton(
                      size, () {}, Colors.redAccent, 'Add to cart')),
              Expanded(
                  child: customButton(size, () {}, Colors.white, 'Buy Now')),
            ]),
          ),
        ),
      ),
    );
  }

  Widget customButton(Size size, Function function, Color color, String title) {
    return GestureDetector(
      onTap: () => function(),
      child: Container(
        alignment: Alignment.center,
        color: color,
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
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
