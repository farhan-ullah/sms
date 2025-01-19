import 'package:flutter/material.dart';


class AddExpenseScreen extends StatefulWidget {
  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  String _category = 'Bills'; // Default category
  double _amount = 0.0;
  String _description = '';
  DateTime _date = DateTime.now();
  String _account = 'Utilities Expenses'; // Default account based on category

  // Expense Categories and their corresponding Chart of Accounts
  final Map<String, String> _categoryToAccount = {
    // 'Salaries': 'Personnel Expenses',
    'Bills': 'Utilities Expenses',
    'Maintenance': 'Maintenance Expenses',
    'Supplies': 'Operational Expenses',
    'Events': 'Event Expenses',
    'Transportation': 'Transportation Expenses',
    'Administrative': 'Administrative Expenses',
    'Miscellaneous': 'Miscellaneous Expenses',
  };

  // List of categories (expanded)
  final List<String> _categories = [
    // 'Salaries',
    'Bills',
    'Maintenance',
    'Supplies',
    'Events',
    'Transportation',
    'Administrative',
    'Miscellaneous',
  ];

  // List to store added expenses
  List<Map<String, String>> _expenses = [];

  // Method to save the expense
  void _saveExpense() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        // Save the expense in the list (in-memory storage)
        _expenses.add({
          'category': _category,
          'account': _account,
          'amount': _amount.toString(),
          'description': _description,
          'date': _date.toLocal().toString().split(' ')[0],
        });
      });
      // Clear the form for the next entry
      _formKey.currentState!.reset();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Expense Added")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add New Expense")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Category Dropdown
              DropdownButtonFormField<String>(
                value: _category,
                onChanged: (value) {
                  setState(() {
                    _category = value!;
                    _account = _categoryToAccount[_category]!; // Automatically update the account
                  });
                },
                items: _categories
                    .map((category) => DropdownMenuItem(
                    value: category, child: Text(category)))
                    .toList(),
                decoration: InputDecoration(labelText: "Category"),
                validator: (value) =>
                value == null ? 'Please select a category' : null,
              ),
              SizedBox(height: 20),

              // Amount Input (PKR)
              TextFormField(
                decoration: InputDecoration(labelText: "Amount (PKR)"),
                keyboardType: TextInputType.number,
                onSaved: (value) => _amount = double.tryParse(value ?? '') ?? 0.0,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Please enter an amount';
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Description Input
              TextFormField(
                decoration: InputDecoration(labelText: "Description (Optional)"),
                onSaved: (value) => _description = value ?? '',
              ),
              SizedBox(height: 20),

              // Account (Non-editable, filled based on Category)
              TextFormField(
                enabled: false, // Account is set automatically based on category
                decoration: InputDecoration(
                  labelText: "Account",
                  hintText: _account,
                ),
              ),
              SizedBox(height: 20),

              // Date Picker
              ListTile(
                title: Text("Date: ${_date.toLocal().toString().split(' ')[0]}"),
                trailing: Icon(Icons.calendar_today),
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: _date,
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (selectedDate != null && selectedDate != _date) {
                    setState(() {
                      _date = selectedDate;
                    });
                  }
                },
              ),
              SizedBox(height: 20),

              // Submit Button
              ElevatedButton(
                onPressed: _saveExpense,
                child: Text("Save Expense"),
              ),
              SizedBox(height: 20),

              // Display Saved Expenses
              Expanded(
                child: ListView.builder(
                  itemCount: _expenses.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_expenses[index]['category']!),
                      subtitle: Text(
                          'Amount: PKR ${_expenses[index]['amount']} - Account: ${_expenses[index]['account']}'),
                      trailing: Text(_expenses[index]['date']!),
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
