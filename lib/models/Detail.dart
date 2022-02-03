class detail {
  bool bId;
  String styleID;
  String unitOfMeasurement;
  String units;
  String rateFixedPerUnit;
  String amount;

  detail(
      {this.bId,
      this.styleID,
      this.unitOfMeasurement,
      this.units,
      this.rateFixedPerUnit,
      this.amount});

  detail.fromJson(Map<String, dynamic> json) {
    bId = json['_id'];
    styleID = json['styleID'];
    unitOfMeasurement = json['unitOfMeasurement'];
    units = json['units'];
    rateFixedPerUnit = json['RateFixedPerUnit'];
    amount = json['Amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.bId;
    data['styleID'] = this.styleID;
    data['unitOfMeasurement'] = this.unitOfMeasurement;
    data['units'] = this.units;
    data['RateFixedPerUnit'] = this.rateFixedPerUnit;
    data['Amount'] = this.amount;
    return data;
  }
}
