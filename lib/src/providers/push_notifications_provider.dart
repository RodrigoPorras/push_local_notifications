import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationProvider {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final _mensajesStreamController = StreamController<String>.broadcast();

  Stream<String> get mensajes => _mensajesStreamController.stream;

  initNotifications() {
    _firebaseMessaging.requestNotificationPermissions();

    _firebaseMessaging.getToken().then((token) {
      print('=== FCM tokebn ===');
      print(token);

      //crPYXPbjXxM:APA91bF7Vg7uv3tdQnAyCliYLqgn88axQS2iXoAWjJI-gQRp0VUmX25kYj2mauVyoQhXk07yXQZVIvsVb_Yvm1KMBBPNRChRkcKPivDcfkk33PJObtF7_Y2lHwnOp_hLnAq8BE0K-rbj
    });

    _firebaseMessaging.configure(
        onMessage: (info) async {
          print( '======= On Message =====' );

          print(info);

          String argumento = 'no-data';
          if( Platform.isAndroid ){
            argumento = info['data']['comida'] ?? 'no-data';
          }

          _mensajesStreamController.sink.add(argumento);
        },
        onLaunch: (info) async {
          print( '======= On Launch =====' );

          print(info);

          final argumento = info['data']['comida'];

          print(argumento);

        },
        onResume: (info) async {
          print( '======= On Resume =====' );
          print(info);

          String argumento = 'no-data';
          if( Platform.isAndroid ){
            argumento = info['data']['comida'] ?? 'no-data';
          }

          _mensajesStreamController.sink.add(argumento);
        });
  }

  dispose(){
    _mensajesStreamController?.close();
  }
}
