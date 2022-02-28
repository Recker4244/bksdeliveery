class style {
  String name;
  String unitOfMeausurement;
  num conversionValueTOGRAM;

  style({this.name, this.unitOfMeausurement, this.conversionValueTOGRAM});

  style.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    unitOfMeausurement = json['unitOfMeausurement'];
    conversionValueTOGRAM = json['conversionValueTOGRAM'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['unitOfMeausurement'] = this.unitOfMeausurement;
    data['conversionValueTOGRAM'] = this.conversionValueTOGRAM;
    return data;
  }
}
