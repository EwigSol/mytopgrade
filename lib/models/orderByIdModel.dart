// To parse this JSON data, do
//
//     final orderByIdModel = orderByIdModelFromJson(jsonString);

import 'dart:convert';

List<OrderByIdModel> orderByIdModelFromJson(String str) =>
    List<OrderByIdModel>.from(
        json.decode(str).map((x) => OrderByIdModel.fromJson(x)));

String orderByIdModelToJson(List<OrderByIdModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderByIdModel {
  OrderByIdModel({
    this.id,
    this.parentId,
    this.status,
    this.currency,
    this.version,
    this.pricesIncludeTax,
    this.dateCreated,
    this.dateModified,
    this.discountTotal,
    this.discountTax,
    this.shippingTotal,
    this.shippingTax,
    this.cartTax,
    this.total,
    this.totalTax,
    this.customerId,
    this.orderKey,
    this.billing,
    this.shipping,
    this.paymentMethod,
    this.paymentMethodTitle,
    this.transactionId,
    this.customerIpAddress,
    this.customerUserAgent,
    this.createdVia,
    this.customerNote,
    this.dateCompleted,
    this.datePaid,
    this.cartHash,
    this.number,
    this.metaData,
    this.lineItems,
    this.taxLines,
    this.shippingLines,
    this.feeLines,
    this.couponLines,
    this.refunds,
    this.dateCreatedGmt,
    this.dateModifiedGmt,
    this.dateCompletedGmt,
    this.datePaidGmt,
    this.currencySymbol,
    this.links,
  });

  var id;
  var parentId;
  var status;
  var currency;
  var version;
  var pricesIncludeTax;
  var dateCreated;
  var dateModified;
  var discountTotal;
  var discountTax;
  var shippingTotal;
  var shippingTax;
  var cartTax;
  var total;
  var totalTax;
  var customerId;
  var orderKey;
  var billing;
  var shipping;
  var paymentMethod;
  var paymentMethodTitle;
  var transactionId;
  var customerIpAddress;
  var customerUserAgent;
  var createdVia;
  var customerNote;
  var dateCompleted;
  var datePaid;
  var cartHash;
  var number;
  var metaData;
  var lineItems;
  var taxLines;
  var shippingLines;
  var feeLines;
  var couponLines;
  var refunds;
  var dateCreatedGmt;
  var dateModifiedGmt;
  var dateCompletedGmt;
  var datePaidGmt;
  var currencySymbol;
  var links;

  factory OrderByIdModel.fromJson(Map<String, dynamic> json) => OrderByIdModel(
        id: json["id"],
        parentId: json["parent_id"],
        status: statusValues.map[json["status"]],
        currency: currencyValues.map[json["currency"]],
        version: versionValues.map[json["version"]],
        pricesIncludeTax: json["prices_include_tax"],
        dateCreated: DateTime.parse(json["date_created"]),
        dateModified: DateTime.parse(json["date_modified"]),
        discountTotal: json["discount_total"],
        discountTax: json["discount_tax"],
        shippingTotal: json["shipping_total"],
        shippingTax: json["shipping_tax"],
        cartTax: json["cart_tax"],
        total: json["total"],
        totalTax: json["total_tax"],
        customerId: json["customer_id"],
        orderKey: json["order_key"],
        billing: Ing.fromJson(json["billing"]),
        shipping: Ing.fromJson(json["shipping"]),
        paymentMethod: paymentMethodValues.map[json["payment_method"]],
        paymentMethodTitle:
            paymentMethodTitleValues.map[json["payment_method_title"]],
        transactionId: json["transaction_id"],
        customerIpAddress:
            customerIpAddressValues.map[json["customer_ip_address"]],
        customerUserAgent: json["customer_user_agent"],
        createdVia: createdViaValues.map[json["created_via"]],
        customerNote: json["customer_note"],
        dateCompleted: json["date_completed"] == null
            ? null
            : DateTime.parse(json["date_completed"]),
        datePaid: json["date_paid"] == null
            ? null
            : DateTime.parse(json["date_paid"]),
        cartHash: cartHashValues.map[json["cart_hash"]],
        number: json["number"],
        metaData: List<OrderByIdModelMetaDatum>.from(
            json["meta_data"].map((x) => OrderByIdModelMetaDatum.fromJson(x))),
        lineItems: List<LineItem>.from(
            json["line_items"].map((x) => LineItem.fromJson(x))),
        taxLines: List<dynamic>.from(json["tax_lines"].map((x) => x)),
        shippingLines: List<dynamic>.from(json["shipping_lines"].map((x) => x)),
        feeLines: List<dynamic>.from(json["fee_lines"].map((x) => x)),
        couponLines: List<dynamic>.from(json["coupon_lines"].map((x) => x)),
        refunds: List<dynamic>.from(json["refunds"].map((x) => x)),
        dateCreatedGmt: DateTime.parse(json["date_created_gmt"]),
        dateModifiedGmt: DateTime.parse(json["date_modified_gmt"]),
        dateCompletedGmt: json["date_completed_gmt"] == null
            ? null
            : DateTime.parse(json["date_completed_gmt"]),
        datePaidGmt: json["date_paid_gmt"] == null
            ? null
            : DateTime.parse(json["date_paid_gmt"]),
        currencySymbol: currencySymbolValues.map[json["currency_symbol"]],
        links: Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parent_id": parentId,
        "status": statusValues.reverse[status],
        "currency": currencyValues.reverse[currency],
        "version": versionValues.reverse[version],
        "prices_include_tax": pricesIncludeTax,
        "date_created": dateCreated.toIso8601String(),
        "date_modified": dateModified.toIso8601String(),
        "discount_total": discountTotal,
        "discount_tax": discountTax,
        "shipping_total": shippingTotal,
        "shipping_tax": shippingTax,
        "cart_tax": cartTax,
        "total": total,
        "total_tax": totalTax,
        "customer_id": customerId,
        "order_key": orderKey,
        "billing": billing.toJson(),
        "shipping": shipping.toJson(),
        "payment_method": paymentMethodValues.reverse[paymentMethod],
        "payment_method_title":
            paymentMethodTitleValues.reverse[paymentMethodTitle],
        "transaction_id": transactionId,
        "customer_ip_address":
            customerIpAddressValues.reverse[customerIpAddress],
        "customer_user_agent": customerUserAgent,
        "created_via": createdViaValues.reverse[createdVia],
        "customer_note": customerNote,
        "date_completed":
            dateCompleted == null ? null : dateCompleted.toIso8601String(),
        "date_paid": datePaid == null ? null : datePaid.toIso8601String(),
        "cart_hash": cartHashValues.reverse[cartHash],
        "number": number,
        "meta_data": List<dynamic>.from(metaData.map((x) => x.toJson())),
        "line_items": List<dynamic>.from(lineItems.map((x) => x.toJson())),
        "tax_lines": List<dynamic>.from(taxLines.map((x) => x)),
        "shipping_lines": List<dynamic>.from(shippingLines.map((x) => x)),
        "fee_lines": List<dynamic>.from(feeLines.map((x) => x)),
        "coupon_lines": List<dynamic>.from(couponLines.map((x) => x)),
        "refunds": List<dynamic>.from(refunds.map((x) => x)),
        "date_created_gmt": dateCreatedGmt.toIso8601String(),
        "date_modified_gmt": dateModifiedGmt.toIso8601String(),
        "date_completed_gmt": dateCompletedGmt == null
            ? null
            : dateCompletedGmt.toIso8601String(),
        "date_paid_gmt":
            datePaidGmt == null ? null : datePaidGmt.toIso8601String(),
        "currency_symbol": currencySymbolValues.reverse[currencySymbol],
        "_links": links.toJson(),
      };
}

class Ing {
  Ing({
    this.firstName,
    this.lastName,
    this.company,
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.postcode,
    this.country,
    this.email,
    this.phone,
  });

  var firstName;
  var lastName;
  var company;
  var address1;
  var address2;
  var city;
  var state;
  var postcode;
  var country;
  var email;
  var phone;

  factory Ing.fromJson(Map<String, dynamic> json) => Ing(
        firstName: firstNameValues.map[json["first_name"]],
        lastName: lastNameValues.map[json["last_name"]],
        company: companyValues.map[json["company"]],
        address1: json["address_1"],
        address2: json["address_2"],
        city: json["city"],
        state: json["state"],
        postcode: json["postcode"],
        country: json["country"],
        email: json["email"] == null ? null : emailValues.map[json["email"]],
        phone: phoneValues.map[json["phone"]],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstNameValues.reverse[firstName],
        "last_name": lastNameValues.reverse[lastName],
        "company": companyValues.reverse[company],
        "address_1": address1,
        "address_2": address2,
        "city": city,
        "state": state,
        "postcode": postcode,
        "country": country,
        "email": email == null ? null : emailValues.reverse[email],
        "phone": phoneValues.reverse[phone],
      };
}

enum Company { EMPTY, COURSE }

final companyValues = EnumValues({"course": Company.COURSE, "": Company.EMPTY});

enum Email { HR_EWIGSOL_COM }

final emailValues = EnumValues({"hr@ewigsol.com": Email.HR_EWIGSOL_COM});

enum FirstName { JUSTCHECKING, CHECKING, EMPTY }

final firstNameValues = EnumValues({
  "checking": FirstName.CHECKING,
  "": FirstName.EMPTY,
  "justchecking": FirstName.JUSTCHECKING
});

enum LastName { JUSTCHECKING, THE, EMPTY }

final lastNameValues = EnumValues({
  "": LastName.EMPTY,
  "justchecking": LastName.JUSTCHECKING,
  "the": LastName.THE
});

enum Phone { THE_9231397897654, THE_923333883381, EMPTY }

final phoneValues = EnumValues({
  "": Phone.EMPTY,
  "+9231397897654": Phone.THE_9231397897654,
  "+923333883381": Phone.THE_923333883381
});

enum CartHash { EMPTY, THE_1519212_F389_D70_CB51_F821_C0_CC39_FE8_C }

final cartHashValues = EnumValues({
  "": CartHash.EMPTY,
  "1519212f389d70cb51f821c0cc39fe8c":
      CartHash.THE_1519212_F389_D70_CB51_F821_C0_CC39_FE8_C
});

enum CreatedVia { REST_API, CHECKOUT }

final createdViaValues = EnumValues(
    {"checkout": CreatedVia.CHECKOUT, "rest-api": CreatedVia.REST_API});

enum Currency { NGN }

final currencyValues = EnumValues({"NGN": Currency.NGN});

enum CurrencySymbol { EMPTY }

final currencySymbolValues = EnumValues({"₦": CurrencySymbol.EMPTY});

enum CustomerIpAddress { EMPTY, THE_18218519368 }

final customerIpAddressValues = EnumValues({
  "": CustomerIpAddress.EMPTY,
  "182.185.193.68": CustomerIpAddress.THE_18218519368
});

class LineItem {
  LineItem({
    this.id,
    this.name,
    this.productId,
    this.variationId,
    this.quantity,
    this.taxClass,
    this.subtotal,
    this.subtotalTax,
    this.total,
    this.totalTax,
    this.taxes,
    this.metaData,
    this.sku,
    this.price,
    this.parentName,
  });

  var id;
  var name;
  var productId;
  var variationId;
  var quantity;
  var taxClass;
  var subtotal;
  var subtotalTax;
  var total;
  var totalTax;
  var taxes;
  var metaData;
  var sku;
  var price;
  var parentName;

  factory LineItem.fromJson(Map<String, dynamic> json) => LineItem(
        id: json["id"],
        name: nameValues.map[json["name"]],
        productId: json["product_id"],
        variationId: json["variation_id"],
        quantity: json["quantity"],
        taxClass: json["tax_class"],
        subtotal: json["subtotal"],
        subtotalTax: json["subtotal_tax"],
        total: json["total"],
        totalTax: json["total_tax"],
        taxes: List<dynamic>.from(json["taxes"].map((x) => x)),
        metaData: List<LineItemMetaDatum>.from(
            json["meta_data"].map((x) => LineItemMetaDatum.fromJson(x))),
        sku: json["sku"],
        price: json["price"],
        parentName: json["parent_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse[name],
        "product_id": productId,
        "variation_id": variationId,
        "quantity": quantity,
        "tax_class": taxClass,
        "subtotal": subtotal,
        "subtotal_tax": subtotalTax,
        "total": total,
        "total_tax": totalTax,
        "taxes": List<dynamic>.from(taxes.map((x) => x)),
        "meta_data": List<dynamic>.from(metaData.map((x) => x.toJson())),
        "sku": sku,
        "price": price,
        "parent_name": parentName,
      };
}

class LineItemMetaDatum {
  LineItemMetaDatum({
    this.id,
    this.key,
    this.value,
    this.displayKey,
    this.displayValue,
  });

  var id;
  var key;
  var value;
  var displayKey;
  var displayValue;

  factory LineItemMetaDatum.fromJson(Map<String, dynamic> json) =>
      LineItemMetaDatum(
        id: json["id"],
        key: json["key"],
        value: json["value"],
        displayKey: json["display_key"],
        displayValue: json["display_value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "key": key,
        "value": value,
        "display_key": displayKey,
        "display_value": displayValue,
      };
}

enum Name { SSS2_SCIENCE_COMBO, SSS3_VIDEO_LESSONS }

final nameValues = EnumValues({
  "SSS2 Science Combo": Name.SSS2_SCIENCE_COMBO,
  "SSS3 Video Lessons": Name.SSS3_VIDEO_LESSONS
});

class Links {
  Links({
    this.self,
    this.collection,
    this.customer,
  });

  var self;
  var collection;
  var customer;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: List<Collection>.from(
            json["self"].map((x) => Collection.fromJson(x))),
        collection: List<Collection>.from(
            json["collection"].map((x) => Collection.fromJson(x))),
        customer: List<Collection>.from(
            json["customer"].map((x) => Collection.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "self": List<dynamic>.from(self.map((x) => x.toJson())),
        "collection": List<dynamic>.from(collection.map((x) => x.toJson())),
        "customer": List<dynamic>.from(customer.map((x) => x.toJson())),
      };
}

class Collection {
  Collection({
    this.href,
  });

  var href;

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "href": href,
      };
}

class OrderByIdModelMetaDatum {
  OrderByIdModelMetaDatum({
    this.id,
    this.key,
    this.value,
  });

  var id;
  var key;
  var value;

  factory OrderByIdModelMetaDatum.fromJson(Map<String, dynamic> json) =>
      OrderByIdModelMetaDatum(
        id: json["id"],
        key: keyValues.map[json["key"]],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "key": keyValues.reverse[key],
        "value": value,
      };
}

enum Key {
  IS_VAT_EXEMPT,
  STATE,
  NEW_ORDER_EMAIL_SENT,
  SLIDE_TEMPLATE,
  RS_PAGE_BG_COLOR,
  LEARN_PRESS_ORDER_ID
}

final keyValues = EnumValues({
  "is_vat_exempt": Key.IS_VAT_EXEMPT,
  "_learn_press_order_id": Key.LEARN_PRESS_ORDER_ID,
  "_new_order_email_sent": Key.NEW_ORDER_EMAIL_SENT,
  "rs_page_bg_color": Key.RS_PAGE_BG_COLOR,
  "slide_template": Key.SLIDE_TEMPLATE,
  "state": Key.STATE
});

enum PaymentMethod { BACS }

final paymentMethodValues = EnumValues({"bacs": PaymentMethod.BACS});

enum PaymentMethodTitle { DIRECT_BANK_TRANSFER }

final paymentMethodTitleValues = EnumValues(
    {"Direct bank transfer": PaymentMethodTitle.DIRECT_BANK_TRANSFER});

enum Status { COMPLETED, ON_HOLD }

final statusValues =
    EnumValues({"completed": Status.COMPLETED, "on-hold": Status.ON_HOLD});

enum Version { THE_590 }

final versionValues = EnumValues({"5.9.0": Version.THE_590});

class EnumValues<T> {
  var map;
  var reverseMap;
  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
