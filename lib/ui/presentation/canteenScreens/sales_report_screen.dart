import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../businessLogic/providers/accounting_provider.dart';
import '../../../businessLogic/providers/inventory_provider.dart';
import '../../../data/models/transactionModel/transaction_model.dart';
import '../../../data/models/canteen/product_model.dart';

class SalesReportScreen extends StatefulWidget {
  const SalesReportScreen({super.key});

  @override
  _SalesReportScreenState createState() => _SalesReportScreenState();
}

class _SalesReportScreenState extends State<SalesReportScreen> {
  DateTime? startDate;
  DateTime? endDate;
  String? selectedCategory;
  List<Transaction> filteredSales = [];

  @override
  Widget build(BuildContext context) {
    // Get all sales data from the provider (which is now mock data)
    final allSales = context.watch<AccountingProvider>().getAllSales();
    final inventoryProvider = context.watch<InventoryProvider>();

    // Filter the sales data based on selected filters
    _filterSales(allSales);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales Report'),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildFilterSection(inventoryProvider),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildSalesDataTable(),
                  const SizedBox(height: 20),
                  _buildSalesGraphs(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Filters sales data based on the selected date range and category
  void _filterSales(List<Transaction> allSales) {
    filteredSales = allSales.where((sale) {
      bool matchesDate = true;
      bool matchesCategory = true;

      if (startDate != null && sale.date.isBefore(startDate!)) {
        matchesDate = false;
      }
      if (endDate != null && sale.date.isAfter(endDate!)) {
        matchesDate = false;
      }
      if (selectedCategory != null) {
        Product? product = context
            .read<InventoryProvider>()
            .getProductById(sale.description.split(' ')[2]); // Assuming sale desc format "Sale of {ProductName}"
        if (product == null || product.category.name != selectedCategory) {
          matchesCategory = false;
        }
      }

      return matchesDate && matchesCategory;
    }).toList();
  }

  // Filter UI for date range and category selection
  Widget _buildFilterSection(InventoryProvider inventoryProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Date Picker for start date
        Row(
          children: [
            Text(
              'Start Date: ${startDate != null ? startDate!.toLocal().toString().split(' ')[0] : 'Not selected'}',
              style: TextStyle(fontSize: 16, color: Colors.green[800]),
            ),
            TextButton(
              onPressed: () async {
                DateTime? selectedStartDate = await _selectDate(context);
                setState(() {
                  startDate = selectedStartDate;
                });
              },
              child: const Text('Select Start Date'),
            ),
          ],
        ),
        // Date Picker for end date
        Row(
          children: [
            Text(
              'End Date: ${endDate != null ? endDate!.toLocal().toString().split(' ')[0] : 'Not selected'}',
              style: TextStyle(fontSize: 16, color: Colors.green[800]),
            ),
            TextButton(
              onPressed: () async {
                DateTime? selectedEndDate = await _selectDate(context);
                setState(() {
                  endDate = selectedEndDate;
                });
              },
              child: const Text('Select End Date'),
            ),
          ],
        ),
        // Category Dropdown
        Row(
          children: [
            const Text('Category: ', style: TextStyle(fontSize: 16)),
            DropdownButton<String>(
              value: selectedCategory,
              hint: const Text('Select Category'),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCategory = newValue;
                });
              },
              items: inventoryProvider.mainCategories
                  .map<DropdownMenuItem<String>>((category) {
                return DropdownMenuItem<String>(value: category.name, child: Text(category.name));
              }).toList(),
            ),
          ],
        ),
        // Reset Button
        TextButton(
          onPressed: () {
            setState(() {
              startDate = null;
              endDate = null;
              selectedCategory = null;
            });
          },
          child: const Text('Reset Filters'),
        ),
      ],
    );
  }

  // Display a date picker dialog
  Future<DateTime?> _selectDate(BuildContext context) async {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
  }

  // Build Sales Data Table
  Widget _buildSalesDataTable() {
    return DataTable(
      columns: const [
        DataColumn(label: Text('Product Name')),
        DataColumn(label: Text('Quantity Sold')),
        DataColumn(label: Text('Amount')),
        DataColumn(label: Text('Date')),
      ],
      rows: filteredSales
          .map((sale) => DataRow(cells: [
        DataCell(Text(sale.description.split(' ')[2])),  // Mock Product Name
        DataCell(Text(sale.debitAmount.toString())),
        DataCell(Text('PKR ${sale.debitAmount.toStringAsFixed(2)}')),
        DataCell(Text(sale.date.toLocal().toString().split(' ')[0])),
      ]))
          .toList(),
    );
  }

  // Build Sales Graphs
  Widget _buildSalesGraphs() {
    double totalSales = filteredSales.fold(0, (sum, sale) => sum + sale.debitAmount);

    return Column(
      children: [
        // Bar Chart for total sales over time
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: AspectRatio(
            aspectRatio: 1.5,
            child: BarChart(
              BarChartData(
                borderData: FlBorderData(show: false),
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(show: false),
                barGroups: filteredSales
                    .map((sale) {
                  return BarChartGroupData(
                    x: filteredSales.indexOf(sale),
                    barRods: [
                      BarChartRodData(color: Colors.greenAccent, toY: sale.debitAmount),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ),
        // Pie Chart for Sales by Category
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: AspectRatio(
            aspectRatio: 1.5,
            child: PieChart(
              PieChartData(
                sections: _getSalesByCategory(),
                borderData: FlBorderData(show: false),
              ),
            ),
          ),
        ),
        // Total Sales
        Text(
          'Total Sales: PKR ${totalSales.toStringAsFixed(2)}',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // Get Sales data for each category
  List<PieChartSectionData> _getSalesByCategory() {
    final categorySales = <String, double>{};

    for (var sale in filteredSales) {
      Product? product = context.read<InventoryProvider>().getProductById(sale.description.split(' ')[2]); // Extract product from sale description
      if (product != null) {
        if (categorySales.containsKey(product.category.name)) {
          categorySales[product.category.name] = categorySales[product.category.name]! + sale.debitAmount;
        } else {
          categorySales[product.category.name] = sale.debitAmount;
        }
      }
    }

    return categorySales.entries.map((entry) {
      return PieChartSectionData(
        color: Colors.green,
        value: entry.value,
        title: '${entry.key} (${entry.value.toStringAsFixed(2)})',
        radius: 30,
      );
    }).toList();
  }
}
