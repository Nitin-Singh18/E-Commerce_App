import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/home_screen/model/banner_model.dart';
import 'package:e_commerce/home_screen/model/categories_model.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late List<BannerDataModel> bannerData;
  late List<CategoriesModel> categoriesData;
  late List<CategoriesModel> featuredData;

  bool isLoading = true;

  List<RxBool> isSelected = [];

  //In this function, we are calling all the getData functions.

  void getAllData() async {
    //Here wait function is being used to Wait for multiple futures(All the
    //getData Functions) to complete and collects their results.

    await Future.wait([
      getBannerData(),
      getAllCategories(),
      getFeaturedData(),
    ]).then((value) {
      print("Data");
      print(bannerData[0].image);
      print(categoriesData[0].id);
      print(featuredData[1].id);
      isLoading = false;
      update();
    });
  }

  void changeIndicator(int index) {
    for (var i = 0; i < isSelected.length; i++) {
      if (isSelected[i].value) {
        isSelected[i].value = false;
      }
    }
    isSelected[index].value = true;
  }

  //This function will get the data present in firebase database's collection
  //called banner.

  Future<void> getBannerData() async {
    await _firestore.collection('banner').get().then(
      (value) {
        //docs function is used to convert the value from QuerySnapshot to List.
        //Then the map function will map each elment of the list.
        //data() is used to convert the element from QueryDocumentSnapshot to
        //map.

        bannerData =
            value.docs.map((e) => BannerDataModel.fromJson(e.data())).toList();

        for (var i = 0; i < bannerData.length; i++) {
          isSelected.add(false.obs);
        }
        isSelected[0].value = true;
      },
    );
  }

  //This function will get the data present in firebase database's collection
  //called categories.

  Future<void> getAllCategories() async {
    await _firestore.collection('categories').get().then((value) {
      categoriesData =
          value.docs.map((e) => CategoriesModel.fromJson(e.data())).toList();
    });
  }

  //This function will get the data present in firebase database's collection
  //called categories.

  Future<void> getFeaturedData() async {
    await _firestore.collection('featured').get().then((value) {
      featuredData =
          value.docs.map((e) => CategoriesModel.fromJson(e.data())).toList();
    });
  }

  //This function is immediately called after widgets get build.

  @override
  void onInit() {
    super.onInit();
    getAllData();
  }
}
