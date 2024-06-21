import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 200, // Fixed height for the banner row
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    BannerItem(
                      title: 'TrackResult 1',
                      subtitle: 'Manage your tournaments effortlessly',
                      gradientColors: [
                        Colors.red.shade800,
                        Colors.orange.shade800
                      ],
                      route: '/points_table',
                    ),
                    SizedBox(width: 20),
                    BannerItem(
                      title: 'TrackResult 2',
                      subtitle: 'Manage your tournaments effortlessly',
                      gradientColors: [
                        Colors.blue.shade800,
                        Colors.indigo.shade800
                      ],
                      route: '/create_slot',
                    ),
                    SizedBox(width: 20),
                    BannerItem(
                      title: 'TrackResult 3',
                      subtitle: 'Manage your tournaments effortlessly',
                      gradientColors: [
                        Colors.green.shade800,
                        Colors.teal.shade800
                      ],
                      route: '/download',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  ListItem(
                    title: 'Points Table',
                    subtitle: '',
                    gradientColors: [
                      Colors.purple.shade800,
                      Colors.deepPurple.shade800
                    ],
                    route: '/points_table',
                  ),
                  ListItem(
                    title: 'Create Slot',
                    subtitle: '',
                    gradientColors: [
                      Colors.green.shade800,
                      Colors.teal.shade800
                    ],
                    route: '/create_slot',
                  ),
                  ListItem(
                    title: 'Download Slot',
                    subtitle: '',
                    gradientColors: [
                      Colors.orange.shade800,
                      Colors.deepOrange.shade800
                    ],
                    route: '/download',
                  ),
                  ListItem(
                    title: 'Edit Tournament',
                    subtitle: '',
                    gradientColors: [
                      Colors.blue.shade800,
                      Colors.lightBlue.shade800
                    ],
                    route: '/edit_tournament',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BannerItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Color> gradientColors;
  final String route;

  const BannerItem({
    required this.title,
    required this.subtitle,
    required this.gradientColors,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200, // Adjusted height for the banner items
      width: MediaQuery.of(context).size.width * 0.84, // Adjust width as needed
      margin: EdgeInsets.only(right: 1),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    subtitle,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 8,
            right: 8,
            child: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Color> gradientColors;
  final String route;

  const ListItem({
    required this.title,
    required this.subtitle,
    required this.gradientColors,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Container(
        height: 60, // Reduced height for other items
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (subtitle.isNotEmpty) ...[
                    SizedBox(height: 8),
                    Text(
                      subtitle,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}
