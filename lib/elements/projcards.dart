import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCard extends StatelessWidget {
  final String title;
  final String description;
  final List<String> features;
  final String imagePath;
  final List<String> tags;
  final bool isCurrent;
  final VoidCallback onVisitPressed;
  final String link; // Novo parâmetro
  final String reviewerName; // Novo parâmetro
  final String reviewerDescription; // Novo parâmetro
  final String reviewerImagePath; // Novo parâmetro

  const ProjectCard({
    Key? key,
    required this.title,
    required this.description,
    required this.features,
    required this.imagePath,
    required this.tags,
    required this.isCurrent,
    required this.onVisitPressed,
    required this.link, // Novo parâmetro obrigatório
    required this.reviewerName, // Novo parâmetro obrigatório
    required this.reviewerDescription, // Novo parâmetro obrigatório
    required this.reviewerImagePath, // Novo parâmetro obrigatório
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(150),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                height: double.infinity,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    description,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Features:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    features.map((feature) => '- $feature').join('\n'),
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  Spacer(),
                  Row(
                    children:
                        tags.map((tag) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Chip(
                              backgroundColor:
                                  tag == 'Flutter'
                                      ? Colors.blue
                                      : tag == 'Android'
                                      ? Color(0xFFc6ff00)
                                      : tag == 'Web'
                                      ? Colors.lightBlue
                                      : tag == 'iOS'
                                      ? Colors.white
                                      : tag == 'NodeJS'
                                      ? Colors.yellow
                                      : Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              label: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    tag == 'Flutter'
                                        ? Icons.flutter_dash
                                        : tag == 'Android'
                                        ? Icons.android
                                        : tag == 'Web'
                                        ? Icons.web
                                        : tag == 'iOS'
                                        ? Icons.apple
                                        : tag == 'NodeJS'
                                        ? Icons.code
                                        : Icons.code,
                                    color: Colors.black,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    tag,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(
                              reviewerImagePath, // Usando o novo parâmetro
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                reviewerName, // Usando o novo parâmetro
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Row(
                                children: List.generate(
                                  5,
                                  (index) => Icon(
                                    Icons.star_sharp,
                                    color: Colors.amber,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        reviewerDescription, // Usando o novo parâmetro
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  MouseRegion(
                    onEnter: (_) {},
                    onExit: (_) {},
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: OutlinedButton(
                        onPressed: () async {
                          final Uri url = Uri.parse(link);
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          } else {
                            throw Exception('Could not launch $link');
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          side: BorderSide(color: Colors.transparent, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Visit',
                            style: TextStyle(
                              color: Colors.white,
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
            ),
          ),
        ],
      ),
    );
  }
}
