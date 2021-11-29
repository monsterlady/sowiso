import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sowiso/src/widgets/shake.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _result = -1;
  int a = 0, b = 0;
  Key shakeKey = UniqueKey();
  var borderColor = Colors.blue;
  final TextEditingController _textController = TextEditingController();


  void _changeColor(val){
    setState(() {
      borderColor= val;
    });
  }

  void _incrementCounter() {
    setState(() {
      a = _getRandomNumber();
      b = _getRandomNumber();
      _textController.clear();
      _counter++;
      borderColor = Colors.blue;
    });
  }

  void _shake(){
    setState(() {
      shakeKey = UniqueKey();
    });
  }

  int _getRandomNumber(){
    Random random = new Random();
    return random.nextInt(10);
  }

  var numberStyle = const TextStyle(
      fontSize: 25,
      fontStyle: FontStyle.italic
  );

  @override
  void initState() {
    super.initState();
    initNumbers();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Flexible(child: Text(
              'You have done $_counter exercises',
              style: Theme.of(context).textTheme.headline4,
            ),),
            Flexible(child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  child:
                  Text(
                      a.toString(),
                    style: numberStyle
                  ),
                ),
                Flexible(child: Text(
                    '+',
                  style: numberStyle,
                ),),
                Flexible(
                  child: Text(
                  b.toString(),
                style: numberStyle
                  ),),
               Flexible(
                 child:  Text(
                   "=",
                   style: numberStyle,
                 ),
               ),
                Flexible(
                    child: ShakeWidget(
                      key: shakeKey,
                      child: TextField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: borderColor, width: 5.0),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.blue, width: 3.0),
                          ),
                          hintText: "Answer",
                        ),
                        style: numberStyle,
                        controller: _textController,
                        keyboardType: TextInputType.number,
                        onChanged: (val){
                          setState(() {
                            _result = int.parse(val);
                          });
                        },
                      ),

                    ))
              ],
            )),
            Flexible(
                child: TextButton(
              onPressed: () async {
                if (_result == (a + b)){
                  _changeColor(Colors.green);
                  await Future.delayed(const Duration(seconds: 1), (){
                    _incrementCounter();
                  });
                } else{
                  _changeColor(Colors.red);
                  _shake();
                  await Future.delayed(const Duration(seconds: 1), (){
                    _changeColor(Colors.blue);
                  });
                }
              }, child: Text(
                'Confirm',
              style: numberStyle,
            ),

            ))
            // Text(
            //   '$_counter',
            //   style: Theme.of(context).textTheme.headline4,
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void initNumbers() {
    setState(() {
      a = _getRandomNumber();
      b = _getRandomNumber();
    });
  }
}

