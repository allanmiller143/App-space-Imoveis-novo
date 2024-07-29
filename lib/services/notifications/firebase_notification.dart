import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:space_imoveis/config/controllers/global_controller.dart';
import 'package:space_imoveis/services/notifications/firebase_credentials.dart';

class FirebaseNotification {
  late String phoneToken;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  FirebaseNotification() {
    initMessaging();
  }

  Future<void> initMessaging() async {
    await Firebase.initializeApp();
    phoneToken = await _firebaseMessaging.getToken() ?? '';
    MyGlobalController mgc = Get.find();
    mgc.phoneToken = phoneToken;
  }

  Future<AccessToken> getAccessToken() async {
    final accountCredentials = ServiceAccountCredentials.fromJson(firebaseCredentials); // Use the imported credentials

    final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

    final authClient = await clientViaServiceAccount(accountCredentials, scopes);
    return authClient.credentials.accessToken;
  }

  Future<void> sendNotificationToUser(String token, String title, String body) async {
    final Uri url = Uri.parse('https://fcm.googleapis.com/v1/projects/spaceimoveis-72b28/messages:send');
    final AccessToken accessToken = await getAccessToken();
    final String serverKey = 'Bearer ${accessToken.data}';
    print('server Token $serverKey');
    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': serverKey,
    };

    final Map<String, dynamic> notification = {
      'title': title,
      'body': body,
    };

    final Map<String, dynamic> requestBody = {
      'message': {
        'token': token,
        'notification': notification,
      },
    };

    final http.Response response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      print('Notification sent successfully');
    } else {
      print('Failed to send notification. Error: ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  Future<void> send(String token, String title, String body) async {
    await sendNotificationToUser(token, title, body);
  }
}
