import 'package:flutter/material.dart';
import 'package:app_strings/app_strings.dart';

import 'res/strings/strings.dart';
import 'res/strings/strings_pt.dart';
import 'res/strings/strings_en.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  Iterable<LocalizationsDelegate<dynamic>> get _localizationsDelegates =>
      AppStrings.localizationsDelegates<Strings>({
        LanguageCode.PT: StringsPT(),
        LanguageCode.EN: StringsEN(),
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: _localizationsDelegates,
      supportedLocales: AppStrings.supportedLocales,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.of<Strings>(context).title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              AppStrings.of(context).clickedTimes(_counter),
            ),
            StringsRichText(
              text: AppStrings.of(context).clickedTimes(_counter),
              spanColor: Colors.amber,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
