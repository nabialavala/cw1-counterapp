import 'package:flutter/material.dart';
import 'dart:math'; //Task 1: import math so we can use max functtion in decrement by step

void main() {
  runApp(const CounterImageToggleApp());
}

class CounterImageToggleApp extends StatefulWidget {
  const CounterImageToggleApp({super.key});

  @override
  State<CounterImageToggleApp> createState() =>
    _CounterImageToggleAppState();
}

class _CounterImageToggleAppState extends State<CounterImageToggleApp> {
  bool _isDark = false;

  void _toggleTheme() {
    setState(() => _isDark = !_isDark);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //remove debug banner to see theme button
      title: 'CW1 Counter & Toggle',
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData( //Personal: changing around colors
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.purple.shade50,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
          ),
        ),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
          ),
        ),
      ),

      home: HomePage(
        isDark: _isDark,
        onToggleTheme: _toggleTheme,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final bool isDark;
  final VoidCallback onToggleTheme;
  
  const HomePage({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  int _counter = 0; // initializes counter to 0
  int _step = 1; //Task 1: initialize step to 1
  bool _isFirstImage = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _incrementCounter() {
    setState(() => _counter+=_step);
  }

  void _decrementCounter() { //Task 1: decreasing counter
    setState(() => _counter = max(0, _counter - _step));
  }

  void _resetCounter() { //Task 1: reset counter
    setState(() => _counter = 0);
  }

  void _toggleImage() {
    setState(() => _isFirstImage = !_isFirstImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('CW1 Counter & Toggle - Nabia Lavala'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Counter: $_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 12),
              Row( // Task 1: so that the buttons can be side by side in a 'row'
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center, //Task 1: centering buttons
                children: [
                  ElevatedButton(
                    onPressed: _incrementCounter,
                    child: const Text('Increment'),
                  ),
                  const SizedBox(width: 12), //Task 1: so they aren't touching
                  ElevatedButton(
                    // Task 1: adding decrement button but disable if not being used
                    onPressed: _counter == 0 ? null : _decrementCounter,
                    child: const Text('Decrement'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _counter == 0 ? null : _resetCounter,
                child: const Text('Reset'),
              ),
              Text( //Task 1: adding the step counter feature
                'Step: $_step',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center, 
                children: [
                  ElevatedButton( //Task 1: disable the button if thats the current step
                    onPressed: _step == 1 ? null : () => setState(() => _step = 1),
                    child: const Text('1'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _step == 3 ? null : () => setState(() => _step = 3),
                    child: const Text('3'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _step == 5 ? null : () => setState(() => _step = 5),
                    child: const Text('5'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              AnimatedCrossFade( //Task 2: Crossfade
                duration: const Duration(milliseconds: 500),
                crossFadeState: _isFirstImage
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                firstChild: Image.asset(
                  'assets/dog.png',
                  width: 180,
                  height: 180,
                  fit: BoxFit.cover,
                ),
                secondChild: Image.asset(
                  'assets/cat.png',
                  width: 180,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _toggleImage,
                child: const Text('Toggle Image'),
              ),
              const SizedBox(height: 12),
              ElevatedButton( //Task 2: adding theme button that switches 
                onPressed: widget.onToggleTheme,
                child: Text(
                  widget.isDark ? 'Light Mode' : 'Dark Mode',
                ),
              ),
            ],
          ),
        ),
      );
  }
}