class style {
  bool isDeleted;
  bool isActive;
  String createdAt;
  String updatedAt;
  String sId;
  String name;
  int iV;

  style(
      {this.isDeleted,
      this.isActive,
      this.createdAt,
      this.updatedAt,
      this.sId,
      this.name,
      this.iV});

  style.fromJson(Map<String, dynamic> json) {
    isDeleted = json['isDeleted'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    sId = json['_id'];
    name = json['name'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isDeleted'] = this.isDeleted;
    data['isActive'] = this.isActive;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['__v'] = this.iV;
    return data;
  }
}
