// stock_adjustment_model.dart

class StockAdjustment {
  final String productId;
  final int quantityChanged;
  final String reason; // Reason for the restock (e.g., "Purchase", "Return")
  final DateTime date;
  final String adjustedBy; // Who made the change (e.g., staff name or role)

  StockAdjustment({
    required this.productId,
    required this.quantityChanged,
    required this.reason,
    required this.date,
    required this.adjustedBy,
  });
}
