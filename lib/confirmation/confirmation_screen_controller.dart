import 'package:e_commerce/address/address_screen_controller.dart';
import 'package:e_commerce/cart_screen/cart_screen_controller.dart';
import 'package:get/get.dart';

class ConfirmationScreenController extends GetxController {
  final AddressScreenController addressScreenController = Get.find();

  final CartScreenController cartScreenController = Get.find();

  String name = '', address = '', pincode = '';
  int totalPrice = 0, totalDiscount = 0, payablePrice = 0;

  void initializeData() {
    name = addressScreenController.name;
    address = addressScreenController.address;
    pincode = addressScreenController.pincode;

    totalPrice = cartScreenController.totalPrice;
    totalDiscount = cartScreenController.totalDiscount;
    payablePrice = cartScreenController.totalSellingPrice;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initializeData();
  }
}
