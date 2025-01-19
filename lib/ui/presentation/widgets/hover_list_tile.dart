import 'package:flutter/material.dart';

class HoverListTile extends StatefulWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const HoverListTile({
    required this.title,
    required this.icon,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  _HoverListTileState createState() => _HoverListTileState();
}

class _HoverListTileState extends State<HoverListTile> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: ListTile(
        leading: Icon(widget.icon, color: isHovered ? Colors.yellow : Colors.white),
        title: Text(
          widget.title,
          style: TextStyle(color: isHovered ? Colors.yellow : Colors.white),
        ),
        tileColor: isHovered ? Colors.blue : Colors.transparent,
        onTap: widget.onTap,
      ),
    );
  }
}