class WagerCreateResponse {
  final String id;
  final String status;
  // Add other fields from the response

  WagerCreateResponse({
    required this.id,
    required this.status,
  });

  factory WagerCreateResponse.fromJson(Map<String, dynamic> json) {
    return WagerCreateResponse(
      id: json['id'],
      status: json['status'],
      // Map other fields
    );
  }
}