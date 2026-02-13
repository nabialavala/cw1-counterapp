import 'package:flutter/material.dart';
import 'dart:math'; //Task 1: import math so we can use max functtion in decrement by step

void main() {
  runApp(const CounterImageToggleApp());
}

class CounterImageToggleApp extends StatelessWidget {
  const CounterImageToggleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CW1 Counter & Toggle',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  int _counter = 0; // initializes counter to 0
  int _step = 1; //Task 1: initialize step to 1
  bool _isDark = false;
  bool _isFirstImage = true;

  late final AnimationController _controller;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
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

  void _toggleTheme() {
    setState(() => _isDark = !_isDark);
  }

  void _toggleImage() {
    if (_isFirstImage) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    setState(() => _isFirstImage = !_isFirstImage);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('CW1 Counter & Toggle'),
          actions: [
            IconButton(
              onPressed: _toggleTheme,
              icon: Icon(_isDark ? Icons.light_mode : Icons.dark_mode),
            ),
          ],
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
              Text( //adding the step counter feature
                'Step: $_step',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center, 
                children: [
                  ElevatedButton( //disable the button if thats the current step
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
              FadeTransition(
                opacity: _fade,
                child: Image.asset(
                  _isFirstImage ? 'assets/image1.png' : 'assets/image2.png',
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
            ],
          ),
        ),
      ),
    );
  }
}