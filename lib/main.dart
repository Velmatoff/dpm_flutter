import 'package:dpm_flutter/src/dpm_controller.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool? isProfileOwnerApp;
  final DpmController _controller = DpmController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: StreamBuilder<bool>(
          stream: _controller.poStream,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data == true) {
              return Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await _controller.enableWorkProfile();
                    },
                    child: const Text('Активировать'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await _controller.setSysApp('com.android.chrome');
                    },
                    child: const Text('Установить Chrome'),
                  ),
                  const Text('Скриншоты запрещены'),
                  StreamBuilder<bool>(
                    stream: _controller.screenCaptureDisabledStream,
                    builder: (context, snapshot) {
                     if (snapshot.hasData && snapshot.data != null) {
                       return Checkbox(value: snapshot.data, onChanged: (b){
                         _controller.screenCaptureDisabled(b!);
                       });
                     } else {
                       return const SizedBox();
                     }
                    },
                  )
                ],
              );
            } else {
              return Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await _controller.createWorkProfile();
                    },
                    child: const Text('Установить рабочий профиль'),
                  ),
                ],
              );
            }
          }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _controller.createWorkProfile();
          final v = await _controller.isProfileOwnerApp();
          print(v);
          setState(() {
            isProfileOwnerApp = v;
          });
        },
        child: const Icon(Icons.question_answer),
      ),
    );
  }
}
