class GetFeedbackModel {
  String message;
  bool error;
  FeedBackDatum data;

  GetFeedbackModel({
    required this.message,
    required this.error,
    required this.data,
  });

  factory GetFeedbackModel.fromJson(Map<String, dynamic> json) => GetFeedbackModel(
    message: json["message"],
    error: json["error"],
    data: FeedBackDatum.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "error": error,
    "data": data.toJson(),
  };

}

class FeedBackDatum {
  String firstName;
  String customerImage;
  String rating;
  String reviews;
  String feedbackCreated;

  FeedBackDatum({
    required this.firstName,
    required this.customerImage,
    required this.rating,
    required this.reviews,
    required this.feedbackCreated,
  });
  factory FeedBackDatum.fromJson(Map<String, dynamic> json) => FeedBackDatum(
    firstName: json["firstName"]??0,
    customerImage: json["customerImage"]??'',
    rating: json["rating"]??'',
    reviews: json["reviews"]??'',
    feedbackCreated: json["feedbackCreated"]??'',

  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "customerImage": customerImage,
    "rating": rating,
    "reviews": reviews,
    "feedbackCreated": feedbackCreated,

  };

}
