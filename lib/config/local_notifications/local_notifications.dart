import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:push_app/config/router/app_router.dart';

class LocalNotifications {
  static Future<void> requestPermissionLocalNotidications() async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static Future<void> initializeLocalNotafications() async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    //todo ios configuration

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      //todo ios configuration
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        //todo
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }

  static Future<void> showLocalNotification({
    required int id,
    String? title,
    String? body,
    String? data,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'channelId',
      'channelName',
      playSound: true,
      sound: RawResourceAndroidNotificationSound(
          'android_app_src_main_res_raw_notification'),
      importance: Importance.max,
      priority: Priority.high,
    );
    const notificationDetails = NotificationDetails(
      android: androidDetails,
      //todo ios configuration
    );
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.show(id, title, body, notificationDetails,
        payload: data);
  }

  static void onDidReceiveNotificationResponse(NotificationResponse response) {
   appRouter.push('/push-details/${response.payload}');
  }
}
