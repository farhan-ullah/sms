import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school/businessLogic/providers/transport_route_provider.dart';
import 'package:school/data/models/route_model.dart';

class RoutesScreen extends StatefulWidget {
  const RoutesScreen({super.key});

  @override
  State<RoutesScreen> createState() => _RoutesScreenState();
}

class _RoutesScreenState extends State<RoutesScreen> {
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final routeProvider = Provider.of<TransportRouteProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Transport Routes'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Consumer<TransportRouteProvider>(
        builder: (context, value, child) {
          List<RouteModel> routes = value.getRoutes();

          // Filter routes based on search query
          if (_searchQuery.isNotEmpty) {
            routes = routes
                .where((route) => route.routeName
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()))
                .toList();
          }

          if (routes.isEmpty) {
            return Center(
              child: Text(
                'No Routes Available',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: 'Search Routes',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
                SizedBox(height: 16),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: routes.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(16),
                        leading: Icon(
                          Icons.directions_bus,
                          color: Colors.blueAccent,
                          size: 30,
                        ),
                        title: Text(
                          routes[index].routeName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Text(
                          'Driver: ${routes[index].driverName}\nFee: \$${routes[index].routeFee}',
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),
                        ),
                        trailing: PopupMenuButton(itemBuilder: (context) {
                          return [
                            PopupMenuItem(child: ListTile(onTap: (){},
                              leading: Icon(Icons.edit),title: Text("Edit"),)),
                            PopupMenuItem(child: ListTile(
                              onTap: () {},
                              leading: Icon(Icons.delete),title: Text("Delete"),)),
                          ];
                        }),
                        onTap: () {
                          // Show the bottom sheet with route details
                          _showRouteDetailsBottomSheet(context, routes[index]);
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Open the bottom sheet to add a new route
          _showAddRouteBottomSheet(context);
        },
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.add),
      ),
    );
  }

  void _showRouteDetailsBottomSheet(BuildContext context, RouteModel route) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return RouteDetailsBottomSheet(route: route);
      },
    );
  }

  void _showAddRouteBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return AddRouteBottomSheet();
      },
    );
  }
}

class RouteDetailsBottomSheet extends StatelessWidget {
  final RouteModel route;
  const RouteDetailsBottomSheet({super.key, required this.route});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, spreadRadius: 3)],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              route.routeName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20),

          // Route Details
          Text(
            'Driver: ${route.driverName}',
            style: TextStyle(fontSize: 18, color: Colors.blueAccent),
          ),
          Text(
            'Vehicle Number: ${route.vehicleNumber}',
            style: TextStyle(fontSize: 16, color: Colors.blueAccent.withOpacity(0.7)),
          ),
          Text(
            'Route Fee: \$${route.routeFee}',
            style: TextStyle(fontSize: 16, color: Colors.blueAccent.withOpacity(0.7)),
          ),
          SizedBox(height: 10),

          // Students List Section
          Text(
            'Students on this Route:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),
          ),
          SizedBox(height: 8),
          // Expansion Tile for Students List
          ExpansionTile(
            title: Text(
              'View Students (${route.routeStudentIDs.length})',
              style: TextStyle(fontSize: 16),
            ),
            leading: Icon(Icons.people, color: Colors.blueAccent),
            children: route.routeStudentIDs.map((studentId) {
              return ListTile(
                title: Text(
                  'Student ID: $studentId',
                  style: TextStyle(fontSize: 16),
                ),
                subtitle: Text(
                  'Name: Mock Student Name',  // Replace with actual data
                  style: TextStyle(color: Colors.grey),
                ),
              );
            }).toList(),
          ),

          // Action Button to Close Bottom Sheet
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              ),
              child: Text(
                'Close',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddRouteBottomSheet extends StatefulWidget {
  @override
  _AddRouteBottomSheetState createState() => _AddRouteBottomSheetState();
}

class _AddRouteBottomSheetState extends State<AddRouteBottomSheet> {
  final TextEditingController _routeNameController = TextEditingController();
  final TextEditingController _driverNameController = TextEditingController();
  final TextEditingController _vehicleNumberController = TextEditingController();
  final TextEditingController _routeFeeController = TextEditingController();
  List<String> _selectedStudents = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, spreadRadius: 3)],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Add Route Header Section
          Text(
            'Add New Route',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueAccent),
          ),
          SizedBox(height: 20),

          // Route Name
          TextField(
            controller: _routeNameController,
            decoration: InputDecoration(
              labelText: 'Route Name',
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blueAccent)),
            ),
          ),
          SizedBox(height: 10),

          // Driver Name
          TextField(
            controller: _driverNameController,
            decoration: InputDecoration(
              labelText: 'Driver Name',
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blueAccent)),
            ),
          ),
          SizedBox(height: 10),

          // Vehicle Number
          TextField(
            controller: _vehicleNumberController,
            decoration: InputDecoration(
              labelText: 'Vehicle Number',
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blueAccent)),
            ),
          ),
          SizedBox(height: 10),

          // Route Fee
          TextField(
            controller: _routeFeeController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Route Fee',
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blueAccent)),
            ),
          ),

          // Students List

          SizedBox(height: 20),

          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close the bottom sheet
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Code to add the new route
                  // Here you should handle saving the data
                  Navigator.pop(context); // Close the bottom sheet after adding
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text('Add Route'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
