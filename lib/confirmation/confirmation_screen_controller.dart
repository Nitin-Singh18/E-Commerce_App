import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/address/address_screen_controller.dart';
import 'package:e_commerce/cart_screen/cart_screen_controller.dart';
import 'package:e_commerce/const/const.dart';
import 'package:e_commerce/home_screen/home_screen_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class ConfirmationScreenController extends GetxController {
  final AddressScreenController addressScreenController = Get.find();

  final CartScreenController cartScreenController = Get.find();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Razorpay _razorpay = Razorpay();

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

  //function to pay
  void onPay() {
    var options = {
      'key': 'rzp_test_FSFnXQOqPP1YbJ',
      'amount': cartScreenController.totalSellingPrice,
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'}
    };
    //To open payment portal
    _razorpay.open(options);
  }

  @override
  void onInit() {
    super.onInit();
    initializeData();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  //Function to add order details to orders collection
  Future<void> placeOrder(String orderId) async {
    try {
      Map<String, dynamic> details = {
        'orderId': orderId,
        'productIds': cartScreenController.productIds,
        'name': name,
        'address': address,
        'pincode': pincode,
        'mobile': _auth.currentUser!.phoneNumber,
        'status': 0,
        'time': FieldValue.serverTimestamp(),
      };
      await _firestore.collection('orders').add(details);
    } catch (e) {
      print(e.toString());
    }
  }

  //Function to add order to myorders collection
  Future<void> addToMyOrders(String orderId) async {
    try {
      for (var i = 0; i < cartScreenController.productsDetails.length; i++) {
        Map<String, dynamic> orderDetails = {
          'img': cartScreenController.productsDetails[i].img,
          'name': cartScreenController.productsDetails[i].title,
          'orderId': orderId,
          'total_Price': cartScreenController.productsDetails[i].totalPrice,
          'paid_amount': cartScreenController.productsDetails[i].sellingPrice,
          'status': 0,
          'order_on': FieldValue.serverTimestamp(),
          'deliver_on': FieldValue.serverTimestamp(),
        };

        await _firestore
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .collection('myorders')
            .add(orderDetails);
      }
    } catch (e) {
      print(e);
    }
  }

//Razorpay Functions
  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    await Future.wait([
      placeOrder(response.orderId ?? ""),
      addToMyOrders(response.orderId ?? ""),
    ]).then((value) {
      showAlert("Payment Successful");

      Get.to(() => HomeScreenView());
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    showAlert("Payment Failed");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    showAlert("Payment Failed");
  }
}
