import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/item-screen/items_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ItemScreenController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ScrollController scrollController = ScrollController();

  String categoryId = "";

  String categoryTitle = "";

  List<ItemsModel> itemsData = [];

  List<ItemsModel> searchResults = [];

  bool isLoading = true, isSearchLoading = false;

  bool hasMoreData = true;
  var isLoading1 = false.obs;
  DocumentSnapshot? lastDocument;
  int documentLimit = 7;

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
        print(categoryId);
        print(categoryTitle);

        update();
      });
    } catch (e) {
      print(e);
    }
  }

  void getPaginatedData() async {
    if (hasMoreData) {
      if (!isLoading1.value) {
        await getSubCategoryDataInParts();
      }
    } else {
      print("No more data");
    }
  }

  //function to get data in parts

  Future<void> getSubCategoryDataInParts() async {
    if (lastDocument == null) {
      await _firestore
          .collection('categories')
          .doc(categoryId)
          .collection(categoryTitle)
          .orderBy('title')
          .limit(documentLimit)
          .get()
          .then((value) {
        //Here we have used tha addAll function in place of = because here
        //we are getting data in parts. Therefore, this function will append
        //the data to the last position of list.
        itemsData.addAll(
          value.docs.map(
            (e) => ItemsModel.fromJson(e.data()),
          ),
        );

        isLoading = false;

        update();

        lastDocument = value.docs.last;

        if (value.docs.length < documentLimit) {
          hasMoreData = false;
        }
      });
    } else {
      isLoading1.value = true;

      await _firestore
          .collection('categories')
          .doc(categoryId)
          .collection(categoryTitle)
          .orderBy('title')
          .startAfterDocument(lastDocument!)
          .limit(documentLimit)
          .get()
          .then((value) {
        itemsData.addAll(value.docs.map((e) => ItemsModel.fromJson(e.data())));

        isLoading1.value = false;

        update();

        lastDocument = value.docs.last;
        if (value.docs.length < documentLimit) {
          hasMoreData = false;
        }
      });
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

  @override
  void onInit() {
    super.onInit();

    scrollController.addListener(() {
      double maxScrollExtent = scrollController.position.maxScrollExtent;
      double currentPosition = scrollController.position.pixels;
      double height20 = Get.size.height * 0.20;

      if (maxScrollExtent - currentPosition <= height20) {
        getPaginatedData();
      }
    });
  }
}
