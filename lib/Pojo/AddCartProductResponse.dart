class AddCartResponse {
  String? message;
  bool? error;
  bool? missmatch;

  AddCartResponse({this.message, this.error, this.missmatch});

  AddCartResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'] ?? ''; // Default to an empty string if null
    error = json['error'] is bool ? json['error'] : false; // Default to false
    missmatch = json['missmatch'] is bool ? json['missmatch'] : null; // Handle nullable boolean
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'error': error,
      'missmatch': missmatch,
    };
  }
}
