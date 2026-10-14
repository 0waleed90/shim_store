class CardModel {
  final String cardNumber;
  final String expiryDate;
  final String securityCode;

  CardModel({
    required this.cardNumber,
    required this.expiryDate,
    required this.securityCode,
  });
  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      cardNumber: json['cardNumber'],
      expiryDate: json['expiryDate'],
      securityCode: json['securityCode'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'cardNumber': cardNumber,
      'expiryDate': expiryDate,
      'securityCode': securityCode,
    };
  }
}
