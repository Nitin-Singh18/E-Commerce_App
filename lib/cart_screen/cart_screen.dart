import 'package:e_commerce/const/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = Get.size;

    return Container(
      color: const Color.fromRGBO(8, 42, 58, 1),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("My Cart"),
            backgroundColor: const Color.fromRGBO(8, 42, 58, 1),
          ),
          body: SizedBox(
            height: size.height,
            width: size.width,
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return cartItems(size);
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    GestureDetector(
                      onTap: () {},
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
        ),
      ),
    );
  }

  Widget cartItems(Size size) {
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
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(image),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width / 22,
                  ),
                  Expanded(
                    child: SizedBox(
                      child: RichText(
                        text: const TextSpan(
                          text: "Product Name\n",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          children: [
                            TextSpan(
                              text: "Rs.86,000",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  decoration: TextDecoration.lineThrough),
                            ),
                            TextSpan(
                              text: " 56,000",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.green,
                              ),
                            ),
                            TextSpan(
                              text: " 36% off",
                              style: TextStyle(
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
          const Padding(
            padding: EdgeInsets.only(left: 25.0),
            child: Text(
              "Will be delivered in 7 days",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
          ),
          ListTile(
            onTap: () {},
            title: const Text("Remove from cart"),
            trailing: const Icon(Icons.delete),
          )
        ]),
      ),
    );
  }
}
