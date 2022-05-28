

class CartModel {
  int? id;
  String? productId;
  int? quantity;
  String? image;
  String? name;
  double? price;

  CartModel({this.productId, this.quantity, this.name, this.image, this.price});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "productId": productId,
      "quantity": quantity,
      "productName": name,
      "productPrice": price,
      "productImage": image
    };
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

  CartModel.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    productId = map["productId"];
    quantity = map["quantity"];
    name = map["productName"];
    price = map["productPrice"];
    image = map["productImage"];
  }

}
