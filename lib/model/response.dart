class ApiResponse {
  bool? status;
  String? error;
  dynamic data;
  int? codehttp;

  ApiResponse({this.status, this.error, this.data, this.codehttp});

  factory ApiResponse.fromMap(Map<String, dynamic> map) {
    return ApiResponse(
      status: map["status"] as bool,
      error: map["error"],
      data: map["data"] as dynamic,
      codehttp: map["codehttp"] as int,
    );
  }
}
