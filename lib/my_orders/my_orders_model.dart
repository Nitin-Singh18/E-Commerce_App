class MyOrdersModel {
  late String deliveryOn, image, name, orderId, orderOn;
  late int totalPrice, paidAmount, status;

  MyOrdersModel({
    required this.deliveryOn,
    required this.image,
    required this.name,
    required this.orderId,
    required this.orderOn,
    required this.paidAmount,
    required this.status,
    required this.totalPrice,
  });

  MyOrdersModel.fromJson(Map<String, dynamic> map) {
    deliveryOn = map['deliver_on'].toString();
    image = map['img'];
    name = map['name'];
    orderId = map['orderId'];
    orderOn = map['order_on'].toString();
    paidAmount = map['paid_amount'];
    status = map['status'];
    totalPrice = map['total_Price'];
  }
}
