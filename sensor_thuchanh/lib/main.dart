import 'package:flutter/material.dart';
import 'motion_tracker.dart'; // Đảm bảo bạn đã có file này trong thư mục lib

void main() {
  // Đảm bảo các dịch vụ hệ thống được khởi tạo trước khi dùng cảm biến
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SensorApp());
}

class SensorApp extends StatelessWidget {
  const SensorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sensor Hub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: const MotionTracker(), // Gọi màn hình đo cảm biến
    );
  }
}