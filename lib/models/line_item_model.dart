

import 'dart:convert';

List<LineItemModel> lineItemModelFromJson(String str) => List<LineItemModel>.from(json.decode(str).map((x) => LineItemModel.fromJson(x)));

String lineItemModelToJson(List<LineItemModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LineItemModel {
  LineItemModel({
    this.productId,
    this.quantity,
  });

  int? productId;
  int? quantity;

  factory LineItemModel.fromJson(Map<String, dynamic> json) => LineItemModel(
    productId: json["product_id"],
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "quantity": quantity,
  };
}
