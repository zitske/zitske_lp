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

  Widget _buildMenuItem(BuildContext context, String title, String route) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: MouseRegion(
        onHover: (_) {
          onMenuItemTap(title);
          (context as Element).markNeedsBuild();
        },
        onExit: (_) {
          onMenuItemTap('');
          (context as Element).markNeedsBuild();
        },
        child: GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, route);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 1,
                width:
                    isHovering[title] == true
                        ? (title.length * 6.15).toDouble()
                        : 0,
                color: Colors.white,
                alignment: Alignment.centerLeft,
                child: Align(
                  alignment:
                      isHovering[title] == true
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                  child: Container(
                    height: 1,
                    width: double.infinity,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
