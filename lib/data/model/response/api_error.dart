
class ApiError {
  String? value;
  String? msg;
  String? param;
  String? location;

  ApiError({this.value, this.msg, this.param, this.location});

  ApiError.fromJson(dynamic json) {
    value = json["value"];
    msg = json["msg"];
    param = json["param"];
    location = json["location"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["value"] = value;
    map["msg"] = msg;
    map["param"] = param;
    map["location"] = location;
    return map;
  }
}
