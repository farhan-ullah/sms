import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      width: 270,
      decoration: BoxDecoration(
        color: Color(0xFF232F3E),  // Darker background
        borderRadius: BorderRadius.horizontal(right: Radius.circular(30)),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildHeader(),
          Divider(color: Colors.grey[600], thickness: 0.5),

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
            ],
          ),

          // Teachers Section
          _buildExpandableTile(
            title: 'Teachers',
            icon: FontAwesomeIcons.chalkboardTeacher,
            index: 2,
            children: [
              _buildListItem(title: 'Add Teacher', icon: FontAwesomeIcons.userPlus, index: 4),
              _buildListItem(title: 'Manage Teachers', icon: FontAwesomeIcons.userEdit, index: 5),
            ],
          ),

          // Classes Section
          _buildExpandableTile(
            title: 'Classes and Subjects',
            icon: FontAwesomeIcons.bookOpen,
            index: 3,
            children: [
              _buildListItem(title: 'Manage Subjects', icon: FontAwesomeIcons.book, index: 6),
              _buildListItem(title: 'Manage Classes', icon: FontAwesomeIcons.users, index: 7),
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
          _buildExpandableTile(
            title: 'Transport',
            icon: FontAwesomeIcons.bus,
            index: 11,
            children: [
              _buildListItem(title: 'Transport Routes', icon: FontAwesomeIcons.route, index: 30),
              // _buildListItem(title: 'Reports', icon: FontAwesomeIcons.chartPie, index: 47),
            ],
          ),

          // Canteen Section
          _buildExpandableTile(
            title: 'Canteen',
            icon: FontAwesomeIcons.utensils,
            index: 12,
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
            index: 13,
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
            index: 14,
            children: [
              _buildListItem(title: 'Salary payment Screen', icon: FontAwesomeIcons.moneyBill, index: 41),
              _buildListItem(title: 'Generate Salaries', icon: FontAwesomeIcons.chartBar, index: 42),
              _buildListItem(title: 'Salary Reports', icon: FontAwesomeIcons.fileInvoice, index: 44),
              _buildListItem(title: 'Salary Tiers', icon: FontAwesomeIcons.print, index: 45),
            ],
          ),

          // Accounts Section
          _buildExpandableTile(
            title: 'Accounts',
            icon: FontAwesomeIcons.book,
            index: 15,
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
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: ListTile(
        title: Text(
          'Services Public School and College',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
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
        style: TextStyle(color: Colors.white, fontSize: 16),
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
    return GestureDetector(
      onTap: () {
        setState(() {
          // If the current tile is already expanded, collapse it
          if (_expandedIndex == index) {
            _expandedIndex = null;
          } else {
            // Otherwise, expand this tile and collapse the others
            _expandedIndex = index;
          }
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          color: _expandedIndex == index ? Colors.blueGrey.shade800 : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              leading: Icon(icon, color: Colors.white),
              title: Text(title, style: TextStyle(color: Colors.white, fontSize: 16)),
              trailing: Icon(size: 15,
                _expandedIndex == index
                    ? FontAwesomeIcons.chevronUp
                    : FontAwesomeIcons.chevronDown,
                color: Colors.white,
              ),
            ),
            if (_expandedIndex == index)
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                padding: EdgeInsets.only(left: 40, top: 8),
                child: Column(children: children),
              ),
          ],
        ),
      ),
    );
  }
}
