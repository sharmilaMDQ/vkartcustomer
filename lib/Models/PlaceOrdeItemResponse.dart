class PlaceOrderItemsResponse {
  String? productId;
  String? productName;
  String? productQty;
  String? productPrice;
  String? orderedQty;

  PlaceOrderItemsResponse(
      {this.productId,
        this.productName,
        this.productQty,
        this.productPrice,
        this.orderedQty});

  PlaceOrderItemsResponse.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    productName = json['productName'];
    productQty = json['productQty'];
    productPrice = json['productPrice'];
    orderedQty = json['orderedQty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['productName'] = this.productName;
    data['productQty'] = this.productQty;
    data['productPrice'] = this.productPrice;
    data['orderedQty'] = this.orderedQty;
    return data;
  }
}