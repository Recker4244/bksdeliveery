class collectionList {
  String appointmentDate;
  String appointmentTime;
  BuySellPrice buySellPrice;
  String createdAt;
  String docType;
  String id;
  MetalGroup metalGroup;
  String opt;
  String status;
  String storeLocation;
  String updatedAt;
  User user;
  String verifier;
  num weight;
  num valuation;

  collectionList(
      {this.appointmentDate,
      this.appointmentTime,
      this.buySellPrice,
      this.createdAt,
      this.docType,
      this.id,
      this.metalGroup,
      this.opt,
      this.status,
      this.storeLocation,
      this.updatedAt,
      this.user,
      this.verifier,
      this.weight,
      this.valuation});

  collectionList.fromJson(Map<String, dynamic> json) {
    appointmentDate = json['appointmentDate'];
    appointmentTime = json['appointmentTime'];
    buySellPrice = json['buySellPrice'] != null
        ? new BuySellPrice.fromJson(json['buySellPrice'])
        : null;
    createdAt = json['createdAt'];
    docType = json['docType'];
    id = json['id'];
    metalGroup = json['metalGroup'] != null
        ? new MetalGroup.fromJson(json['metalGroup'])
        : null;
    opt = json['opt'];
    status = json['status'];
    storeLocation = json['storeLocation'];
    updatedAt = json['updatedAt'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    verifier = json['verifier'];
    weight = json['weight'];
    valuation = json['valuation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appointmentDate'] = this.appointmentDate;
    data['appointmentTime'] = this.appointmentTime;
    if (this.buySellPrice != null) {
      data['buySellPrice'] = this.buySellPrice.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['docType'] = this.docType;
    data['id'] = this.id;
    if (this.metalGroup != null) {
      data['metalGroup'] = this.metalGroup.toJson();
    }
    data['opt'] = this.opt;
    data['status'] = this.status;
    data['storeLocation'] = this.storeLocation;
    data['updatedAt'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['verifier'] = this.verifier;
    data['weight'] = this.weight;
    data['valuation'] = this.valuation;
    return data;
  }
}

class BuySellPrice {
  int buy;
  String createdAt;
  String docType;
  String id;
  int sell;
  String updatedAt;

  BuySellPrice(
      {this.buy,
      this.createdAt,
      this.docType,
      this.id,
      this.sell,
      this.updatedAt});

  BuySellPrice.fromJson(Map<String, dynamic> json) {
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

class MetalGroup {
  String createdAt;
  String docType;
  int fineness;
  String id;
  String karatage;
  List<Metals> metals;
  double referenceId;
  String shortName;
  String updatedAt;

  MetalGroup(
      {this.createdAt,
      this.docType,
      this.fineness,
      this.id,
      this.karatage,
      this.metals,
      this.referenceId,
      this.shortName,
      this.updatedAt});

  MetalGroup.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    docType = json['docType'];
    fineness = json['fineness'];
    id = json['id'];
    karatage = json['karatage'];
    if (json['metals'] != null) {
      metals = new List<Metals>();
      json['metals'].forEach((v) {
        metals.add(new Metals.fromJson(v));
      });
    }
    referenceId = json['referenceId'];
    shortName = json['shortName'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['docType'] = this.docType;
    data['fineness'] = this.fineness;
    data['id'] = this.id;
    data['karatage'] = this.karatage;
    if (this.metals != null) {
      data['metals'] = this.metals.map((v) => v.toJson()).toList();
    }
    data['referenceId'] = this.referenceId;
    data['shortName'] = this.shortName;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Metals {
  String createdAt;
  String docType;
  String icon;
  String id;
  String name;
  String updatedAt;

  Metals(
      {this.createdAt,
      this.docType,
      this.icon,
      this.id,
      this.name,
      this.updatedAt});

  Metals.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    docType = json['docType'];
    icon = json['icon'];
    id = json['id'];
    name = json['name'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['docType'] = this.docType;
    data['icon'] = this.icon;
    data['id'] = this.id;
    data['name'] = this.name;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class User {
  String id;
  String fname;
  String email;
  Address address;
  int mobile;

  User({this.id, this.fname, this.email, this.address, this.mobile});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fname = json['fname'];
    email = json['email'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fname'] = this.fname;
    data['email'] = this.email;
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    data['mobile'] = this.mobile;
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
