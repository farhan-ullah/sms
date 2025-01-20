import 'package:flutter/material.dart';
import '../../data/models/canteen/product_model.dart';
import '../../data/models/canteen/stock_management_model.dart';
import '../../data/models/transactionModel/transaction_model.dart';

// Inventory Provider
class InventoryProvider extends ChangeNotifier {
  List<Transaction> dummySalesData = [
    // Sale for Food & Beverages
    Transaction(
      id: 't1',
      description: 'Sale of Sandwich',
      debitAccount: 'Cash',
      creditAccount: 'Sales Revenue',
      debitAmount: 3.5 * 5,  // Sale of 5 Sandwiches
      creditAmount: 3.5 * 5,  // Sale of 5 Sandwiches
      date: DateTime.now().subtract(Duration(days: 1)),  // Yesterday
    ),

    // Sale for Stationery
    Transaction(
      id: 't2',
      description: 'Sale of Notebook',
      debitAccount: 'Cash',
      creditAccount: 'Sales Revenue',
      debitAmount: 1.8 * 10,  // Sale of 10 Notebooks
      creditAmount: 1.8 * 10,  // Sale of 10 Notebooks
      date: DateTime.now().subtract(Duration(days: 2)),  // 2 Days Ago
    ),

    // Sale for School Uniforms
    Transaction(
      id: 't3',
      description: 'Sale of School Shirt',
      debitAccount: 'Cash',
      creditAccount: 'Sales Revenue',
      debitAmount: 12.0 * 3,  // Sale of 3 School Shirts
      creditAmount: 12.0 * 3,  // Sale of 3 School Shirts
      date: DateTime.now().subtract(Duration(days: 3)),  // 3 Days Ago
    ),

    // Sale for Tech & Accessories
    Transaction(
      id: 't4',
      description: 'Sale of Wireless Headphones',
      debitAccount: 'Cash',
      creditAccount: 'Sales Revenue',
      debitAmount: 30.0 * 2,  // Sale of 2 Wireless Headphones
      creditAmount: 30.0 * 2,  // Sale of 2 Wireless Headphones
      date: DateTime.now().subtract(Duration(days: 5)),  // 5 Days Ago
    ),

    // Sale for Personal Care & Hygiene
    Transaction(
      id: 't5',
      description: 'Sale of Hand Sanitizer',
      debitAccount: 'Cash',
      creditAccount: 'Sales Revenue',
      debitAmount: 1.5 * 20,  // Sale of 20 Hand Sanitizers
      creditAmount: 1.5 * 20,  // Sale of 20 Hand Sanitizers
      date: DateTime.now().subtract(Duration(days: 6)),  // 6 Days Ago
    ),

    // Sale for Health & Wellness
    Transaction(
      id: 't6',
      description: 'Sale of Hand Sanitizer',
      debitAccount: 'Cash',
      creditAccount: 'Sales Revenue',
      debitAmount: 1.5 * 15,  // Sale of 15 Hand Sanitizers
      creditAmount: 1.5 * 15,  // Sale of 15 Hand Sanitizers
      date: DateTime.now().subtract(Duration(days: 7)),  // 7 Days Ago
    ),

    // Sale for Books & Learning Resources
    Transaction(
      id: 't7',
      description: 'Sale of Notebook',
      debitAccount: 'Cash',
      creditAccount: 'Sales Revenue',
      debitAmount: 1.8 * 25,  // Sale of 25 Notebooks
      creditAmount: 1.8 * 25,  // Sale of 25 Notebooks
      date: DateTime.now().subtract(Duration(days: 8)),  // 8 Days Ago
    ),

    // Sale for Tech & Accessories
    Transaction(
      id: 't8',
      description: 'Sale of Wireless Headphones',
      debitAccount: 'Cash',
      creditAccount: 'Sales Revenue',
      debitAmount: 30.0 * 1,  // Sale of 1 Wireless Headphones
      creditAmount: 30.0 * 1,  // Sale of 1 Wireless Headphones
      date: DateTime.now().subtract(Duration(days: 10)), // 10 Days Ago
    ),

    // Sale for Food & Beverages
    Transaction(
      id: 't9',
      description: 'Sale of Sandwich',
      debitAccount: 'Cash',
      creditAccount: 'Sales Revenue',
      debitAmount: 3.5 * 10,  // Sale of 10 Sandwiches
      creditAmount: 3.5 * 10,  // Sale of 10 Sandwiches
      date: DateTime.now().subtract(Duration(days: 12)), // 12 Days Ago
    ),

    // Sale for Personal Care & Hygiene
    Transaction(
      id: 't10',
      description: 'Sale of Hand Sanitizer',
      debitAccount: 'Cash',
      creditAccount: 'Sales Revenue',
      debitAmount: 1.5 * 50,  // Sale of 50 Hand Sanitizers
      creditAmount: 1.5 * 50,  // Sale of 50 Hand Sanitizers
      date: DateTime.now().subtract(Duration(days: 15)), // 15 Days Ago
    ),

    // Sale for Stationery
    Transaction(
      id: 't11',
      description: 'Sale of Notebook',
      debitAccount: 'Cash',
      creditAccount: 'Sales Revenue',
      debitAmount: 1.8 * 5,   // Sale of 5 Notebooks
      creditAmount: 1.8 * 5,   // Sale of 5 Notebooks
      date: DateTime.now().subtract(Duration(days: 18)), // 18 Days Ago
    ),

    // Sale for School Uniforms
    Transaction(
      id: 't12',
      description: 'Sale of School Shirt',
      debitAccount: 'Cash',
      creditAccount: 'Sales Revenue',
      debitAmount: 12.0 * 7,   // Sale of 7 School Shirts
      creditAmount: 12.0 * 7,   // Sale of 7 School Shirts
      date: DateTime.now().subtract(Duration(days: 20)), // 20 Days Ago
    ),

    // Sale for Food & Beverages
    Transaction(
      id: 't13',
      description: 'Sale of Sandwich',
      debitAccount: 'Cash',
      creditAccount: 'Sales Revenue',
      debitAmount: 3.5 * 8,   // Sale of 8 Sandwiches
      creditAmount: 3.5 * 8,   // Sale of 8 Sandwiches
      date: DateTime.now().subtract(Duration(days: 22)), // 22 Days Ago
    ),

    // Sale for Tech & Accessories
    Transaction(
      id: 't14',
      description: 'Sale of Wireless Headphones',
      debitAccount: 'Cash',
      creditAccount: 'Sales Revenue',
      debitAmount: 30.0 * 3,  // Sale of 3 Wireless Headphones
      creditAmount: 30.0 * 3,  // Sale of 3 Wireless Headphones
      date: DateTime.now().subtract(Duration(days: 25)), // 25 Days Ago
    ),

    // Sale for Tech & Accessories
    Transaction(
      id: 't15',
      description: 'Sale of Wireless Headphones',
      debitAccount: 'Cash',
      creditAccount: 'Sales Revenue',
      debitAmount: 30.0 * 1,  // Sale of 1 Wireless Headphones
      creditAmount: 30.0 * 1,  // Sale of 1 Wireless Headphones
      date: DateTime.now().subtract(Duration(days: 30)), // 30 Days Ago
    ),
  ];

  // Main categories list (same data as before)
  final List<Category> _mainCategories = [
    Category(id: '1', name: 'Food & Beverages'),
    Category(id: '2', name: 'Stationery'),
    Category(id: '3', name: 'School Uniforms'),
    Category(id: '4', name: 'Tech & Accessories'),
    Category(id: '5', name: 'Personal Care & Hygiene'),
    Category(id: '6', name: 'Health & Wellness'),
    Category(id: '7', name: 'Books & Learning Resources'),
    Category(id: '8', name: 'Events & Celebrations'),
    Category(id: '9', name: 'Eco-friendly & Sustainability'),
    Category(id: '10', name: 'Gift Shop / Souvenirs'),
    Category(id: '11', name: 'Creative & DIY Kits'),
  ];
  List<StockAdjustment> stockAdjustments = []; // To track stock adjustments
  // Add a method to get product by its ID
  Product? getProductById(String id) {
    try {
      return _products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null; // Return null if product with the specified id doesn't exist
    }
  }
  // Example function to update stock and record the adjustment
  void updateProductStock(
      String productId, int newQuantity, String reason, String adjustedBy) {
    final product = products.firstWhere((p) => p.id == productId);

    // Creating a stock adjustment entry
    final adjustment = StockAdjustment(
      productId: product.id,
      quantityChanged: newQuantity - product.stockQuantity,
      reason: reason,
      date: DateTime.now(),
      adjustedBy: adjustedBy,
    );

    stockAdjustments.add(adjustment);

    // Update the product stock
    product.stockQuantity = newQuantity;

    notifyListeners();
  }
  // Product list
  final List<Product> _products = [
    Product(
      id: 'p1',
      name: 'Sandwich',
      category: Category(id: '1', name: 'Food & Beverages'),
      purchasePrice: 2.0,
      salePrice: 3.5,
      stockQuantity: 50,
    ),
    Product(
      id: 'p2',
      name: 'Notebook',
      category: Category(id: '2', name: 'Stationery'),
      purchasePrice: 1.0,
      salePrice: 1.8,
      stockQuantity: 100,
    ),
    Product(
      id: 'p3',
      name: 'School Shirt',
      category: Category(id: '3', name: 'School Uniforms'),
      purchasePrice: 8.0,
      salePrice: 12.0,
      stockQuantity: 30,
    ),
    Product(
      id: 'p4',
      name: 'Wireless Headphones',
      category: Category(id: '4', name: 'Tech & Accessories'),
      purchasePrice: 20.0,
      salePrice: 30.0,
      stockQuantity: 10,
    ),
    Product(
      id: 'p5',
      name: 'Hand Sanitizer',
      category: Category(id: '5', name: 'Personal Care & Hygiene'),
      purchasePrice: 0.5,
      salePrice: 1.5,
      stockQuantity: 200,
    ),
  ];

  // Getter for categories
  List<Category> get mainCategories => _mainCategories;

  // Getter for products
  List<Product> get products => _products;

  // Add a new product to the list
  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }


  // Add a category (if needed in the future)
  void addCategory(Category category) {
    _mainCategories.add(category);
    notifyListeners();
  }
  List<Transaction> getAllSales() {
    return dummySalesData;  // Returning the dummy sales data
  }
  // Optionally, remove a product or category (just as an example)
  void removeProduct(String productId) {
    _products.removeWhere((product) => product.id == productId);
    notifyListeners();
  }

  void removeCategory(String categoryId) {
    _mainCategories.removeWhere((category) => category.id == categoryId);
    notifyListeners();
  }
}
