import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../businessLogic/providers/inventory_provider.dart';
import '../../../data/models/canteen/product_model.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Inventory'),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: Consumer<InventoryProvider>(builder: (context, inventoryProvider, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView( // Enables scrolling when content overflows
            child: Column(
              children: [
                for (Product product in inventoryProvider.products)
                  _buildProductCard(product, inventoryProvider),
              ],
            ),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddProductDialog(context);
        },
        backgroundColor: Colors.greenAccent,
        child: const Icon(Icons.add),
      ),
    );
  }

  // Build a product card with better styling and actions (edit)
  Widget _buildProductCard(Product product, InventoryProvider provider) {
    return Card(
      elevation: 8.0, // Gives shadow effect
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.fastfood, // Placeholder for product icon or image
                size: 50,
                color: Colors.green[800],
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[800],
                    ),
                  ),
                  Text(
                    '${product.category.name}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.green[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Stock: ${product.stockQuantity}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sale: PKR ${product.salePrice.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.green[700],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          _showEditProductDialog(context, product);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Dialog to edit product attributes
  void _showEditProductDialog(BuildContext context, Product product) {
    final nameController = TextEditingController(text: product.name);
    final stockController = TextEditingController(text: product.stockQuantity.toString());
    final purchasePriceController = TextEditingController(text: product.purchasePrice.toString());
    final salePriceController = TextEditingController(text: product.salePrice.toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Product Name'),
              ),
              TextField(
                controller: stockController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Stock Quantity'),
              ),
              TextField(
                controller: purchasePriceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Purchase Price'),
              ),
              TextField(
                controller: salePriceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Sale Price'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final updatedProduct = Product(
                  id: product.id,
                  name: nameController.text,
                  category: product.category,
                  purchasePrice: double.parse(purchasePriceController.text),
                  salePrice: double.parse(salePriceController.text),
                  stockQuantity: int.parse(stockController.text),
                );
                context.read<InventoryProvider>().addProduct(updatedProduct); // Update product
                Navigator.pop(context);

                // Show success message
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Product updated successfully!')),
                );
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // Dialog to add a new product, with category selection
  void _showAddProductDialog(BuildContext context) {
    final nameController = TextEditingController();
    final stockController = TextEditingController();
    final purchasePriceController = TextEditingController();
    final salePriceController = TextEditingController();
    Category? selectedCategory = context.read<InventoryProvider>().mainCategories.first;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Product Name'),
              ),
              TextField(
                controller: stockController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Stock Quantity'),
              ),
              TextField(
                controller: purchasePriceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Purchase Price'),
              ),
              TextField(
                controller: salePriceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Sale Price'),
              ),
              const SizedBox(height: 10),
              // Dropdown for category selection
              DropdownButton<Category>(
                value: selectedCategory,
                isExpanded: true,
                onChanged: (newCategory) {
                  setState(() {
                    selectedCategory = newCategory!;
                  });
                },
                items: context.read<InventoryProvider>().mainCategories
                    .map((category) => DropdownMenuItem<Category>(
                  value: category,
                  child: Text(category.name),
                ))
                    .toList(),
                hint: const Text("Select Category"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (nameController.text.isEmpty || stockController.text.isEmpty ||
                    purchasePriceController.text.isEmpty || salePriceController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill all fields!')),
                  );
                  return;
                }

                final newProduct = Product(
                  id: DateTime.now().toString(), // Generate a unique ID
                  name: nameController.text,
                  category: selectedCategory!, // Ensure a category is selected
                  purchasePrice: double.parse(purchasePriceController.text),
                  salePrice: double.parse(salePriceController.text),
                  stockQuantity: int.parse(stockController.text),
                );

                context.read<InventoryProvider>().addProduct(newProduct); // Add new product
                Navigator.pop(context);

                // Show success message
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Product added successfully!')),
                );
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
