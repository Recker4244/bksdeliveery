class collectionList {
  String amount;
  String createdAt;
  String docType;
  String gold;
  String id;
  String mode;
  int otp;
  String paymentId;
  String status;
  String updatedAt;
  String user;

  collectionList(
      {this.amount,
      this.createdAt,
      this.docType,
      this.gold,
      this.id,
      this.mode,
      this.otp,
      this.paymentId,
      this.status,
      this.updatedAt,
      this.user});

  collectionList.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    createdAt = json['createdAt'];
    docType = json['docType'];
    gold = json['gold'];
    id = json['id'];
    mode = json['mode'];
    otp = json['otp'];
    paymentId = json['paymentId'];
    status = json['status'];
    updatedAt = json['updatedAt'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['createdAt'] = this.createdAt;
    data['docType'] = this.docType;
    data['gold'] = this.gold;
    data['id'] = this.id;
    data['mode'] = this.mode;
    data['otp'] = this.otp;
    data['paymentId'] = this.paymentId;
    data['status'] = this.status;
    data['updatedAt'] = this.updatedAt;
    data['user'] = this.user;
    return data;
  }
}
