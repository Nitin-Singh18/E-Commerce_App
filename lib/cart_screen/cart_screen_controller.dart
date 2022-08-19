import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/item_details_screen/item_detail_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CartScreenController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List productIds = [];
  List<ItemDetailModel> productsDetails = [];
  bool isLoading = true;
  int totalPrice = 0, totalDiscount = 0, totalSellingPrice = 0;

  //Function to get ids of items in the cart collection of the user

  Future<void> getCartItems() async {
    productIds = [];
    productsDetails = [];
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('cart')
          .get()
          .then((value) {
        productIds = value.docs.map((e) => e.data()['id']).toList();
        getProductDetails();
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> getProductDetails() async {
    for (var item in productIds) {
      try {
        await _firestore.collection('products').doc(item).get().then((value) {
          productsDetails.add(ItemDetailModel.fromJson(value.data()!));
        });
      } catch (e) {
        print(e);
      }
    }
    calculatePrice();

    isLoading = false;
    update();
  }

  Future<void> removeFromCart(String id) async {
    isLoading = true;
    update();

    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('cart')
          .doc(id)
          .delete()
          .then((value) {
        getCartItems();
      });
    } catch (e) {
      print(e);
    }
  }

  //Function to calculate discount.

  int calculateDiscount(int totalPrice, int sellingPrice) {
    double discount = ((totalPrice - sellingPrice) / totalPrice) * 100;

    return discount.toInt();
  }

  //Function to calculate Price

  void calculatePrice() {
    for (var item in productsDetails) {
      totalPrice = totalPrice + item.totalPrice;
      totalSellingPrice = totalSellingPrice + item.sellingPrice;
    }
    totalDiscount = totalPrice - totalSellingPrice;
  }

  @override
  void onInit() {
    super.onInit();
    getCartItems();
  }
}
