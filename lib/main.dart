import 'package:flutter/material.dart';
import 'dart:math';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Background Changer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const ColorChangerPage(title: 'Background Color Changer'),
    );
  }
}

class ColorChangerPage extends StatefulWidget {
  const ColorChangerPage({super.key, required this.title});

  final String title;

  @override
  State<ColorChangerPage> createState() => _ColorChangerPageState();
}

class _ColorChangerPageState extends State<ColorChangerPage> {
  Color _backgroundColor = Colors.yellow[50]!;
  final _resetBtn = Colors.yellow[50]!;
  bool lightMode = true;

  void _changeColor(Color newColor) {
    setState(() {
      _backgroundColor = newColor;
    });
  }

  void _randomColorBtn() {
    final _random = Random();
    final _randomColor = Colors.primaries[_random.nextInt(Colors.primaries.length)];
    setState(() {
      _backgroundColor = _randomColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Background Color Changer'),
        backgroundColor: Colors.green,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        color: _backgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Scegli il bottone e cambia il colore',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
                        onPressed: () => _changeColor(Colors.red),
                        child: const Text('Red'),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                        onPressed: () => _changeColor(Colors.green),
                        child: const Text('Green'),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
                        onPressed: () => _changeColor(Colors.blue),
                        child: const Text('Blue'),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow[50], foregroundColor: Colors.black),
                        onPressed: () => _changeColor(_resetBtn),
                        child: const Text('Reset'),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.purple, foregroundColor: Colors.white) ,
                        onPressed: _randomColorBtn, 
                        child: const Text('Random Color'),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           const Icon(Icons.nightlight_round, color: Colors.blue),
                          Switch(
                            value: lightMode,
                            activeThumbColor: Colors.black,
                            onChanged: (bool value) {
                              setState(() {
                                lightMode = value;
                                _backgroundColor =
                                    lightMode ? Colors.yellow[50]! : Colors.grey[800]!;
                              });
                            },
                          ),                         
                          const Icon(Icons.wb_sunny, color: Colors.orange),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
  
