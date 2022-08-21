import 'package:e_commerce/const/const.dart';
import 'package:e_commerce/my_orders/my_orders_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyOrderDetailsScreen extends StatelessWidget {
  final MyOrdersModel item;
  MyOrderDetailsScreen({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = Get.size;

    return Container(
      color: const Color.fromRGBO(8, 42, 58, 1),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(item.name),
            backgroundColor: const Color.fromRGBO(8, 42, 58, 1),
          ),
          body: SizedBox(
            height: size.height,
            width: size.width,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height / 30,
                  ),
                  Container(
                    height: size.height / 5,
                    width: size.width / 1.1,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(item.image),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 30,
                  ),
                  Text(
                    item.name,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: size.height / 30,
                  ),
                  orderDetails(size, item),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget orderDetails(Size size, MyOrdersModel item) {
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
              "Order  Details",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: size.height / 40,
            ),
            text("Order Id :", item.orderId),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: text("Total : ", "Rs. ${item.totalPrice}")),
            text("Paid Amount :", "Rs. ${item.paidAmount}"),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: text("Ordered On :", "14-8-2022")),
            text("Delivered On :", "16-8-2022"),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: text(
                    "Status :", item.status == 0 ? 'Pending' : 'Delivered')),
          ],
        ),
      ),
    );
  }
}
