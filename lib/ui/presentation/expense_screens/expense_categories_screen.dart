import 'package:flutter/material.dart';

class ExpenseCategoriesScreen extends StatefulWidget {
  @override
  _ExpenseCategoriesScreenState createState() =>
      _ExpenseCategoriesScreenState();
}

class _ExpenseCategoriesScreenState extends State<ExpenseCategoriesScreen> {
  final List<String> _categories = ['Salaries', 'Bills', 'Maintenance', 'Supplies', 'Events'];
  final List<String> _accounts = [
    'Personnel Expenses',
    'Utilities Expenses',
    'Maintenance Expenses',
    'Operational Expenses',
    'Event Expenses'
  ];

  void _addCategory(String category, String account) {
    setState(() {
      _categories.add(category);
      _accounts.add(account);
    });
  }

  void _deleteCategory(int index) {
    setState(() {
      _categories.removeAt(index);
      _accounts.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Expense Categories")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                final Map<String, String>? result = await showDialog<Map<String, String>>(
                  context: context,
                  builder: (context) {
                    String newCategory = '';
                    String newAccount = '';
                    return AlertDialog(
                      title: Text("Add Category"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            onChanged: (value) {
                              newCategory = value;
                            },
                            decoration: InputDecoration(hintText: 'Category Name'),
                          ),
                          TextField(
                            onChanged: (value) {
                              newAccount = value;
                            },
                            decoration: InputDecoration(hintText: 'Account Name'),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            // Only return if both fields are not empty
                            if (newCategory.isNotEmpty && newAccount.isNotEmpty) {
                              Navigator.of(context).pop({'category': newCategory, 'account': newAccount});
                            } else {
                              Navigator.of(context).pop();
                            }
                          },
                          child: Text("Add"),
                        ),
                      ],
                    );
                  },
                );

                // If result is not null, add the new category and account
                if (result != null) {
                  _addCategory(result['category']!, result['account']!);
                }
              },
              child: Text("Add Category"),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_categories[index]),
                    subtitle: Text(_accounts[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _deleteCategory(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
