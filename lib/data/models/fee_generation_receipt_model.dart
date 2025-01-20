class Receipt {
  final String studentName;
  final String studentId;
  final String className;
  final String feeType;
  final double feeAmount;
  final String paymentStatus;
  final DateTime paymentDate;
  final String month;
  final String year;

  Receipt({
    required this.year,
    required this.month,
    required this.studentName,
    required this.studentId,
    required this.className,
    required this.feeType,
    required this.feeAmount,
    required this.paymentStatus,
    required this.paymentDate,
  });

  // Convert the receipt to a string for display or printing
  String getFormattedReceipt() {
    return '''
      Receipt for: $studentName
      Student ID: $studentId
      Class: $className
      Fee Type: $feeType
      Fee Amount: \$${feeAmount.toStringAsFixed(2)}
      Payment Status: $paymentStatus
      Payment Date: ${paymentDate.toLocal().toString().split(' ')[0]}
    ''';
  }
}
