import 'package:url_launcher/url_launcher.dart';

class EmergencyService {
  Future<void> triggerEmergency() async {
    final Uri call = Uri(scheme: 'tel', path: '01712345678'); // family number
    if (await canLaunchUrl(call)) {
      await launchUrl(call);
    }
  }
}
