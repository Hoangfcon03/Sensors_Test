import 'dart:async';
import 'package:flutter/material.dart';
import 'package:light_sensor/light_sensor.dart';
import 'package:flutter/foundation.dart'; // Bắt buộc phải có để dùng kIsWeb

void main() {
  runApp(const MaterialApp(
    home: LightMeter(),
    debugShowCheckedModeBanner: false,
  ));
}

class LightMeter extends StatefulWidget {
  const LightMeter({super.key});

  @override
  State<LightMeter> createState() => _LightMeterState();
}

class _LightMeterState extends State<LightMeter> {
  int _luxValue = 0;
  StreamSubscription? _subscription;

  // Tối ưu hóa: Dùng final vì giá trị này không đổi sau khi khởi tạo
  final bool _isWeb = kIsWeb;

  @override
  void initState() {
    super.initState();
    // Nếu là Mobile thì mới khởi động cảm biến thật
    if (!_isWeb) {
      _startListening();
    }
  }

  void _startListening() async {
    try {
      // Kiểm tra sự tồn tại của cảm biến trên phần cứng Android
      final hasSensor = await LightSensor.hasSensor();
      if (hasSensor) {
        _subscription = LightSensor.luxStream().listen((lux) {
          setState(() => _luxValue = lux);
        });
      }
    } catch (e) {
      debugPrint("Lỗi cảm biến: $e");
    }
  }

  @override
  void dispose() {
    _subscription?.cancel(); // Hủy lắng nghe để tránh rò rỉ bộ nhớ
    super.dispose();
  }

  String getLightStatus(int lux) {
    if (lux < 10) return "TỐI OM (Phòng kín)";
    if (lux < 500) return "SÁNG VỪA (Trong nhà)";
    return "RẤT SÁNG (Ngoài trời)";
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = _luxValue < 50;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : Colors.white,
      appBar: AppBar(
        title: const Text("Light Meter - Bài Thực Hành 3"),
        backgroundColor: isDark ? Colors.grey[900] : Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isDark ? Icons.nightlight_round : Icons.wb_sunny,
              size: 120,
              color: isDark ? Colors.amber[100] : Colors.orange,
            ),
            const SizedBox(height: 30),
            Text(
              "$_luxValue LUX",
              style: TextStyle(
                fontSize: 70,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            Text(
              getLightStatus(_luxValue),
              style: TextStyle(
                fontSize: 20,
                color: isDark ? Colors.white70 : Colors.black54,
              ),
            ),
            const SizedBox(height: 50),

            // UI Giả lập cho Web
            if (_isWeb) _buildWebSimulator(isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildWebSimulator(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          Text(
            "Giả lập cường độ sáng (Web Mode):",
            style: TextStyle(color: isDark ? Colors.white : Colors.black),
          ),
          Slider(
            value: _luxValue.toDouble(),
            min: 0,
            max: 1000,
            divisions: 100,
            label: "$_luxValue Lux",
            onChanged: (double value) {
              setState(() => _luxValue = value.toInt());
            },
          ),
          Text(
            "Kéo thanh trượt để chụp ảnh báo cáo",
            style: TextStyle(fontSize: 12, color: isDark ? Colors.grey : Colors.blueGrey),
          ),
        ],
      ),
    );
  }
}