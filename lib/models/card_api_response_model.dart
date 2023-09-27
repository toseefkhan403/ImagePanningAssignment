import 'dart:convert';

CardApiResponse cardApiResponseFromJson(String str) =>
    CardApiResponse.fromJson(json.decode(str));

String cardApiResponseToJson(CardApiResponse data) =>
    json.encode(data.toJson());

class CardApiResponse {
  final bool? success;
  final bool? isAuth;
  final String? message;
  final List<Result>? result;

  CardApiResponse({
    this.success,
    this.isAuth,
    this.message,
    required this.result,
  });

  factory CardApiResponse.fromJson(Map<String, dynamic> json) =>
      CardApiResponse(
        success: json["success"],
        isAuth: json["isAuth"],
        message: json["message"],
        result: json["result"] == null
            ? []
            : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "isAuth": isAuth,
        "message": message,
        "result": result == null
            ? []
            : List<dynamic>.from(result!.map((x) => x.toJson())),
      };
}

class Result {
  final String? cardImageId;
  final String? cardShortBgUrl;
  final String? cardLongBgUrl;
  final String? cardImageUrl;
  final String? cardImageUrl2;
  final String? cardImageUrl3;
  final String? cardImageUrl4;
  final String? categoryId;
  final String? cardName;
  final String? errorTextColor;
  final String? cardDesignType;
  final ResultCustomImageCardDesignInfo? customImageCardDesignInfo;
  final bool? favouriteStatus;

  Result({
    this.cardImageId,
    this.cardShortBgUrl,
    this.cardLongBgUrl,
    this.cardImageUrl,
    this.cardImageUrl2,
    this.cardImageUrl3,
    this.cardImageUrl4,
    this.categoryId,
    this.cardName,
    this.errorTextColor,
    this.cardDesignType,
    required this.customImageCardDesignInfo,
    this.favouriteStatus,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        cardImageId: json["cardImageId"],
        cardShortBgUrl: json["cardShortBgURL"],
        cardLongBgUrl: json["cardLongBgURL"],
        cardImageUrl: json["cardImageURL"],
        cardImageUrl2: json["cardImageURL2"],
        cardImageUrl3: json["cardImageURL3"],
        cardImageUrl4: json["cardImageURL4"],
        categoryId: json["categoryId"],
        cardName: json["cardName"],
        errorTextColor: json["errorTextColor"],
        cardDesignType: json["cardDesignType"],
        customImageCardDesignInfo: json["customImageCardDesignInfo"] == null
            ? null
            : ResultCustomImageCardDesignInfo.fromJson(
                json["customImageCardDesignInfo"]),
        favouriteStatus: json["favouriteStatus"],
      );

  Map<String, dynamic> toJson() => {
        "cardImageId": cardImageId,
        "cardShortBgURL": cardShortBgUrl,
        "cardLongBgURL": cardLongBgUrl,
        "cardImageURL": cardImageUrl,
        "cardImageURL2": cardImageUrl2,
        "cardImageURL3": cardImageUrl3,
        "cardImageURL4": cardImageUrl4,
        "categoryId": categoryId,
        "cardName": cardName,
        "errorTextColor": errorTextColor,
        "cardDesignType": cardDesignType,
        "customImageCardDesignInfo": customImageCardDesignInfo?.toJson(),
        "favouriteStatus": favouriteStatus,
      };
}

class ResultCustomImageCardDesignInfo {
  final String? primaryColor;
  final String? profileBannerImageUrl;

  ResultCustomImageCardDesignInfo({
    this.primaryColor,
    required this.profileBannerImageUrl,
  });

  factory ResultCustomImageCardDesignInfo.fromJson(Map<String, dynamic> json) =>
      ResultCustomImageCardDesignInfo(
        primaryColor: json["primaryColor"],
        profileBannerImageUrl: json["profileBannerImageURL"],
      );

  Map<String, dynamic> toJson() => {
        "primaryColor": primaryColor,
        "profileBannerImageURL": profileBannerImageUrl,
      };
}
