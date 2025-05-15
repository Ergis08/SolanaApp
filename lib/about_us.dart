import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  bool _showAbout = false;
  bool _showMission = false;
  bool _showVision = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        backgroundColor: Colors.blue[800],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            VisibilityDetector(
              key: Key('about'),
              onVisibilityChanged: (info) {
                if (info.visibleFraction > 0 && !_showAbout) {
                  setState(() => _showAbout = true);
                }
              },
              child: AnimatedOpacity(
                opacity: _showAbout ? 1.0 : 0.0,
                duration: Duration(milliseconds: 600),
                child: buildCard(
                  icon: Icons.info_outline,
                  title: 'About Solana Eyewear',
                  content:
                      'Solana Eyewear is a premium eyewear brand that blends fashion, function, and innovation. Inspired by the warmth and brilliance of sunlight (Solana), our brand is dedicated to crafting high-quality, stylish, and durable eyewear that enhances vision while making a statement.',
                ),
              ),
            ),
            SizedBox(height: 20),
            VisibilityDetector(
              key: Key('mission'),
              onVisibilityChanged: (info) {
                if (info.visibleFraction > 0 && !_showMission) {
                  setState(() => _showMission = true);
                }
              },
              child: AnimatedOpacity(
                opacity: _showMission ? 1.0 : 0.0,
                duration: Duration(milliseconds: 600),
                child: buildCard(
                  icon: Icons.flag_outlined,
                  title: 'Mission Statement',
                  content:
                      'At Solana, our mission is to craft exquisite eyewear that elevates vision into a luxury experience. We are committed to designing frames that seamlessly combine superior craftsmanship, timeless elegance, and innovative style. Our goal is to offer our discerning clientele eyewear that not only enhances clarity but also reflects their sophisticated sense of taste.',
                  backgroundColor: Colors.lightBlue.shade50,
                ),
              ),
            ),
            SizedBox(height: 20),
            VisibilityDetector(
              key: Key('vision'),
              onVisibilityChanged: (info) {
                if (info.visibleFraction > 0 && !_showVision) {
                  setState(() => _showVision = true);
                }
              },
              child: AnimatedOpacity(
                opacity: _showVision ? 1.0 : 0.0,
                duration: Duration(milliseconds: 600),
                child: buildCard(
                  icon: Icons.remove_red_eye_outlined,
                  title: 'Our Vision',
                  content:
                      'Our vision is to become the global leader in luxury eyewear, where every pair of glasses embodies the perfect fusion of exceptional craftsmanship, cutting-edge design, and timeless elegance. By continually innovating and embracing artistry, we aspire to set the standard for luxury eyewear, creating an enduring legacy of elegance and excellence for generations to come.',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard({
    required IconData icon,
    required String title,
    required String content,
    Color? backgroundColor,
  }) {
    return Card(
      elevation: 4,
      color: backgroundColor ?? Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.blueAccent),
                SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(content, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
