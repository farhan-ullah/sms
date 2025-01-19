
class TransactionModel {
  String transactionId; // Unique transaction identifier

  String transactionType; // Type of the transaction (e.g., fee payment, salary payment)

  double amount; // The amount involved in the transaction (e.g., fee paid, salary amount)

  DateTime transactionDate; // The date the transaction was made

  String transactionDescription; // A description or details about the transaction

  String studentOrTeacherId; // Reference to the student or teacher associated with the transaction

  String? paymentMethod; // Payment method (e.g., cash, cheque, bank transfer)

  String status; // Status of the transaction (e.g., 'Completed', 'Pending', 'Failed')

  TransactionModel({
    required this.transactionId,
    required this.transactionType,
    required this.amount,
    required this.transactionDate,
    required this.transactionDescription,
    required this.studentOrTeacherId,
     this.paymentMethod,
    required this.status,
  });
}
