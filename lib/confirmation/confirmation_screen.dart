import 'package:e_commerce/confirmation/confirmation_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmationScreen extends StatelessWidget {
  ConfirmationScreen({Key? key}) : super(key: key);

  final controller = Get.put(ConfirmationScreenController());

  @override
  Widget build(BuildContext context) {
    final Size size = Get.size;

    return Container(
      color: const Color.fromRGBO(8, 42, 58, 1),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Confrimation"),
            backgroundColor: const Color.fromRGBO(8, 42, 58, 1),
          ),
          body: SizedBox(
            height: size.height,
            width: size.width,
            child: Column(children: [
              SizedBox(
                height: size.height / 30,
              ),
              addressCart(size),
              SizedBox(
                height: size.height / 30,
              ),
              orderDetails(size)
            ]),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: size.height / 12,
                width: size.width / 1.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color.fromRGBO(8, 42, 58, 1),
                ),
                alignment: Alignment.center,
                child: const Text(
                  "Pay Now",
                  style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget addressCart(Size size) {
    return Material(
      elevation: 5,
      child: Container(
        width: size.width / 1.1,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                controller.address,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            Text(
              controller.pincode,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: size.height / 30,
            ),
          ],
        ),
      ),
    );
  }

  Widget orderDetails(Size size) {
    Widget text(String header, String footer) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            header,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          Text(
            footer,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ],
      );
    }

    return Material(
      elevation: 5,
      color: Colors.white,
      child: Container(
        width: size.width / 1.1,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Price  Details",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: size.height / 40,
            ),
            text("Total Price : ", "Rs. ${controller.totalPrice}"),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: text("Discount : ", "Rs. ${controller.totalDiscount}")),
            text("Payable Price : ", "Rs. ${controller.payablePrice}"),
          ],
        ),
      ),
    );
  }
}
