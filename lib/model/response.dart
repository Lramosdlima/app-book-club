class ApiResponse {
  bool? status;
  String? message;
  dynamic data;

  ApiResponse({this.status, this.message, this.data});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      status: json["status"] as bool,
      message: json["error"],
      data: json["data"] as dynamic,
    );
  }
}
