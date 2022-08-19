import 'package:e_commerce/const/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressScreenController extends GetxController {
  late SharedPreferences _preferences;
  String name = "", address = "", pincode = "";
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  bool isAddressAvailable = false;

  //Function to initialize SharedPreferences
  Future<void> getInstance() async {
    _preferences = await SharedPreferences.getInstance();

    String address = getString('address');
    if (address.isNotEmpty) {
      isAddressAvailable = true;
    } else {
      isAddressAvailable = false;
    }
    initializeInfo();

    update();
  }

  void onTap() async {
    if (nameController.text.isNotEmpty &&
        addressController.text.isNotEmpty &&
        pincodeController.text.isNotEmpty) {
      await saveString('name', nameController.text);
      await saveString('address', addressController.text);
      await saveString('pincode', pincodeController.text);

      getInstance();
    } else {
      showAlert("All fields are required");
    }
  }

  //Function to save string value in storage
  Future<void> saveString(String key, String value) async {
    await _preferences.setString(key, value);
  }

  //Function to get string value from storage
  String getString(String key) => _preferences.getString(key) ?? "";

  void initializeInfo() {
    name = getString('name');
    address = getString('address');
    pincode = getString('pincode');
  }

  void onEdit() async {
    isAddressAvailable = false;
    update();

    await _preferences.clear();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getInstance();
  }
}
