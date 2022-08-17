import 'package:e_commerce/address/address_screen.dart';
import 'package:e_commerce/cart_screen/cart_screen_controller.dart';
import 'package:e_commerce/const/const.dart';
import 'package:e_commerce/item_details_screen/item_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);

  final controller = Get.put(CartScreenController());

  @override
  Widget build(BuildContext context) {
    final Size size = Get.size;

    return Container(
      color: const Color.fromRGBO(8, 42, 58, 1),
      child: SafeArea(child: GetBuilder<CartScreenController>(builder: (value) {
        if (!controller.isLoading) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("My Cart"),
              backgroundColor: const Color.fromRGBO(8, 42, 58, 1),
            ),
            body: SizedBox(
              height: size.height,
              width: size.width,
              child: ListView.builder(
                itemCount: controller.productsDetails.length,
                itemBuilder: (context, index) {
                  return cartItems(size, controller.productsDetails[index]);
                },
              ),
            ),
            bottomNavigationBar: SizedBox(
              height: size.height / 12,
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Rs. 100,000",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(
                            () => AddressScreen(),
                          );
                        },
                        child: Container(
                          height: size.height / 18,
                          width: size.width / 2.8,
                          alignment: Alignment.center,
                          color: const Color.fromRGBO(8, 42, 58, 1),
                          child: const Text(
                            "Checkout",
                            style: TextStyle(
                                fontSize: 17.5,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      )
                    ]),
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      })),
    );
  }

  Widget cartItems(Size size, ItemDetailModel model) {
    int discount =
        controller.calculateDiscount(model.totalPrice, model.sellingPrice);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
      child: Container(
        height: size.height / 3.8,
        width: size.width / 1.05,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey, width: 0.5),
            top: BorderSide(color: Colors.grey, width: 0.5),
          ),
        ),
        child: Column(children: [
          Expanded(
            child: Container(
              height: size.height / 8,
              width: size.width / 1.1,
              child: Row(
                children: [
                  Container(
                    height: size.height / 8,
                    width: size.width / 4.5,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(model.img),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width / 22,
                  ),
                  Expanded(
                    child: SizedBox(
                      child: RichText(
                        text: TextSpan(
                          text: "${model.title}\n",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          children: [
                            TextSpan(
                              text: "Rs.${model.totalPrice}",
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  decoration: TextDecoration.lineThrough),
                            ),
                            TextSpan(
                              text: " ${model.sellingPrice}",
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.green,
                              ),
                            ),
                            TextSpan(
                              text: " $discount% off",
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.green,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 25.0),
            child: Text(
              "Will be delivered in ${model.deliveryDays} days",
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              controller.removeFromCart(model.id);
            },
            title: const Text("Remove from cart"),
            trailing: const Icon(Icons.delete),
          )
        ]),
      ),
    );
  }
}
