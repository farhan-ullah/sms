import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart'; // For date formatting

class ExpenseDashboardScreen extends StatefulWidget {
  @override
  _ExpenseDashboardScreenState createState() => _ExpenseDashboardScreenState();
}

class _ExpenseDashboardScreenState extends State<ExpenseDashboardScreen> {
  final double totalExpenses = 5000.0; // in PKR
  DateTime _startDate = DateTime.now().subtract(Duration(days: 7)); // Default 7 days
  DateTime _endDate = DateTime.now();
  String _selectedFilter = 'Last 7 Days'; // Filter selected by default
  String _dateRangeDisplay = ''; // For displaying custom date range ("From: xxxx To: yyyy")

  final List<Map<String, dynamic>> allCategories = [
    {'category': 'Salaries', 'amount': 2000.0, 'account': 'Personnel Expenses', 'date': DateTime.now().subtract(Duration(days: 1))},
    {'category': 'Bills', 'amount': 800.0, 'account': 'Utilities Expenses', 'date': DateTime.now().subtract(Duration(days: 10))},
    {'category': 'Maintenance', 'amount': 500.0, 'account': 'Maintenance Expenses', 'date': DateTime.now().subtract(Duration(days: 5))},
    {'category': 'Supplies', 'amount': 300.0, 'account': 'Operational Expenses', 'date': DateTime.now().subtract(Duration(days: 2))},
    {'category': 'Events', 'amount': 400.0, 'account': 'Event Expenses', 'date': DateTime.now().subtract(Duration(days: 3))},
  ];

  List<Map<String, dynamic>> filteredCategories = [];

  @override
  void initState() {
    super.initState();
    filteredCategories = _filterExpenses();
  }

  // Function to filter expenses based on start and end date
  List<Map<String, dynamic>> _filterExpenses() {
    return allCategories.where((expense) {
      return expense['date'].isAfter(_startDate) && expense['date'].isBefore(_endDate);
    }).toList();
  }

  // Function to handle filter change based on selection
  void _onFilterChanged(String filter) {
    setState(() {
      _selectedFilter = filter;

      if (filter == 'Last 7 Days') {
        _startDate = DateTime.now().subtract(Duration(days: 7));
        _endDate = DateTime.now();
        _dateRangeDisplay = ''; // Clear custom date range
      } else if (filter == 'Last 30 Days') {
        _startDate = DateTime.now().subtract(Duration(days: 30));
        _endDate = DateTime.now();
        _dateRangeDisplay = ''; // Clear custom date range
      } else if (filter == 'Custom') {
        _selectCustomDateRange();
      }

      filteredCategories = _filterExpenses();
    });
  }

  // Select custom date range
  Future<void> _selectCustomDateRange() async {
    // Open a date picker for start date
    DateTime? start = await _selectDate('Start Date');
    if (start != null) {
      // After start date is selected, open end date picker
      DateTime? end = await _selectDate('End Date');
      if (end != null && end.isAfter(start)) {
        setState(() {
          _startDate = start;
          _endDate = end;
          // Format the selected dates and display them
          _dateRangeDisplay = 'From: ${DateFormat('dd/MM/yyyy').format(_startDate)} To: ${DateFormat('dd/MM/yyyy').format(_endDate)}';
          filteredCategories = _filterExpenses(); // Filter expenses based on new date range
        });
      } else {
        _showErrorDialog('End date should be after start date.');
      }
    }
  }

  // Date picker method for selecting a date
  Future<DateTime?> _selectDate(String title) async {
    DateTime initialDate = DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(),
          child: child!,
        );
      },
    );
    return pickedDate;
  }

  // Show an error dialog if the dates are invalid
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Invalid Date Range'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Text("Expense Dashboard")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Filter options for Date Range
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () => _onFilterChanged('Last 7 Days'),
                    child: Text('Last 7 Days'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => _onFilterChanged('Last 30 Days'),
                    child: Text('Last 30 Days'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => _onFilterChanged('Custom'),
                    child: Text('Custom'),
                  ),
                ],
              ),
              SizedBox(height: 10),
              // Display the custom date range if selected
              if (_dateRangeDisplay.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(_dateRangeDisplay, style: TextStyle(fontWeight: FontWeight.bold)),
                ),

              SizedBox(height: 20),

              // Total Expenses in PKR
              Card(
                child: ListTile(
                  title: Text("Total Expenses"),
                  subtitle: Text("PKR ${totalExpenses.toStringAsFixed(2)}"),
                  trailing: Icon(Icons.money),
                ),
              ),
              SizedBox(height: 20),

              // Pie Chart (Category-wise Breakdown)
              Container(
                width: double.infinity,
                height: screenWidth > 600 ? 300 : 200, // Dynamic height based on screen size
                child: PieChart(
                  PieChartData(
                    sections: filteredCategories
                        .map((category) => PieChartSectionData(
                      value: category['amount'],
                      title: '${category['category']}',
                      color: Colors.primaries[filteredCategories.indexOf(category) % Colors.primaries.length],
                    ))
                        .toList(),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Recent Expenses List Heading
              Text(
                "Recent Expenses",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: 10),

              // Recent Expenses (List)
              Container(
                height: screenWidth > 600 ? 400 : 300, // Dynamic height for the list
                child: ListView.builder(
                  itemCount: filteredCategories.length,
                  itemBuilder: (context, index) {
                    final category = filteredCategories[index];
                    return Card(
                      child: ListTile(
                        title: Text(category['category']),
                        subtitle: Text("PKR ${category['amount'].toStringAsFixed(2)} - ${category['account']}"),
                        trailing: Text(DateFormat('dd/MM/yyyy').format(category['date'])),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
