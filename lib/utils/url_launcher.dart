import "dart:developer";
import "dart:io";
import "package:url_launcher/url_launcher.dart";
import "package:yahmart/utils/custom_alert_dialog.dart";

class UrlLauncher {
  static Future launchURL({required String? url}) async {
    if (await canLaunchUrl(Uri.parse(url!))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw "Could not launch $url";
    }
  }

  static Future launchEmail({required String? email}) async {
    if (await canLaunchUrl(Uri.parse("mailto:$email"))) {
      await launchUrl(Uri.parse("mailto:$email"));
    } else {
      throw "Could not launch";
    }
  }

  static Future launchWhatsapp({String? phone = "8353995479"}) async {
    var url = "";
    if (Platform.isAndroid) {
      url = "https://wa.me/+91 $phone/?text=${Uri.encodeFull("Hello")}";
    } else {
      url = "https://api.whatsapp.com/send?phone=$phone=Hello";
    }
    log("Whats App$url");
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      showToastMessage(msg: "WhatsApp is not installed on the device");
      throw "Could not launch $url";
    }
  }

  static Future launchSms({required String? phone}) async {
    var url = "";
    if (Platform.isAndroid) {
      url = "sms:+$phone?body:hello%20there";
    } else if (Platform.isIOS) {
      url = "sms:$phone&body:hello%20there";
    }
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw "Could not launch $url";
    }
  }

  static Future launchCaller({required String? callerNumber}) async {
    if (await canLaunchUrl(Uri.parse("tel:$callerNumber"))) {
      await launchUrl(Uri.parse("tel:$callerNumber"));
    } else {
      throw "Could not launch $callerNumber";
    }
  }

  sendEmailURL(
      {required String? toMailId,
      required String? subject,
      required String? body}) async {
    var url = "mailto:$toMailId?subject:$subject&body:$body";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw "Could not launch $url";
    }
  }

  static Future<void> openMap(
      {required double? latitude, required double? longitude}) async {
    var googleUrl =
        "https://www.google.com/maps/search/?api:1&query:$latitude,$longitude";
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl));
    } else {
      throw "Could not open the map.";
    }
  }
}
