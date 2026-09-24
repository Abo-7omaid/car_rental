import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

static const String ChannelId = 'Car-Rental';
static const String ChannelName = 'Car Booking';
static const String ChannelDesc = 'Notifications for successful car rentals';

  static Future<void> init() async {

    const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    // 3. Setup iOS settings
    const DarwinInitializationSettings iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

// // Create Android Notification Channels (Mandatory for Android 8.0+)

    if(Platform.isAndroid){
      final androidImpl =
      _notificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();


      if(androidImpl != null){
        
        await androidImpl.createNotificationChannel(
          AndroidNotificationChannel(
            ChannelId,
            ChannelName,
            description: ChannelDesc,
            importance: Importance.max,
            playSound: true,
            enableVibration: true,
            enableLights: true,
          ),
        );
      }


    }



    // 4. Start the plugin
    await _notificationsPlugin.initialize(settings: initSettings,
      onDidReceiveNotificationResponse: (details) {
      debugPrint('Notification tapped with payload: ${details.payload}');
    },);
  }




  static Future<void> showNotification({required String title, required String body}) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'rentride_bookings', // Channel ID
      'Car Bookings', // Channel Name
      channelDescription: 'Notifications for successful car rentals',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
    );

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
    );

    await _notificationsPlugin.show(


      id: 0,
      body: body,
      title: title,
      notificationDetails: platformDetails
    );
}
  }
