import 'package:e_commerce/address/address_screen_controller.dart';
import 'package:e_commerce/confirmation/confirmation_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressScreen extends StatelessWidget {
  AddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressScreenController>(
        init: AddressScreenController(),
        builder: (value) {
          if (value.isAddressAvailable) {
            return EditAddressScreen();
          } else {
            return AddAddressScreen();
          }
        });
  }
}

class AddAddressScreen extends StatelessWidget {
  AddAddressScreen({Key? key}) : super(key: key);

  final AddressScreenController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    final Size size = Get.size;
    return Container(
      color: const Color.fromRGBO(8, 42, 58, 1),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Address"),
            backgroundColor: const Color.fromRGBO(8, 42, 58, 1),
          ),
          body: SizedBox(
            height: size.height,
            width: size.width,
            child: Column(children: [
              SizedBox(
                height: size.height / 20,
              ),
              SizedBox(
                height: size.height / 11,
                width: size.width / 1.1,
                child: TextField(
                  controller: controller.nameController,
                  maxLength: 20,
                  decoration: InputDecoration(
                    hintText: "Full Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 30,
              ),
              SizedBox(
                height: size.height / 5,
                width: size.width / 1.1,
                child: TextField(
                  controller: controller.addressController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Address",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 30,
              ),
              SizedBox(
                height: size.height / 10,
                width: size.width / 1.1,
                child: TextField(
                  controller: controller.pincodeController,
                  maxLength: 6,
                  decoration: InputDecoration(
                    hintText: "Pincode",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
            ]),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
            child: GestureDetector(
              onTap: () {
                controller.onTap();
              },
              child: Container(
                height: size.height / 12,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color.fromRGBO(8, 42, 58, 1),
                ),
                child: const Text(
                  "Save",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EditAddressScreen extends StatelessWidget {
  EditAddressScreen({Key? key}) : super(key: key);

  final AddressScreenController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final Size size = Get.size;

    return Container(
      color: const Color.fromRGBO(8, 42, 58, 1),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(8, 42, 58, 1),
            title: const Text("Address"),
          ),
          body: SizedBox(
              height: size.height,
              width: size.width,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height / 30,
                  ),
                  addressCart(size),
                ],
              )),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
            child: GestureDetector(
              onTap: () {
                Get.to(() => ConfirmationScreen());
              },
              child: Container(
                height: size.height / 12,
                width: size.width / 1.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color.fromRGBO(8, 42, 58, 1),
                ),
                alignment: Alignment.center,
                child: const Text(
                  "Proceed",
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
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            controller.name,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              controller.address,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            controller.pincode,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: size.height / 30,
          ),
          GestureDetector(
            onTap: () {
              controller.onEdit();
            },
            child: Container(
              height: size.height / 18,
              width: size.width / 1.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: const Color.fromRGBO(8, 42, 58, 1),
              ),
              alignment: Alignment.center,
              child: const Text(
                "Edit",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
