import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Map<String, bool> isHovering;
  final Function(String) onMenuItemTap;

  const CustomAppBar({
    Key? key,
    required this.isHovering,
    required this.onMenuItemTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 100,
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "ZITSKE GROUP",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.normal,
            ),
          ),
          /*const Spacer(),
          _buildMenuItem(context, 'Home', '/'),
          _buildMenuItem(context, 'About', '/about'),
          _buildMenuItem(context, 'Projects', '/projects'),
          _buildMenuItem(context, 'Contact', '/contact'),
          const Spacer(),
          const SizedBox(width: 120),*/
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
