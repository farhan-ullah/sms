import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../businessLogic/providers/inventory_provider.dart';
import '../../../businessLogic/providers/accounting_provider.dart';
import '../../../data/models/canteen/product_model.dart';
import '../../../data/models/transactionModel/transaction_model.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({super.key});

  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  final Map<String, TextEditingController> _quantityControllers = {};
  final Map<String, double> _totalAmountMap = {}; // Store total amounts for each product
  double _totalBill = 0.0; // To store total bill

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: const Text('Sell Products'),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: Consumer<InventoryProvider>(
        builder: (context, inventoryProvider, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5, // Adjust the count based on screen size
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 1,
                    ),
                    itemCount: inventoryProvider.products.length,
                    itemBuilder: (context, index) {
                      Product product = inventoryProvider.products[index];
                      if (!_quantityControllers.containsKey(product.id)) {
                        _quantityControllers[product.id] = TextEditingController();
                        _quantityControllers[product.id]!.addListener(() {
                          _updateTotalAmount(product.id, product.salePrice);
                        });
                      }
                      return _buildProductCard(product, inventoryProvider);
                    },
                  ),
                ),
                // Total Bill Section
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'Total Bill: PKR ${_totalBill.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[800],
                    ),
                  ),
                ),
                _buildSaleButton(context, inventoryProvider),
              ],
            ),
          );
        },
      ),
    );
  }

  // Update the total amount for the product
  void _updateTotalAmount(String productId, double salePrice) {
    final quantity = int.tryParse(_quantityControllers[productId]?.text ?? '0') ?? 0;
    final totalAmount = quantity * salePrice;

    // Update the total amount for this product
    setState(() {
      _totalAmountMap[productId] = totalAmount;
      // Update the overall total bill
      _totalBill = _totalAmountMap.values.fold(0.0, (prev, curr) => prev + curr);
    });
  }

  // Build the product card widget
  Widget _buildProductCard(Product product, InventoryProvider inventoryProvider) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.fastfood, // You can replace this with a product image if needed
                size: 30,
                color: Colors.green[800],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product.name,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green[800]),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              '${product.category.name}',
              style: TextStyle(fontSize: 12, color: Colors.green[600]),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Stock: ${product.stockQuantity}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                ),
                Text(
                  'Price: PKR ${product.salePrice.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.green[700]),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _quantityControllers[product.id],
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Qty',
                labelStyle: TextStyle(fontSize: 12),
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              ),
              style: const TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 4),
            // Show the total for this product
            Text(
              'Total: PKR ${_totalAmountMap[product.id]?.toStringAsFixed(2) ?? '0.00'}',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.green[700]),
            ),
          ],
        ),
      ),
    );
  }

  // Sale button that will process the sale
  Widget _buildSaleButton(BuildContext context, InventoryProvider inventoryProvider) {
    return ElevatedButton(
      onPressed: () => _processSale(context, inventoryProvider),
      child: const Text(
        'Complete Sale',
        style: TextStyle(fontSize: 16),
      ),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.greenAccent,
        minimumSize: Size(double.infinity, 45),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  // Process sale and handle inventory and transaction
  void _processSale(BuildContext context, InventoryProvider inventoryProvider) {
    double totalSaleAmount = 0.0;

    // Iterate over each product and process the quantities entered by the user
    for (Product product in inventoryProvider.products) {
      final quantity = int.tryParse(_quantityControllers[product.id]?.text ?? '') ?? 0;

      if (quantity > 0) {
        // Check if stock is sufficient
        if (product.stockQuantity < quantity) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Not enough stock for ${product.name}')),
          );
          return;
        }

        // Calculate the total amount for this product
        double totalAmount = product.salePrice * quantity;
        totalSaleAmount += totalAmount;

        // Update inventory stock
        inventoryProvider.updateProductStock(
          product.id,
          product.stockQuantity - quantity,
          DateTime.now().toString(),
          'Admin', // Placeholder for the user
        );

        // Record the transaction (assuming cash payment method)
        final transaction = Transaction(
          id: DateTime.now().toString(),
          description: 'Sale of ${product.name}',
          debitAccount: 'Accounts Receivable',
          creditAccount: 'Cash Account',
          debitAmount: totalAmount,
          creditAmount: totalAmount,
          date: DateTime.now(),
          category:""
        , isExpense: true,isRevenue: false);

        context.read<AccountingProvider>().recordTransaction(transaction);
      }
    }

    // Show confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Total Sale Amount: PKR $totalSaleAmount')),
    );

    // Clear the quantity fields after sale
    _quantityControllers.forEach((key, controller) {
      controller.clear();
    });

    // Reset the total bill
    setState(() {
      _totalBill = 0.0;
    });
  }
}
