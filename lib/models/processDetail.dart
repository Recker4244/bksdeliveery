class processdetail {
  String detailID;
  String grossWeight;
  String netWeight;
  String itemPhoto;
  String purityPhoto;

  processdetail(
      {this.detailID,
      this.grossWeight,
      this.netWeight,
      this.itemPhoto,
      this.purityPhoto});

  processdetail.fromJson(Map<String, dynamic> json) {
    detailID = json['DetailID'];
    grossWeight = json['GrossWeight'];
    netWeight = json['NetWeight'];
    itemPhoto = json['ItemPhoto'];
    purityPhoto = json['PurityPhoto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DetailID'] = this.detailID;
    data['GrossWeight'] = this.grossWeight;
    data['NetWeight'] = this.netWeight;
    data['ItemPhoto'] = this.itemPhoto;
    data['PurityPhoto'] = this.purityPhoto;
    return data;
  }
}
