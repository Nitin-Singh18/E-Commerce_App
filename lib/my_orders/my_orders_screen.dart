import 'package:e_commerce/const/const.dart';
import 'package:e_commerce/my_order_details.dart/my_order_details_screen.dart';
import 'package:e_commerce/my_orders/my_order_controller.dart';
import 'package:e_commerce/my_orders/my_orders_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = Get.size;

    final controller = Get.put(MyOrderController());

    return Container(
      color: const Color.fromRGBO(8, 42, 58, 1),
      child: SafeArea(
        child: GetBuilder<MyOrderController>(
          builder: (value) {
            if (!value.isLoading) {
              return Scaffold(
                appBar: AppBar(
                  title: Text("My Orders"),
                  backgroundColor: const Color.fromRGBO(8, 42, 58, 1),
                ),
                body: SizedBox(
                  height: size.height,
                  width: size.width,
                  child: ListView.builder(
                      itemCount: value.orders.length,
                      itemBuilder: (context, index) {
                        return listViewBuilderItems(size, value.orders[index]);
                      }),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget listViewBuilderItems(Size size, MyOrdersModel item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
      child: GestureDetector(
        onTap: () {
          Get.to(() => MyOrderDetailsScreen(
                item: item,
              ));
        },
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
                    image: NetworkImage(item.image),
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
                      text: "${item.name}\n",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                          text: item.status == 0
                              ? "Status : Pending"
                              : "Status : Delivered",
                          style: TextStyle(
                            fontSize: 16,
                            color:
                                item.status == 0 ? Colors.grey : Colors.green,
                            fontWeight: FontWeight.w500,
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
    );
  }
}
