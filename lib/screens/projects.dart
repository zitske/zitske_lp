import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../elements/appbar.dart';
import '../elements/projcards.dart';

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

  final List<Map<String, dynamic>> _projects = [
    {
      'title': 'FindOut',
      'description':
          'O Find Out é uma plataforma avançada de recuperação veicular que utiliza tecnologia de ponta para auxiliar na localização e recuperação de veículos...',
      'features': [
        'Supabase integrations',
        'Login/Logout/Register/Recover',
        'Google Maps integration',
        'Camera integration',
        'Realtime Database',
        '2 FactorAuth',
      ],
      'imagePath': 'assets/images/projects/findout.png',
      'tags': ['Flutter', 'Android'],
      'link':
          'https://play.google.com/store/apps/details?id=com.findoutbr.findout', // Novo link
      'reviewerName': 'John Doe', // Novo campo
      'reviewerDescription':
          'Tech Enthusiast and Flutter Developer.', // Novo campo
      'reviewerImagePath': 'assets/images/reviewers/john_doe.jpg', // Novo campo
    },
    {
      'title': 'Validata',
      'description':
          'Plataforma de gestão inteligente da validade de seus produtos monitorando, alertando e gerando relatórios sobre o vencimento.',
      'features': ['Firebase Auth', 'Firebase Database', 'Firebase Storage'],
      'imagePath': 'assets/images/projects/vdata.png',
      'tags': ['Web', 'iOS', 'Android', 'Flutter'],
      'link': 'https://www.linkedin.com/company/validatabr', // Novo link
      'reviewerName': 'Henrique Jann', // Novo campo
      'reviewerDescription': 'Encheção de linguiça.', // Novo campo
      'reviewerImagePath': 'assets/images/projects/henrique.jpg', // Novo campo
    },
    {
      'title': 'B2 Inteligência em Cobrança',
      'description':
          'Transformando inadimplência em inteligência para o seu negócio.',
      'features': [
        'PDF Generation',
        'Firebase Integration',
        'REST API',
        'PDF Security',
        'Heroku Deployment',
        'Spreadsheet Integration',
      ],
      'imagePath': 'assets/images/projects/b2.jpg',
      'tags': ['NodeJS', 'Web'],
      'link': 'https://www.linkedin.com/company/b2cobrancas', // Novo link
      'reviewerName': 'Fernando Berwanger', // Novo campo
      'reviewerDescription':
          'Full Stack Developer and Cloud Expert.', // Novo campo
      'reviewerImagePath': 'assets/images/projects/fernando.jpg', // Novo campo
    },
    // Adicione mais projetos aqui
  ];

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
                            itemCount: _projects.length,
                            itemBuilder: (context, index) {
                              final isCurrent = index == _currentIndex;
                              final project = _projects[index];
                              return AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                transform:
                                    Matrix4.identity()
                                      ..scale(isCurrent ? 1.0 : 0.9),
                                child: ProjectCard(
                                  title: project['title'],
                                  description: project['description'],
                                  features: project['features'],
                                  imagePath: project['imagePath'],
                                  tags: project['tags'],
                                  isCurrent: isCurrent,
                                  onVisitPressed: _launchURL,
                                  link: project['link'], // Passando o link
                                  reviewerName:
                                      project['reviewerName'], // Passando o novo campo
                                  reviewerDescription:
                                      project['reviewerDescription'], // Passando o novo campo
                                  reviewerImagePath:
                                      project['reviewerImagePath'], // Passando o novo campo
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
                                if (_currentIndex < _projects.length - 1) {
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
