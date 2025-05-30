import 'AttributeModel.dart';

class DeleteReviewResponse {
  Links? links;
  String? dateCreated;
  String? dateCreatedGmt;
  int? id;
  int? productId;
  int? rating;
  String? review;
  String? reviewer;
  String? reviewerEmail;
  String? status;
  bool? verified;

  DeleteReviewResponse({this.links, this.dateCreated, this.dateCreatedGmt, this.id, this.productId, this.rating, this.review, this.reviewer, this.reviewerEmail, this.status, this.verified});

  factory DeleteReviewResponse.fromJson(Map<String, dynamic> json) {
    return DeleteReviewResponse(
      links: json['_links'] != null ? Links.fromJson(json['_links']) : null,
      dateCreated: json['date_created'],
      dateCreatedGmt: json['date_created_gmt'],
      id: json['id'],
      productId: json['product_id'],
      rating: json['rating'],
      review: json['review'],
      reviewer: json['reviewer'],
      reviewerEmail: json['reviewer_email'],
      status: json['status'],
      verified: json['verified'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date_created'] = this.dateCreated;
    data['date_created_gmt'] = this.dateCreatedGmt;
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['rating'] = this.rating;
    data['review'] = this.review;
    data['reviewer'] = this.reviewer;
    data['reviewer_email'] = this.reviewerEmail;
    data['status'] = this.status;
    data['verified'] = this.verified;
    if (this.links != null) {
      data['_links'] = this.links!.toJson();
    }
    return data;
  }
}
/*

class Links {
  List<Collection>? collection;
  List<Self>? self;
  List<Up>? up;

  Links({this.collection, this.self, this.up});

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      collection: json['collection'] != null ? (json['collection'] as List).map((i) => Collection.fromJson(i)).toList() : null,
      self: json['self'] != null ? (json['self'] as List).map((i) => Self.fromJson(i)).toList() : null,
      up: json['up'] != null ? (json['up'] as List).map((i) => Up.fromJson(i)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.collection != null) {
      data['collection'] = this.collection!.map((v) => v.toJson()).toList();
    }
    if (this.self != null) {
      data['self'] = this.self!.map((v) => v.toJson()).toList();
    }
    if (this.up != null) {
      data['up'] = this.up!.map((v) => v.toJson()).toList();
    }
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

class Up {
  String? href;

  Up({this.href});

  factory Up.fromJson(Map<String, dynamic> json) {
    return Up(
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
*/
