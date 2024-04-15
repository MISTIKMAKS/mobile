import 'package:flutter/material.dart';
import 'dart:async';

class Lab3 extends StatefulWidget {
  const Lab3({super.key});

  @override
  State<Lab3> createState() => _Lab3State();
}

class _Lab3State extends State<Lab3> {
  late Timer _pedestrianTimer;
  late Timer _redLightTimer;
  int _pedestrianTimeLeft = 30;
  int _redLightTimeLeft = 60;
  bool _showRedLight = false;

  @override
  void initState() {
    super.initState();
    _startPedestrianTimer();
  }

  void _startPedestrianTimer() {
    _pedestrianTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_pedestrianTimeLeft > 0) {
          _pedestrianTimeLeft--;
        } else {
          _redLightTimeLeft = 60;
          _showRedLight = true;
          _pedestrianTimer.cancel();
          _startRedLightTimer();
        }
      });
    });
  }

  void _startRedLightTimer() {
    _redLightTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_redLightTimeLeft > 0) {
          _redLightTimeLeft--;
        } else {
          _pedestrianTimeLeft = 30;
          _showRedLight = false;
          _redLightTimer.cancel();
          _startPedestrianTimer();
        }
      });
    });
  }

  @override
  void dispose() {
    _pedestrianTimer.cancel();
    _redLightTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Lab 3'),
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(10.0),
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: _showRedLight
                      ? Colors.red
                      : const Color.fromARGB(255, 60, 2, 0),
                  shape: BoxShape.circle,
                ),
                // child: Center(
                //   child: Text(
                //     _showRedLight ? '$_redLightTimeLeft' : '$_redLightTimeLeft',
                //     style: const TextStyle(
                //       fontSize: 24,
                //       color: Colors.white,
                //     ),
                //   ),
                // ),
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: _showRedLight
                      ? const Color.fromARGB(255, 0, 60, 2)
                      : Colors.green,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    _showRedLight ? '' : '$_pedestrianTimeLeft',
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
