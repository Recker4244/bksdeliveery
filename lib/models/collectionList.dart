class collectionList {
  Address address;
  BuySell buySell;
  Cart cart;
  String consignment;
  String createdAt;
  String deliveryCharge;
  String docType;
  String id;
  int instantGoldApplied;
  String otp;
  int redeemGoldApplied;
  String status;
  int totalCharges;
  Transactions transactions;
  String updatedAt;
  User user;

  collectionList(
      {this.address,
      this.buySell,
      this.cart,
      this.consignment,
      this.createdAt,
      this.deliveryCharge,
      this.docType,
      this.id,
      this.instantGoldApplied,
      this.otp,
      this.redeemGoldApplied,
      this.status,
      this.totalCharges,
      this.transactions,
      this.updatedAt,
      this.user});

  collectionList.fromJson(Map<String, dynamic> json) {
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    buySell =
        json['buySell'] != null ? new BuySell.fromJson(json['buySell']) : null;
    cart = json['cart'] != null ? new Cart.fromJson(json['cart']) : null;
    consignment = json['consignment'];
    createdAt = json['createdAt'];
    deliveryCharge = json['deliveryCharge'];
    docType = json['docType'];
    id = json['id'];
    instantGoldApplied = json['instantGoldApplied'];
    otp = json['otp'];
    redeemGoldApplied = json['redeemGoldApplied'];
    status = json['status'];
    totalCharges = json['totalCharges'];
    transactions = json['transactions'] != null
        ? new Transactions.fromJson(json['transactions'])
        : null;
    updatedAt = json['updatedAt'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    if (this.buySell != null) {
      data['buySell'] = this.buySell.toJson();
    }
    if (this.cart != null) {
      data['cart'] = this.cart.toJson();
    }
    data['consignment'] = this.consignment;
    data['createdAt'] = this.createdAt;
    data['deliveryCharge'] = this.deliveryCharge;
    data['docType'] = this.docType;
    data['id'] = this.id;
    data['instantGoldApplied'] = this.instantGoldApplied;
    data['otp'] = this.otp;
    data['redeemGoldApplied'] = this.redeemGoldApplied;
    data['status'] = this.status;
    data['totalCharges'] = this.totalCharges;
    if (this.transactions != null) {
      data['transactions'] = this.transactions.toJson();
    }
    data['updatedAt'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class Address {
  String addressType;
  String createdAt;
  String docType;
  String id;
  bool isDefaultAddress;
  String landMark;
  int pin;
  String updatedAt;
  String user;

  Address(
      {this.addressType,
      this.createdAt,
      this.docType,
      this.id,
      this.isDefaultAddress,
      this.landMark,
      this.pin,
      this.updatedAt,
      this.user});

  Address.fromJson(Map<String, dynamic> json) {
    addressType = json['addressType'];
    createdAt = json['createdAt'];
    docType = json['docType'];
    id = json['id'];
    isDefaultAddress = json['isDefaultAddress'];
    landMark = json['landMark'];
    pin = json['pin'];
    updatedAt = json['updatedAt'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['addressType'] = this.addressType;
    data['createdAt'] = this.createdAt;
    data['docType'] = this.docType;
    data['id'] = this.id;
    data['isDefaultAddress'] = this.isDefaultAddress;
    data['landMark'] = this.landMark;
    data['pin'] = this.pin;
    data['updatedAt'] = this.updatedAt;
    data['user'] = this.user;
    return data;
  }
}

class BuySell {
  int buy;
  String createdAt;
  String docType;
  String id;
  int sell;
  String updatedAt;

  BuySell(
      {this.buy,
      this.createdAt,
      this.docType,
      this.id,
      this.sell,
      this.updatedAt});

  BuySell.fromJson(Map<String, dynamic> json) {
    buy = json['buy'];
    createdAt = json['createdAt'];
    docType = json['docType'];
    id = json['id'];
    sell = json['sell'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['buy'] = this.buy;
    data['createdAt'] = this.createdAt;
    data['docType'] = this.docType;
    data['id'] = this.id;
    data['sell'] = this.sell;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Cart {
  String createdAt;
  String docType;
  String id;
  List<Items> items;
  String updatedAt;
  String user;

  Cart(
      {this.createdAt,
      this.docType,
      this.id,
      this.items,
      this.updatedAt,
      this.user});

  Cart.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    docType = json['docType'];
    id = json['id'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
    updatedAt = json['updatedAt'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['docType'] = this.docType;
    data['id'] = this.id;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    data['updatedAt'] = this.updatedAt;
    data['user'] = this.user;
    return data;
  }
}

class Items {
  ItemDetail itemDetail;
  int quantity;

  Items({this.itemDetail, this.quantity});

  Items.fromJson(Map<String, dynamic> json) {
    itemDetail = json['itemDetail'] != null
        ? new ItemDetail.fromJson(json['itemDetail'])
        : null;
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.itemDetail != null) {
      data['itemDetail'] = this.itemDetail.toJson();
    }
    data['quantity'] = this.quantity;
    return data;
  }
}

class ItemDetail {
  String sKU;
  String category;
  List<Charges> charges;
  String collections;
  List<Composition> composition;
  String createdAt;
  String description;
  String docType;
  double grossweight;
  String id;
  Item item;
  String measurements;
  String product;
  String ringsize;
  int units;
  String updatedAt;
  String variety;

  ItemDetail(
      {this.sKU,
      this.category,
      this.charges,
      this.collections,
      this.composition,
      this.createdAt,
      this.description,
      this.docType,
      this.grossweight,
      this.id,
      this.item,
      this.measurements,
      this.product,
      this.ringsize,
      this.units,
      this.updatedAt,
      this.variety});

  ItemDetail.fromJson(Map<String, dynamic> json) {
    sKU = json['SKU'];
    category = json['category'];
    if (json['charges'] != null) {
      charges = <Charges>[];
      json['charges'].forEach((v) {
        charges.add(new Charges.fromJson(v));
      });
    }
    collections = json['collections'];
    if (json['composition'] != null) {
      composition = <Composition>[];
      json['composition'].forEach((v) {
        composition.add(new Composition.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    description = json['description'];
    docType = json['docType'];
    grossweight = json['grossweight'];
    id = json['id'];
    item = json['item'] != null ? new Item.fromJson(json['item']) : null;
    measurements = json['measurements'];
    product = json['product'];
    ringsize = json['ringsize'];
    units = json['units'];
    updatedAt = json['updatedAt'];
    variety = json['variety'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SKU'] = this.sKU;
    data['category'] = this.category;
    if (this.charges != null) {
      data['charges'] = this.charges.map((v) => v.toJson()).toList();
    }
    data['collections'] = this.collections;
    if (this.composition != null) {
      data['composition'] = this.composition.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['description'] = this.description;
    data['docType'] = this.docType;
    data['grossweight'] = this.grossweight;
    data['id'] = this.id;
    if (this.item != null) {
      data['item'] = this.item.toJson();
    }
    data['measurements'] = this.measurements;
    data['product'] = this.product;
    data['ringsize'] = this.ringsize;
    data['units'] = this.units;
    data['updatedAt'] = this.updatedAt;
    data['variety'] = this.variety;
    return data;
  }
}

class Charges {
  int percentage;
  String status;
  String type;
  String createdAt;
  String docType;
  String id;
  String updatedAt;

  Charges({
    this.percentage,
    this.status,
    this.type,
    this.createdAt,
    this.docType,
    this.id,
    this.updatedAt,
  });

  Charges.fromJson(Map<String, dynamic> json) {
    percentage = json['Percentage'];
    status = json['Status'];
    type = json['Type'];
    createdAt = json['createdAt'];
    docType = json['docType'];
    id = json['id'];
    updatedAt = json['updatedAt'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Percentage'] = this.percentage;
    data['Status'] = this.status;
    data['Type'] = this.type;
    data['createdAt'] = this.createdAt;
    data['docType'] = this.docType;
    data['id'] = this.id;
    data['updatedAt'] = this.updatedAt;
    data['status'] = this.status;
    return data;
  }
}

class Composition {
  String diamond;
  String metalGroup;
  int weight;

  Composition({this.diamond, this.metalGroup, this.weight});

  Composition.fromJson(Map<String, dynamic> json) {
    diamond = json['diamond'];
    metalGroup = json['metalGroup'];
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['diamond'] = this.diamond;
    data['metalGroup'] = this.metalGroup;
    data['weight'] = this.weight;
    return data;
  }
}

class Item {
  String createdAt;
  String docType;
  String id;
  List<String> images;
  String name;
  String updatedAt;
  String video;

  Item(
      {this.createdAt,
      this.docType,
      this.id,
      this.images,
      this.name,
      this.updatedAt,
      this.video});

  Item.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    docType = json['docType'];
    id = json['id'];
    images = json['images'].cast<String>();
    name = json['name'];
    updatedAt = json['updatedAt'];
    video = json['video'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['docType'] = this.docType;
    data['id'] = this.id;
    data['images'] = this.images;
    data['name'] = this.name;
    data['updatedAt'] = this.updatedAt;
    data['video'] = this.video;
    return data;
  }
}

class Transactions {
  int amount;
  String createdAt;
  String deleveryAgent;
  String docType;
  String id;
  bool instantGoldApplied;
  String mode;
  String status;
  String updatedAt;
  String user;

  Transactions(
      {this.amount,
      this.createdAt,
      this.deleveryAgent,
      this.docType,
      this.id,
      this.instantGoldApplied,
      this.mode,
      this.status,
      this.updatedAt,
      this.user});

  Transactions.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    createdAt = json['createdAt'];
    deleveryAgent = json['deleveryAgent'];
    docType = json['docType'];
    id = json['id'];
    instantGoldApplied = json['instantGoldApplied'];
    mode = json['mode'];
    status = json['status'];
    updatedAt = json['updatedAt'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['createdAt'] = this.createdAt;
    data['deleveryAgent'] = this.deleveryAgent;
    data['docType'] = this.docType;
    data['id'] = this.id;
    data['instantGoldApplied'] = this.instantGoldApplied;
    data['mode'] = this.mode;
    data['status'] = this.status;
    data['updatedAt'] = this.updatedAt;
    data['user'] = this.user;
    return data;
  }
}

class User {
  List<String> gBPBonusEntries;
  String gBPcode;
  List<Address> addresses;
  String createdAt;
  String dob;
  String docType;
  String email;
  String fname;
  String id;
  String image;
  bool isInvested;
  bool isWhatsapp;
  int joiningBonus;
  String level;
  int mobile;
  String pan;
  String refCode;
  String referenceType;
  String referral;
  List<String> referralBonusEntries;
  String role;
  String updatedAt;

  User(
      {this.gBPBonusEntries,
      this.gBPcode,
      this.addresses,
      this.createdAt,
      this.dob,
      this.docType,
      this.email,
      this.fname,
      this.id,
      this.image,
      this.isInvested,
      this.isWhatsapp,
      this.joiningBonus,
      this.level,
      this.mobile,
      this.pan,
      this.refCode,
      this.referenceType,
      this.referral,
      this.referralBonusEntries,
      this.role,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    gBPBonusEntries = json['GBPBonusEntries'].cast<String>();
    gBPcode = json['GBPcode'];
    if (json['addresses'] != null) {
      addresses = <Address>[];
      json['addresses'].forEach((v) {
        addresses.add(new Address.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    dob = json['dob'];
    docType = json['docType'];
    email = json['email'];
    fname = json['fname'];
    id = json['id'];
    image = json['image'];
    isInvested = json['isInvested'];
    isWhatsapp = json['isWhatsapp'];
    joiningBonus = json['joiningBonus'];
    level = json['level'];
    mobile = json['mobile'];
    pan = json['pan'];
    refCode = json['refCode'];
    referenceType = json['referenceType'];
    referral = json['referral'];
    referralBonusEntries = json['referralBonusEntries'].cast<String>();
    role = json['role'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['GBPBonusEntries'] = this.gBPBonusEntries;
    data['GBPcode'] = this.gBPcode;
    if (this.addresses != null) {
      data['addresses'] = this.addresses.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['dob'] = this.dob;
    data['docType'] = this.docType;
    data['email'] = this.email;
    data['fname'] = this.fname;
    data['id'] = this.id;
    data['image'] = this.image;
    data['isInvested'] = this.isInvested;
    data['isWhatsapp'] = this.isWhatsapp;
    data['joiningBonus'] = this.joiningBonus;
    data['level'] = this.level;
    data['mobile'] = this.mobile;
    data['pan'] = this.pan;
    data['refCode'] = this.refCode;
    data['referenceType'] = this.referenceType;
    data['referral'] = this.referral;
    data['referralBonusEntries'] = this.referralBonusEntries;
    data['role'] = this.role;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
