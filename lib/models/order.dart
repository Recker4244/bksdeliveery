class order {
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

  order(
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

  order.fromJson(Map<String, dynamic> json) {
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
