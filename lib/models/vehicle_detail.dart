class VehicleDetail {
  int id;
  String plate_no;
  String account_no;

  VehicleDetail({this.plate_no, this.account_no});

  factory VehicleDetail.fromJson(Map<String, dynamic> parsedJson) {
    return VehicleDetail(
        plate_no: parsedJson["plate_no"], account_no: parsedJson["account_no"]);
  }
}
