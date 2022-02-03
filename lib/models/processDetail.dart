class processdetail {
  String itemName;
  String detailID;
  num grossWeight;
  num netWeight;
  num purity;
  String itemPhoto;
  num total;

  processdetail(
      {this.itemName,
      this.detailID,
      this.grossWeight,
      this.netWeight,
      this.purity,
      this.itemPhoto,
      this.total});

  processdetail.fromJson(Map<String, dynamic> json) {
    itemName = json['ItemName'];
    detailID = json['DetailID'];
    grossWeight = json['GrossWeight'];
    netWeight = json['NetWeight'];
    purity = json['Purity'];
    itemPhoto = json['ItemPhoto'];
    total = json['Total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ItemName'] = this.itemName;
    data['DetailID'] = this.detailID;
    data['GrossWeight'] = this.grossWeight;
    data['NetWeight'] = this.netWeight;
    data['Purity'] = this.purity;
    data['ItemPhoto'] = this.itemPhoto;
    data['Total'] = this.total;
    return data;
  }
}
