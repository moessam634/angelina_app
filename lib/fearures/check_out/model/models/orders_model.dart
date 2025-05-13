class OrdersModel {
  String? paymentMethod;
  String? paymentMethodTitle;
  bool? setPaid;
  Billing? billing;
  List<LineItem>? lineItems;

  OrdersModel(
      {this.paymentMethod,
      this.paymentMethodTitle,
      this.setPaid,
      this.billing,
      this.lineItems});

  factory OrdersModel.fromJson(Map<String, dynamic> json) => OrdersModel(
        paymentMethod: json["payment_method"],
        paymentMethodTitle: json["payment_method_title"],
        setPaid: json["set_paid"],
        billing:
            json["billing"] == null ? null : Billing.fromJson(json["billing"]),
        lineItems: json["line_items"] == null
            ? []
            : List<LineItem>.from(
                json["line_items"]!.map((x) => LineItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "payment_method": paymentMethod,
        "payment_method_title": paymentMethodTitle,
        "set_paid": setPaid,
        "billing": billing?.toJson(),
        "line_items": lineItems == null
            ? []
            : List<dynamic>.from(lineItems!.map((x) => x.toJson())),
      };
}

class Billing {
  String? firstName;
  String? lastName;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? postcode;
  String? country;
  String? email;
  String? phone;

  // String? company;

  Billing({
    this.firstName,
    this.lastName,
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.postcode,
    this.country,
    this.email,
    this.phone,
    // this.company,
  });

  factory Billing.fromJson(Map<String, dynamic> json) => Billing(
        firstName: json["first_name"],
        lastName: json["last_name"],
        address1: json["address_1"],
        address2: json["address_2"],
        city: json["city"],
        state: json["state"],
        postcode: json["postcode"],
        country: json["country"],
        email: json["email"],
        phone: json["phone"],
        // company: json["company"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "address_1": address1,
        "address_2": address2,
        "city": city,
        "state": state,
        "postcode": postcode,
        "country": country,
        "email": email,
        "phone": phone,
        // "company": company,
      };
}

class LineItem {
  int? productId;
  int? quantity;

  LineItem({
    this.productId,
    this.quantity,
  });

  factory LineItem.fromJson(Map<String, dynamic> json) => LineItem(
        productId: json["product_id"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "quantity": quantity,
      };
}
