import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';  // Importing FontAwesome Flutter

class Sidebar extends StatefulWidget {
  final Function(int) onItemTapped;

  const Sidebar({required this.onItemTapped, super.key});

  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  int? _expandedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      decoration: BoxDecoration(
        color: Color(0xFF2C2C2C),
        borderRadius: BorderRadius.horizontal(right: Radius.circular(20)),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildHeader(),
          Divider(color: Colors.grey[700]),

          // Dashboard
          _buildListItem(
            title: 'Dashboard',
            icon: FontAwesomeIcons.tachometerAlt,
            index: 0,
          ),

          // Students Section
          _buildExpandableTile(
            title: 'Students',
            icon: FontAwesomeIcons.userGraduate,
            index: 1,
            children: [
              _buildListItem(title: 'Add Student', icon: FontAwesomeIcons.userPlus, index: 1),
              _buildListItem(title: 'View Students', icon: FontAwesomeIcons.users, index: 2),
              _buildListItem(title: 'Pay Fee', icon: FontAwesomeIcons.moneyBillWave, index: 3),
            ],
          ),

          // Teachers Section
          _buildExpandableTile(
            title: 'Teachers',
            icon: FontAwesomeIcons.chalkboardTeacher,
            index: 2,
            children: [
              _buildListItem(title: 'Add Teachers', icon: FontAwesomeIcons.userPlus, index: 4),
              _buildListItem(title: 'Manage Teachers', icon: FontAwesomeIcons.userEdit, index: 5),
            ],
          ),

          // Classes Section
          _buildExpandableTile(
            title: 'Classes and Subjects',
            icon: FontAwesomeIcons.bookOpen,
            index: 3,
            children: [
              _buildListItem(title: 'Manage Subjects', icon: FontAwesomeIcons.circlePlus, index: 6),
              _buildListItem(title: 'Manage Classes', icon: FontAwesomeIcons.rectangleList, index: 7),
            ],
          ),

          // Parents Management Section
          _buildExpandableTile(
            title: 'Parents Management',
            icon: FontAwesomeIcons.userShield,
            index: 4,
            children: [
              _buildListItem(title: 'Add Parent Accounts', icon: FontAwesomeIcons.userPlus, index: 8),
              _buildListItem(title: 'View Parent Accounts', icon: FontAwesomeIcons.users, index: 9),
            ],
          ),


          // Fee Management Section
          _buildExpandableTile(
            title: 'Fee Management',
            icon: FontAwesomeIcons.creditCard,
            index: 6,
            children: [
              _buildListItem(title: 'View Fee', icon: FontAwesomeIcons.eye, index: 12),
              _buildListItem(title: 'Fee Generation', icon: FontAwesomeIcons.fileInvoice, index: 14),
              _buildListItem(title: 'Fee Payments', icon: FontAwesomeIcons.wallet, index: 15),
            ],
          ),

          // Time Tables Section
          _buildExpandableTile(
            title: 'Time Tables',
            icon: FontAwesomeIcons.clock,
            index: 7,
            children: [
              _buildListItem(title: 'View TimeTables', icon: FontAwesomeIcons.table, index: 16),
              _buildListItem(title: 'Create TimeTables', icon: FontAwesomeIcons.calendarAlt, index: 17),
            ],
          ),

          // Attendance Section
          _buildExpandableTile(
            title: 'Attendance',
            icon: FontAwesomeIcons.checkCircle,
            index: 8,
            children: [
              _buildListItem(title: 'Take Attendance', icon: FontAwesomeIcons.userCheck, index: 19),
              _buildListItem(title: 'Attendance Reports', icon: FontAwesomeIcons.chartLine, index: 20),
            ],
          ),

          // Exam Section
          _buildExpandableTile(
            title: 'Exam',
            icon: FontAwesomeIcons.edit,
            index: 9,
            children: [
              _buildListItem(title: 'Under Development', icon: FontAwesomeIcons.underline, index: 21),

              // _buildListItem(title: 'Exam Registration', icon: FontAwesomeIcons.pen, index: 21),
              // _buildListItem(title: 'Marks Entry Screen', icon: Icons.transit_enterexit, index: 22),
              // _buildListItem(title: 'Exam Screen', icon: FontAwesomeIcons.chalkboard, index: 23),
              // _buildListItem(title: 'Exam Results Screen', icon: FontAwesomeIcons.squarePollVertical, index: 24),
              // _buildListItem(title: 'Exam Scheduling Screen', icon: FontAwesomeIcons.calendar, index: 25),
            ],
          ),

          // Expenses Section
          _buildExpandableTile(
            title: 'Expenses',
            icon: FontAwesomeIcons.dollarSign,
            index: 10,
            children: [
              _buildListItem(title: 'Expense Dashboard', icon: FontAwesomeIcons.chartBar, index: 27),
              _buildListItem(title: 'Add New Expense', icon: FontAwesomeIcons.plusCircle, index: 28),
              _buildListItem(title: 'Expense Categories', icon: FontAwesomeIcons.coins, index: 29),
            ],
          ),

          // Canteen Section
          _buildExpandableTile(
            title: 'Canteen',
            icon: FontAwesomeIcons.utensils,
            index: 11,
            children: [
              _buildListItem(title: 'Selling Screen', icon: FontAwesomeIcons.store, index: 32),
              _buildListItem(title: 'Products List', icon: FontAwesomeIcons.list, index: 33),
              _buildListItem(title: 'Stock Management', icon: FontAwesomeIcons.cogs, index: 34),
              _buildListItem(title: 'Sales Report', icon: FontAwesomeIcons.chartBar, index: 37),
            ],
          ),

          // Staff Section
          _buildExpandableTile(
            title: 'Staff',
            icon: FontAwesomeIcons.userTie,
            index: 12,
            children: [
              _buildListItem(title: 'Staff Screen', icon: FontAwesomeIcons.users, index: 38),
              _buildListItem(title: 'Take Staff Attendance', icon: FontAwesomeIcons.userCog, index: 40),
              _buildListItem(title: 'Staff Attendance Report', icon: FontAwesomeIcons.userCog, index: 41),

            ],
          ),

          // Salaries Section
          _buildExpandableTile(
            title: 'Salaries',
            icon: FontAwesomeIcons.moneyCheckAlt,
            index: 13,
            children: [
              _buildListItem(title: 'Dashboard', icon: FontAwesomeIcons.moneyBill, index: 41),
              _buildListItem(title: 'Report Screen', icon: FontAwesomeIcons.chartBar, index: 42),
              _buildListItem(title: 'Generate Salaries', icon: FontAwesomeIcons.history, index: 43),
              _buildListItem(title: 'Salary Reports', icon: FontAwesomeIcons.fileInvoice, index: 44),
              _buildListItem(title: 'Salary Payslips', icon: FontAwesomeIcons.print, index: 45),
            ],
          ),

          // Accounts Section
          _buildExpandableTile(
            title: 'Accounts',
            icon: FontAwesomeIcons.book,
            index: 14,
            children: [
              _buildListItem(title: 'Revenue Expense Screen', icon: FontAwesomeIcons.cashRegister, index: 46),
              _buildListItem(title: 'Reports', icon: FontAwesomeIcons.chartPie, index: 47),
            ],
          ),

          // Settings Section
          _buildListItem(
            title: 'Settings',
            icon: FontAwesomeIcons.cogs,
            index: 50,
          ),

          // About Section
          _buildListItem(
            title: 'About',
            icon: FontAwesomeIcons.infoCircle,
            index: 51,
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Text(
        'Services Public School and College',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildListItem({
    required String title,
    required IconData icon,
    required int index,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      onTap: () => widget.onItemTapped(index),
    );
  }

  Widget _buildExpandableTile({
    required String title,
    required IconData icon,
    required int index,
    required List<Widget> children,
  }) {
    return ExpansionTile(
      collapsedIconColor: Colors.white,
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: TextStyle(color: Colors.white)),
      onExpansionChanged: (expanded) {
        setState(() {
          _expandedIndex = expanded ? index : null;
        });
      },
      backgroundColor: Colors.grey.shade800,
      childrenPadding: EdgeInsets.only(left: 40),
      iconColor: Colors.white,
      children: _expandedIndex == index ? children : [],
    );
  }
}
