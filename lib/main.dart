import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shipanther/screens/notifications/notification_test.dart';
import 'package:shipanther/screens/notifications/task_list.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(Notification());
}

class Notification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Shipanther',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: Scaffold(
          body: Home(),
        ));
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var taskNum = 4;
  FlutterLocalNotificationsPlugin notification =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    var andriodInit = new AndroidInitializationSettings('shipanther_icon');
    var iOSinit = new IOSInitializationSettings();
    var initSetting =
        new InitializationSettings(android: andriodInit, iOS: iOSinit);
    var flutterNotification = new FlutterLocalNotificationsPlugin();
    flutterNotification.initialize(
      initSetting,
      onSelectNotification: selectNotification,
    );
  }

  Future _showNotification() async {
    try {
      taskNum++;
      var androidDetail = new AndroidNotificationDetails(
          '4', 'Task4', 'Pick from A drop to B at 9 AM',
          importance: Importance.max);
      var iOSDetails = new IOSNotificationDetails();
      var generalNotificationDetails =
          new NotificationDetails(android: androidDetail, iOS: iOSDetails);
      await notification.show(taskNum, 'Task$taskNum',
          'Pick from A drop to B at 9 AM', generalNotificationDetails,
          payload: 'Task$taskNum');
    } catch (e) {
      print('eroorrrrr');
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
                child: Text('TASKS'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(builder: (_) => Tasks()),
                  );
                }),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              child: Text('Add Task and Notify'),
              onPressed: _showNotification,
            )
          ],
        ),
      ),
    );
  }

  Future selectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    // Task().addTask(payload);
    await Navigator.push(
      context,
      MaterialPageRoute<void>(
          builder: (context) => NotificationTestScreen(payload)),
    );
  }
}
