class OrderItem {
  final String orderCode;
  final double totalAmount;
  final String paymentMethod;
  final String status;
  final DateTime createdAt;

  const OrderItem({
    required this.orderCode,
    required this.totalAmount,
    required this.paymentMethod,
    required this.status,
    required this.createdAt,
  });

  OrderItem copyWith({
    String? orderCode,
    double? totalAmount,
    String? paymentMethod,
    String? status,
    DateTime? createdAt,
  }) {
    return OrderItem(
      orderCode: orderCode ?? this.orderCode,
      totalAmount: totalAmount ?? this.totalAmount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}