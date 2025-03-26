import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../elements/appbar.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _opacityAnimation;
  int _currentIndex = 0;

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
  };

  void _handleMenuItemHover(String title) {
    setState(() {
      _isHovering.updateAll((key, value) => key == title);
    });
  }

  Future<void> _launchURL() async {
    final Uri url = Uri.parse(
      'https://play.google.com/store/apps/details?id=com.findoutbr.findout',
    );
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final PageController _pageController = PageController(
      viewportFraction: 0.8,
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        isHovering: _isHovering,
        onMenuItemTap: _handleMenuItemHover,
      ),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.asset('assets/images/starship.jpg', fit: BoxFit.cover),
          ),
          Positioned(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width,
            child: SlideTransition(
              position: _offsetAnimation,
              child: FadeTransition(
                opacity: _opacityAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 100),
                    Text(
                      'OUR PROJECTS',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Explore our innovative projects and see how we are shaping the future.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          PageView.builder(
                            controller: _pageController,
                            onPageChanged: (index) {
                              setState(() {
                                _currentIndex = index;
                              });
                            },
                            itemCount: 4, // Número de projetos
                            itemBuilder: (context, index) {
                              final isCurrent = index == _currentIndex;
                              return AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                transform:
                                    Matrix4.identity()
                                      ..scale(isCurrent ? 1.0 : 0.9),
                                child: Container(
                                  height:
                                      double
                                          .infinity, // Card ocupa altura máxima
                                  decoration: BoxDecoration(
                                    color: Colors.black.withAlpha(
                                      150,
                                    ), // Fundo preto com opacidade baixa
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      // Imagem no lado esquerdo
                                      Expanded(
                                        flex: 2,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                          ),
                                          child: Image.asset(
                                            'assets/images/projects/findout.png', // Substitua pelo caminho correto da imagem
                                            fit: BoxFit.cover,
                                            height: double.infinity,
                                          ),
                                        ),
                                      ),
                                      // Dados do projeto no centro
                                      Expanded(
                                        flex: 5,
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                'FindOut',
                                                style: TextStyle(
                                                  fontSize: 40,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      Colors
                                                          .white, // Alterado para branco
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                'O Find Out é uma plataforma avançada de recuperação veicular que utiliza tecnologia de ponta para auxiliar na localização e recuperação de veículos. Com verificação de placas em tempo real, alertas inteligentes e histórico completo, o Find Out oferece segurança e tranquilidade para seus usuários.',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color:
                                                      Colors
                                                          .white, // Alterado para branco
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                'Features:',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      Colors
                                                          .white, // Alterado para branco
                                                ),
                                              ),
                                              Text(
                                                '- Supabase integrations\n- Login/Logout/Register/Recover\n- Google Maps integration\n- Camera integration\n- Realtime Database\n- 2 FactorAuth',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color:
                                                      Colors
                                                          .white, // Alterado para branco
                                                ),
                                              ),
                                              Spacer(),

                                              Row(
                                                children: [
                                                  Chip(
                                                    backgroundColor:
                                                        Colors.blue,

                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            20,
                                                          ),
                                                    ),
                                                    label: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Icon(
                                                          Icons.flutter_dash,
                                                          color: Colors.black,
                                                        ),
                                                        SizedBox(width: 5),
                                                        Text(
                                                          'Flutter',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Chip(
                                                    backgroundColor: Color(
                                                      0xFFc6ff00,
                                                    ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            20,
                                                          ),
                                                    ),
                                                    label: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Icon(
                                                          Icons.android,
                                                          color: Colors.black,
                                                        ),
                                                        SizedBox(width: 5),
                                                        Text(
                                                          'Android',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // Botão "Visitar" no lado direito
                                      Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,

                                            children: [
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 30,
                                                        backgroundImage: AssetImage(
                                                          'assets/images/profile.jpg', // Substitua pelo caminho correto da imagem
                                                        ),
                                                      ),
                                                      SizedBox(width: 10),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Name",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 20,
                                                            ),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .star_sharp,
                                                                color:
                                                                    Colors
                                                                        .amber,
                                                                size: 20,
                                                              ),
                                                              Icon(
                                                                Icons
                                                                    .star_sharp,
                                                                color:
                                                                    Colors
                                                                        .amber,
                                                                size: 20,
                                                              ),
                                                              Icon(
                                                                Icons
                                                                    .star_sharp,
                                                                color:
                                                                    Colors
                                                                        .amber,
                                                                size: 20,
                                                              ),
                                                              Icon(
                                                                Icons
                                                                    .star_sharp,
                                                                color:
                                                                    Colors
                                                                        .amber,
                                                                size: 20,
                                                              ),
                                                              Icon(
                                                                Icons
                                                                    .star_sharp,
                                                                color:
                                                                    Colors
                                                                        .amber,
                                                                size: 20,
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse erat massa, sodales dapibus molestie at, volutpat eget neque. Phasellus aliquet orci maximus magna ornare finibus. Integer et sagittis tortor. Vivamus id lobortis lectus. Aliquam egestas vel risus in varius. Vestibulum sit amet consectetur metus.",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              SizedBox(height: 10),
                                              MouseRegion(
                                                onEnter:
                                                    (_) => setState(() {
                                                      _isHovering['button'] =
                                                          true;
                                                    }),
                                                onExit:
                                                    (_) => setState(() {
                                                      _isHovering['button'] =
                                                          false;
                                                    }),
                                                child: AnimatedContainer(
                                                  duration: Duration(
                                                    milliseconds: 200,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        _isHovering['button']!
                                                            ? Colors.white
                                                            : Colors
                                                                .transparent,
                                                    border: Border.all(
                                                      color: Colors.white,
                                                      width: 2,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          0,
                                                        ),
                                                  ),
                                                  child: OutlinedButton(
                                                    onPressed: _launchURL,
                                                    style: OutlinedButton.styleFrom(
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      side: BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                        width: 2,
                                                      ),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              0,
                                                            ),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                            15.0,
                                                          ),
                                                      child: Text(
                                                        'Visit',
                                                        style: TextStyle(
                                                          color:
                                                              _isHovering['button']!
                                                                  ? Colors.black
                                                                  : Colors
                                                                      .white,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          Positioned(
                            left: 10,
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                if (_currentIndex > 0) {
                                  _pageController.previousPage(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                }
                              },
                            ),
                          ),
                          Positioned(
                            right: 10,
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                if (_currentIndex < 3) {
                                  _pageController.nextPage(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: MediaQuery.of(context).size.width / 2.2,
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
