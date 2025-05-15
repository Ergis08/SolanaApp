import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  bool _showEmail = false;
  bool _showPhone = false;
  bool _showAddress = false;

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contact Us'), backgroundColor: Colors.blue),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            VisibilityDetector(
              key: Key('email'),
              onVisibilityChanged: (info) {
                if (info.visibleFraction > 0 && !_showEmail) {
                  setState(() => _showEmail = true);
                }
              },
              child: AnimatedOpacity(
                opacity: _showEmail ? 1.0 : 0.0,
                duration: Duration(milliseconds: 600),
                child: buildContactWidget(
                  icon: Icons.email_outlined,
                  text: 'Email: eziu22@beder.edu.al',
                  onTap: () => _launchURL('mailto:eziu22@beder.edu.al'),
                ),
              ),
            ),
            SizedBox(height: 20),
            VisibilityDetector(
              key: Key('phone'),
              onVisibilityChanged: (info) {
                if (info.visibleFraction > 0 && !_showPhone) {
                  setState(() => _showPhone = true);
                }
              },
              child: AnimatedOpacity(
                opacity: _showPhone ? 1.0 : 0.0,
                duration: Duration(milliseconds: 600),
                child: buildContactWidget(
                  icon: Icons.phone_outlined,
                  text: 'Phone: +355699681772',
                  onTap: () => _launchURL('tel:+355699681772'),
                ),
              ),
            ),
            SizedBox(height: 20),
            VisibilityDetector(
              key: Key('address'),
              onVisibilityChanged: (info) {
                if (info.visibleFraction > 0 && !_showAddress) {
                  setState(() => _showAddress = true);
                }
              },
              child: AnimatedOpacity(
                opacity: _showAddress ? 1.0 : 0.0,
                duration: Duration(milliseconds: 600),
                child: buildContactWidget(
                  icon: Icons.location_on_outlined,
                  text: 'Address: Rruga Shyqyri Peza 4, Tiranë, Albania',
                  onTap:
                      () => _launchURL(
                        'https://www.google.com/maps?q=Rruga+Shyqyri+Peza+4,+Tiranë,+Albania',
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildContactWidget({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, color: Colors.blue),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
