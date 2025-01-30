import 'package:restaurant_app/data/model/detail/customer_review.dart';

class CustomerRatingResponse {
    bool error;
    String message;
    List<CustomerReview> customerReviews;

    CustomerRatingResponse({
        required this.error,
        required this.message,
        required this.customerReviews,
    });

    factory CustomerRatingResponse.fromJson(Map<String, dynamic> json) => CustomerRatingResponse(
        error: json["error"],
        message: json["message"],
        customerReviews: List<CustomerReview>.from(json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "customerReviews": List<dynamic>.from(customerReviews.map((x) => x.toJson())),
    };
}