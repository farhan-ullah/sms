// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../businessLogic/providers/inventory_provider.dart';
// import '../../../businessLogic/providers/accounting_provider.dart';
// import '../../../data/models/canteen/product_model.dart';
// import '../../../data/models/transactionModel/transaction_model.dart';
//
// class StockManagementScreen extends StatefulWidget {
//   const StockManagementScreen({super.key});
//
//   @override
//   State<StockManagementScreen> createState() => _StockManagementScreenState();
// }
//
// class _StockManagementScreenState extends State<StockManagementScreen> {
//   final String inventoryAccount = 'Inventory Account';
//   final String accountsPayableAccount = 'Accounts Payable';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Stock Management'),
//         centerTitle: true,
//         backgroundColor: Colors.greenAccent,
//       ),
//       body: Consumer<InventoryProvider>(
//         builder: (context, inventoryProvider, child) {
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   for (Product product in inventoryProvider.products)
//                     _buildProductCard(product, inventoryProvider),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   // Build a product card with better styling
//   Widget _buildProductCard(Product product, InventoryProvider provider) {
//     return Card(
//       elevation: 8.0,
//       margin: const EdgeInsets.symmetric(vertical: 10.0),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               width: 100,
//               height: 100,
//               decoration: BoxDecoration(
//                 color: Colors.green[50],
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Icon(
//                 Icons.fastfood, // Placeholder icon
//                 size: 50,
//                 color: Colors.green[800],
//               ),
//             ),
//             const SizedBox(width: 20),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     product.name,
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.green[800],
//                     ),
//                   ),
//                   Text(
//                     '${product.category.name}',
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.green[600],
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Stock: ${product.stockQuantity}',
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.grey[700],
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Sale: PKR ${product.salePrice.toStringAsFixed(2)}',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.green[700],
//                         ),
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.edit),
//                         onPressed: () {
//                           _showRestockDialog(context, product);
//                         },
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // Show a dialog to restock the product
//   void _showRestockDialog(BuildContext context, Product product) {
//     final quantityController = TextEditingController();
//     final reasonController = TextEditingController();
//
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Restock Product'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: quantityController,
//                 keyboardType: TextInputType.number,
//                 decoration: const InputDecoration(labelText: 'Quantity to Restock'),
//               ),
//               TextField(
//                 controller: reasonController,
//                 decoration: const InputDecoration(labelText: 'Reason (e.g., Purchase)'),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 final quantity = int.parse(quantityController.text);
//                 final reason = reasonController.text;
//
//                 // Update stock and record the transaction
//                 context.read<InventoryProvider>().updateProductStock(
//                   product.id,
//                   product.stockQuantity + quantity,
//                   reason,
//                   "Staff Member", // Example, replace with current user's name
//                 );
//
//                 final transaction = Transaction(
//                   id: DateTime.now().toString(),
//                   description: 'Stock Restock: ${product.name}',
//                   debitAccount: inventoryAccount,
//                   creditAccount: accountsPayableAccount,
//                   debitAmount: product.purchasePrice * quantity.toDouble(),
//                   creditAmount: product.purchasePrice * quantity.toDouble(),
//                   date: DateTime.now(),
//                 );
//
//                 // Record the transaction in the AccountingProvider
//                 context.read<AccountingProvider>().recordTransaction(transaction);
//
//                 // Show success feedback
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text('Product restocked successfully')),
//                 );
//
//                 Navigator.pop(context);
//               },
//               child: const Text('Restock'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
