import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/item-screen/items_model.dart';
import 'package:get/get.dart';

class ItemScreenController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String categoryId = "";

  String categoryTitle = "";

  List<ItemsModel> itemsData = [];

  List<ItemsModel> searchResults = [];

  bool isLoading = true, isSearchLoading = false;

  //Function to get data for item screen

  Future<void> getSubCategoryData() async {
    try {
      await _firestore
          .collection("categories")
          .doc(categoryId)
          .collection(categoryTitle)
          .get()
          .then((value) {
        itemsData =
            value.docs.map((e) => ItemsModel.fromJson(e.data())).toList();

        isLoading = false;
        // print(itemsData[0]);
        print(categoryId);
        print(categoryTitle);

        update();
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

  //Function to search for products from database

  Future<void> searchProducts(String query) async {
    //this block is being used so that it'll will update the GetBuilder when
    //there is any text in search bar otherwise it'll throw an error.

    if (query.isNotEmpty) {
      isSearchLoading = true;
      Future.delayed(Duration.zero, () {
        update();
      });
    }
    try {
      await _firestore
          .collection('categories')
          .doc(categoryId)
          .collection(categoryTitle)
          .where('title', isGreaterThanOrEqualTo: query)
          .get()
          .then((value) {
        searchResults =
            value.docs.map((e) => ItemsModel.fromJson(e.data())).toList();
        isSearchLoading = false;
        update();
      });
    } catch (e) {
      print(e);
    }
  }
}
