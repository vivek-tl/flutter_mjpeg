import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_mjpeg/controller/flutter_mjpeg_controller.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends HookWidget {
  final flutterMjpegController = FlutterMjpegController();

  @override
  Widget build(BuildContext context) {
    final isRunning = useState(true);

    useEffect(
      () {
        print(flutterMjpegController.getFrame);
        return null;
      },
      [],
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Demo Home Page'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Mjpeg(
                isLive: isRunning.value,
                flutterMjpegController: flutterMjpegController,
                error: (context, error, stack) {
                  print(error);
                  print(stack);
                  return Text(error.toString(),
                      style: TextStyle(color: Colors.red));
                },
                stream:
                    'http://192.168.10.20:8080/?action=stream', //'http://192.168.1.37:8081',
              ),
            ),
          ),
          Row(
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  isRunning.value = !isRunning.value;
                },
                child: Text('Toggle'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Scaffold(
                            appBar: AppBar(),
                          )));
                },
                child: Text('Push new route'),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          print(flutterMjpegController.getFrame);
        },
      ),
    );
  }
}
