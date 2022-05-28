

import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/cart_model.dart';



// cart table
const String tableCart = 'tbl_cart';
const String columnId = 'id';
const String productId = 'productId';
const String quantity = 'quantity';
const String productName = 'productName';
const String productImage = 'productImage';
const String productPrice = 'productPrice';

class CartController extends GetxController {

  var totalPrice = 0.obs;
  late Database db;
  var isLoading = false.obs;
  var totalItem = 0.obs;
  var totalPrize = 0.obs;
  var products = <Map>[].obs;

  addPrize(val) {
    totalPrize(int.parse((totalPrize.value + val).toString())).obs;
  }

  Future open() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
              '''
              create table $tableCart (
              $columnId integer primary key autoincrement,
              $productId text not null,
              $quantity integer not null,
              $productName text not null,
              $productImage text not null,
              $productPrice double not null)
              ''');
        });
  }

  Future<CartModel> insert(CartModel cart) async {
    bool found = false;
    int q = 0;
    isLoading(true).obs;
    final items = await getCartItems();
    if (items != null) {
      for (var item in items) {
        if (item["productId"] == cart.productId) {
          found = true;
          q = item["quantity"];
        }
      }
    }
    if (found) {
      CartModel cart1 = CartModel(quantity: q + 1, price: cart.price, image: cart.image, name: cart.name, productId: cart.productId);
      updateCart(cart1);
    } else {
      cart.id = await db.insert(tableCart, cart.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    }

    getCount();
    isLoading(false).obs;
    return cart;
  }

  getCount() async {
    isLoading(true).obs;
    int? count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $tableCart'));
    totalItem.value = count!;
    isLoading(false).obs;
  }

  clearData() {
    db.execute("delete from " + tableCart);
  }

  getCartItems() async {
    totalPrice(0).obs;

    /// we will make the product equal to null here
    isLoading(true).obs;
    List<Map> maps = await db.query(
      tableCart, columns: [columnId, quantity, productId, productName, productImage, productPrice],
    );
    if (maps.isNotEmpty) {
      products.value = maps;
      for (var item in maps) {
        var price = (totalPrice.value).toInt() + ((item["quantity"]) * (item["productPrice"])).toInt();
        totalPrice(int.parse(price.toString())).obs;
      }
      isLoading(false).obs;
      return maps;
    }
    isLoading(false).obs;
    return null;
  }

  Future<int> delete({required int id}) async {
    final result =
    await db.delete(tableCart, where: '$productId = ?', whereArgs: [id]);
    getCount();
    getCartItems();
    return result;
  }

  Future<int> updateCart(CartModel cart) async {
    final result = await db.update(tableCart, cart.toMap(), where: '$productId = ?', whereArgs: [cart.productId]);
    getCount();
    getCartItems();
    return result;
  }

  Future close() async => db.close();

}
