import '../models/OrderResponse.dart';

class VendorModel {
  List<OrderResponse>? order;
  OrderSummary? orderSummary;
  ProductSummary? productSummary;

  VendorModel({this.order, this.orderSummary, this.productSummary});

  factory VendorModel.fromJson(Map<String, dynamic> json) {
    return VendorModel(
      order: json['order'] != null ? (json['order'] as List).map((i) => OrderResponse.fromJson(i)).toList() : null,
      orderSummary: json['order_summary'] != null ? OrderSummary.fromJson(json['order_summary']) : null,
      productSummary: json['product_summary'] != null ? ProductSummary.fromJson(json['product_summary']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.order != null) {
      data['order'] = this.order!.map((v) => v.toJson()).toList();
    }
    if (this.orderSummary != null) {
      data['order_summary'] = this.orderSummary!.toJson();
    }
    if (this.productSummary != null) {
      data['product_summary'] = this.productSummary!.toJson();
    }
    return data;
  }
}

class Links {
  List<Collection>? collection;
  List<Customer>? customer;
  List<Self>? self;

  Links({this.collection, this.customer, this.self});

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      collection: json['collection'] != null ? (json['collection'] as List).map((i) => Collection.fromJson(i)).toList() : null,
      customer: json['customer'] != null ? (json['customer'] as List).map((i) => Customer.fromJson(i)).toList() : null,
      self: json['self'] != null ? (json['self'] as List).map((i) => Self.fromJson(i)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.collection != null) {
      data['collection'] = this.collection!.map((v) => v.toJson()).toList();
    }
    if (this.customer != null) {
      data['customer'] = this.customer!.map((v) => v.toJson()).toList();
    }
    if (this.self != null) {
      data['self'] = this.self!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Customer {
  String? href;

  Customer({this.href});

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      href: json['href'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    return data;
  }
}

class Self {
  String? href;

  Self({this.href});

  factory Self.fromJson(Map<String, dynamic> json) {
    return Self(
      href: json['href'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    return data;
  }
}

class Collection {
  String? href;

  Collection({this.href});

  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(
      href: json['href'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    return data;
  }
}

class LineItem {
  int? id;
  List<MetaDataX>? metaData;
  String? name;
  int? price;
  int? productId;
  int? quantity;
  String? sku;
  String? subtotal;
  String? subtotalTax;
  String? taxClass;
  String? total;
  String? totalTax;
  int? variationId;

  LineItem({this.id, this.metaData, this.name, this.price, this.productId, this.quantity, this.sku, this.subtotal, this.subtotalTax, this.taxClass, this.total, this.totalTax, this.variationId});

  factory LineItem.fromJson(Map<String, dynamic> json) {
    return LineItem(
      id: json['id'],
      metaData: json['meta_data'] != null ? (json['meta_data'] as List).map((i) => MetaDataX.fromJson(i)).toList() : null,
      name: json['name'],
      price: json['price'],
      productId: json['product_id'],
      quantity: json['quantity'],
      sku: json['sku'],
      subtotal: json['subtotal'],
      subtotalTax: json['subtotal_tax'],
      taxClass: json['tax_class'],
      total: json['total'],
      totalTax: json['total_tax'],
      variationId: json['variation_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['sku'] = this.sku;
    data['subtotal'] = this.subtotal;
    data['subtotal_tax'] = this.subtotalTax;
    data['tax_class'] = this.taxClass;
    data['total'] = this.total;
    data['total_tax'] = this.totalTax;
    data['variation_id'] = this.variationId;
    if (this.metaData != null) {
      data['meta_data'] = this.metaData!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class MetaData {
  int? id;
  String? key;
  String? value;

  MetaData({this.id, this.key, this.value});

  factory MetaData.fromJson(Map<String, dynamic> json) {
    return MetaData(
      id: json['id'],
      key: json['key'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['key'] = this.key;
    data['value'] = this.value;
    return data;
  }
}

class Shipping {
  String? address_1;
  String? address_2;
  String? city;
  String? company;
  String? country;
  String? firstName;
  String? lastName;
  String? postcode;
  String? state;

  Shipping({this.address_1, this.address_2, this.city, this.company, this.country, this.firstName, this.lastName, this.postcode, this.state});

  factory Shipping.fromJson(Map<String, dynamic> json) {
    return Shipping(
      address_1: json['address_1'],
      address_2: json['address_2'],
      city: json['city'],
      company: json['company'],
      country: json['country'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      postcode: json['postcode'],
      state: json['state'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_1'] = this.address_1;
    data['address_2'] = this.address_2;
    data['city'] = this.city;
    data['company'] = this.company;
    data['country'] = this.country;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['postcode'] = this.postcode;
    data['state'] = this.state;
    return data;
  }
}

class MetaDataX {
  int? id;
  String? key;
  String? value;

  MetaDataX({this.id, this.key, this.value});

  factory MetaDataX.fromJson(Map<String, dynamic> json) {
    return MetaDataX(
      id: json['id'],
      key: json['key'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['key'] = this.key;
    data['value'] = this.value;
    return data;
  }
}

class Billing {
  String? address_1;
  String? address_2;
  String? city;
  String? company;
  String? country;
  String? email;
  String? firstName;
  String? lastName;
  String? phone;
  String? postcode;
  String? state;

  Billing({this.address_1, this.address_2, this.city, this.company, this.country, this.email, this.firstName, this.lastName, this.phone, this.postcode, this.state});

  factory Billing.fromJson(Map<String, dynamic> json) {
    return Billing(
      address_1: json['address_1'],
      address_2: json['address_2'],
      city: json['city'],
      company: json['company'],
      country: json['country'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phone: json['phone'],
      postcode: json['postcode'],
      state: json['state'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_1'] = this.address_1;
    data['address_2'] = this.address_2;
    data['city'] = this.city;
    data['company'] = this.company;
    data['country'] = this.country;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone'] = this.phone;
    data['postcode'] = this.postcode;
    data['state'] = this.state;
    return data;
  }
}

class OrderSummary {
  int? total;
  int? wcCancelled;
  int? wcCompleted;
  int? wcFailed;
  int? wcOnHold;
  int? wcPending;
  int? wcProcessing;
  int? wcRefunded;

  OrderSummary({this.total, this.wcCancelled, this.wcCompleted, this.wcFailed, this.wcOnHold, this.wcPending, this.wcProcessing, this.wcRefunded});

  factory OrderSummary.fromJson(Map<String, dynamic> json) {
    return OrderSummary(
      total: json['total'],
      wcCancelled: json['wc-cancelled'],
      wcCompleted: json['wc-completed'],
      wcFailed: json['wc-failed'],
      wcOnHold: json['wc-on-hold'],
      wcPending: json['wc-pending'],
      wcProcessing: json['wc-processing'],
      wcRefunded: json['wc-refunded'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['wc-cancelled'] = this.wcCancelled;
    data['wc-completed'] = this.wcCompleted;
    data['wc-failed'] = this.wcFailed;
    data['wc-on-hold'] = this.wcOnHold;
    data['wc-pending'] = this.wcPending;
    data['wc-processing'] = this.wcProcessing;
    data['wc-refunded'] = this.wcRefunded;
    return data;
  }
}

class ProductSummary {
  PostCounts? postCounts;
  String? productsUrl;

  ProductSummary({this.postCounts, this.productsUrl});

  factory ProductSummary.fromJson(Map<String, dynamic> json) {
    return ProductSummary(
      postCounts: json['post_counts'] != null ? PostCounts.fromJson(json['post_counts']) : null,
      productsUrl: json['products_url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['products_url'] = this.productsUrl;
    if (this.postCounts != null) {
      data['post_counts'] = this.postCounts!.toJson();
    }
    return data;
  }
}

class PostCounts {
  int? private;
  int? autoDraft;
  int? draft;
  int? future;
  int? inherit;
  int? pending;
  int? publish;
  int? requestCompleted;
  int? requestConfirmed;
  int? requestFailed;
  int? requestPending;
  int? total;
  int? trash;

  PostCounts({this.private, this.autoDraft, this.draft, this.future, this.inherit, this.pending, this.publish, this.requestCompleted, this.requestConfirmed, this.requestFailed, this.requestPending, this.total, this.trash});

  factory PostCounts.fromJson(Map<String, dynamic> json) {
    return PostCounts(
      private: json['private'],
      autoDraft: json['auto-draft'],
      draft: json['draft'],
      future: json['future'],
      inherit: json['inherit'],
      pending: json['pending'],
      publish: json['publish'],
      requestCompleted: json['request-completed'],
      requestConfirmed: json['request-confirmed'],
      requestFailed: json['request-failed'],
      requestPending: json['request-pending'],
      total: json['total'],
      trash: json['trash'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['private'] = this.private;
    data['auto-draft'] = this.autoDraft;
    data['draft'] = this.draft;
    data['future'] = this.future;
    data['inherit'] = this.inherit;
    data['pending'] = this.pending;
    data['publish'] = this.publish;
    data['request-completed'] = this.requestCompleted;
    data['request-confirmed'] = this.requestConfirmed;
    data['request-failed'] = this.requestFailed;
    data['request-pending'] = this.requestPending;
    data['total'] = this.total;
    data['trash'] = this.trash;
    return data;
  }
}
