import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/my_orders/my_orders_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class MyOrderController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<MyOrdersModel> orders = [];
  bool isLoading = true;

  Future<void> getMyOrders() async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('myorders')
          .get()
          .then((value) {
        orders =
            value.docs.map((e) => MyOrdersModel.fromJson(e.data())).toList();
        isLoading = false;
        update();
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() {
    super.onInit();
    getMyOrders();
  }
}
