import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../elements/appbar.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';
import '../widgets/support_bottom_sheet.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _opacityAnimation;
  Flutter3DController controller3d = Flutter3DController();
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.forward();

    // Adiciona listener para executar ações após o modelo ser carregado
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Map<String, bool> _isHovering = {
    'Home': false,
    'About': false,
    'Projects': false,
    'Contact': false,
    'button': false,
    'support': false,
  };

  void _handleMenuItemHover(String title) {
    setState(() {
      _isHovering.updateAll((key, value) => key == title);
    });
  }

  void _showSupportBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SupportBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        isHovering: _isHovering,
        onMenuItemTap: _handleMenuItemHover,
      ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.asset(
              'assets/images/rideshare_feature.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width,
            child: SlideTransition(
              position: _offsetAnimation,
              child: FadeTransition(
                opacity: _opacityAnimation,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 50,
                      ), // Adicione esta linha para mover o texto para cima
                      Text(
                        'LET`S BUILD THE FUTURE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 70,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Turning ideas into code and building innovative solutions for the future.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ), // Adicione esta linha para espaçamento
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MouseRegion(
                            onEnter:
                                (_) => setState(() {
                                  _isHovering['button'] = true;
                                }),
                            onExit:
                                (_) => setState(() {
                                  _isHovering['button'] = false;
                                }),
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 200),
                              decoration: BoxDecoration(
                                color:
                                    _isHovering['button']!
                                        ? Colors.white
                                        : Colors.transparent,

                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(0),
                              ),
                              child: OutlinedButton(
                                onPressed: () async {
                                  final url = Uri.parse(
                                    'https://wa.me/+14079697555',
                                  );
                                  if (await canLaunchUrl(url)) {
                                    await launchUrl(
                                      url,
                                      mode: LaunchMode.externalApplication,
                                    );
                                  }
                                },
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  side: BorderSide(
                                    color: Colors.transparent,
                                    width: 2,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    'Contact Us',
                                    style: TextStyle(
                                      color:
                                          _isHovering['button']!
                                              ? Colors.black
                                              : Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          MouseRegion(
                            onEnter:
                                (_) => setState(() {
                                  _isHovering['support'] = true;
                                }),
                            onExit:
                                (_) => setState(() {
                                  _isHovering['support'] = false;
                                }),
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 200),
                              decoration: BoxDecoration(
                                color:
                                    _isHovering['support']!
                                        ? Colors.white
                                        : Colors.transparent,

                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(0),
                              ),
                              child: OutlinedButton(
                                onPressed: () {
                                  _showSupportBottomSheet(context);
                                },
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  side: BorderSide(
                                    color: Colors.transparent,
                                    width: 2,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    'Support',
                                    style: TextStyle(
                                      color:
                                          _isHovering['support']!
                                              ? Colors.black
                                              : Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          /* Positioned(
            top: MediaQuery.of(context).size.height / 4,
            left: MediaQuery.of(context).size.width / 4,
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width / 2,
              child: Flutter3DViewer(
                src: 'assets/3d/iphone_16_pro_max.glb',
                activeGestureInterceptor: false,
                enableTouch: false,
                controller: controller3d,
              ),
            ),
          ),*/
          Positioned(
            bottom: 10,
            left: 16,
            child: Text(
              'Zitske Group Corp. © 2025',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
