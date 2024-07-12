import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_disk_utils/flutter_disk_utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _flutterDiskUtilsPlugin = FlutterDiskUtilsMethodChannel();

  Timer? refreshTimer;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await _flutterDiskUtilsPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;
    setState(() {
      _platformVersion = platformVersion;
    });
  }

  void toggleAutoRefresh() {
    if (refreshTimer != null) {
      refreshTimer?.cancel();
      refreshTimer = null;
    } else {
      refreshTimer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
        setState(() {});
      });
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: toggleAutoRefresh,
          backgroundColor: refreshTimer == null ? Colors.white60 : Colors.black54,
          child: Icon(Icons.refresh, color: refreshTimer == null ? Colors.blueAccent : Colors.grey),
        ),
        appBar: AppBar(
          title: const Text('Disk Storage & Memory App'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('Running on: $_platformVersion\n'),

              /// Storage
              FutureBuilder(
                future: _flutterDiskUtilsPlugin.getStorageSize(),
                builder: (BuildContext context, AsyncSnapshot<int?> snapshot) {
                  int? total = snapshot.data;
                  return Text('Storage total: ${total == null ? '' : total / 1024 / 1024 / 1024}GB');
                },
              ),

              FutureBuilder(
                future: _flutterDiskUtilsPlugin.getStorageAvailableSize(),
                builder: (BuildContext context, AsyncSnapshot<int?> snapshot) {
                  int? total = snapshot.data;
                  return Text('Storage available: ${total == null ? '' : total / 1024 / 1024 / 1024}GB');
                },
              ),

              const SizedBox(height: 24),

              /// Memory
              FutureBuilder(
                future: _flutterDiskUtilsPlugin.getMemorySize(),
                builder: (BuildContext context, AsyncSnapshot<int?> snapshot) {
                  int? total = snapshot.data;
                  return Text('Memory total: ${total == null ? '' : total / 1024 / 1024 / 1024}GB');
                },
              ),

              FutureBuilder(
                future: _flutterDiskUtilsPlugin.getMemoryAvailableSize(),
                builder: (BuildContext context, AsyncSnapshot<int?> snapshot) {
                  int? total = snapshot.data;
                  return Text('Memory available: ${total == null ? '' : total / 1024 / 1024 / 1024}GB');
                },
              ),

              FutureBuilder(
                future: _flutterDiskUtilsPlugin.getAppMemory(),
                builder: (BuildContext context, AsyncSnapshot<int?> snapshot) {
                  int? total = snapshot.data;
                  return Text('Memory App: ${total == null ? '' : total / 1024 / 1024}MB');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
