class ApiResponse {
  dynamic data;

  ApiResponse(this.data);

  ApiResponse.fromJson(Map<String, dynamic> json) : data = json['data'];
}
