class ItemsModel {
  late String id, image, title;

  late int totalPrice, sellingPrice;
  ItemsModel(
      {required this.id,
      required this.image,
      required this.title,
      required this.sellingPrice,
      required this.totalPrice});

  ItemsModel.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    image = map['img'];
    sellingPrice = map['sell_price'];
    totalPrice = map['total_price'];
  }
}
