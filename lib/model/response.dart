class ApiResponse {
  bool? status;
  String? error;
  dynamic data;
  int? codehttp;

  ApiResponse({this.status, this.error, this.data, this.codehttp});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      status: json["status"] as bool,
      error: json["error"],
      data: json["data"] as dynamic,
      codehttp: json["codehttp"] as int,
    );
  }
}
