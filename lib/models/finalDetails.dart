class finalDetails {
  String appoitmnetProcessDetailsID;
  String appointmentID;
  num meltedWeight;
  num finalPurity;
  String purityPhoto;
  String status;
  String serialNumber;
  num totalWeightIncludingEnvelope;

  finalDetails(
      {this.appoitmnetProcessDetailsID,
      this.appointmentID,
      this.meltedWeight,
      this.finalPurity,
      this.purityPhoto,
      this.status,
      this.serialNumber,
      this.totalWeightIncludingEnvelope});

  finalDetails.fromJson(Map<String, dynamic> json) {
    appoitmnetProcessDetailsID = json['AppoitmnetProcessDetailsID'];
    appointmentID = json['AppointmentID'];
    meltedWeight = json['MeltedWeight'];
    finalPurity = json['FinalPurity'];
    purityPhoto = json['PurityPhoto'];
    status = json['Status'];
    serialNumber = json['SerialNumber'];
    totalWeightIncludingEnvelope = json['TotalWeightIncludingEnvelope'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AppoitmnetProcessDetailsID'] = this.appoitmnetProcessDetailsID;
    data['AppointmentID'] = this.appointmentID;
    data['MeltedWeight'] = this.meltedWeight;
    data['FinalPurity'] = this.finalPurity;
    data['PurityPhoto'] = this.purityPhoto;
    data['Status'] = this.status;
    data['SerialNumber'] = this.serialNumber;
    data['TotalWeightIncludingEnvelope'] = this.totalWeightIncludingEnvelope;
    return data;
  }
}

finalDetails finalappt = finalDetails();
