import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../businessLogic/providers/parent_provider.dart';
import '../../../data/models/parentModel/parent_model.dart';


class SearchAndSelectParent extends StatefulWidget {
  @override
  _SearchAndSelectParentState createState() => _SearchAndSelectParentState();
}

class _SearchAndSelectParentState extends State<SearchAndSelectParent> {
  final TextEditingController searchController = TextEditingController();
  List<ParentModel> filteredParents = []; // Holds filtered list of parents
  String? selectedParentId; // Holds the selected parent ID

  @override
  void initState() {
    super.initState();
    // Initialize with all parents on load
    filteredParents = Provider.of<ParentProvider>(context, listen: false).mockParentList;
  }

  @override
  Widget build(BuildContext context) {
    final parentProvider = Provider.of<ParentProvider>(context);
    final parentList = parentProvider.mockParentList;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search Bar
        TextField(
          controller: searchController,
          decoration: InputDecoration(
            labelText: "Search Parent",
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (searchQuery) {
            parentProvider.filterParents(searchQuery); // Filter the parent list
            setState(() {
              filteredParents = parentProvider.mockParentList; // Update filtered parents list
            });
          },
        ),
        const SizedBox(height: 10),

        // Dropdown to select parent from filtered list
        if (filteredParents.isNotEmpty) ...[
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Select Parent',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            ),
            value: selectedParentId,
            items: filteredParents.map<DropdownMenuItem<String>>((parent) {
              return DropdownMenuItem<String>(
                value: parent.parentId,
                child: Text('${parent.firstName} ${parent.lastName}'),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedParentId = value;
              });
              parentProvider.changeSelectedParent(
                  filteredParents.firstWhere((parent) => parent.parentId == value)
              ); // Update selected parent
            },
          ),
        ] else ...[
          Text("No parents found matching the search criteria."),
        ],
      ],
    );
  }
}
