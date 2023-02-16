class PaymentList {
  String name;
  String amount;
  String quantity;
  String discount;
  PaymentList({
    required this.name,
    required this.amount,
    required this.quantity,
    required this.discount,
  });

  @override
  String toString() {
    return 'PaymentList(name: $name, amount: $amount, quantity: $quantity, discount: $discount)';
  }

  @override
  bool operator ==(covariant PaymentList other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.amount == amount &&
        other.quantity == quantity &&
        other.discount == discount;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        amount.hashCode ^
        quantity.hashCode ^
        discount.hashCode;
  }
}
