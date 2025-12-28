import 'package:flutter/material.dart';
import 'explorer_tool.dart'; // Import file ExplorerTool

void main() {
  // Đảm bảo các dịch vụ native được sẵn sàng
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GPS & Compass',
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      // Chạy màn hình ExplorerTool
      home: const ExplorerTool(),
    );
  }
}