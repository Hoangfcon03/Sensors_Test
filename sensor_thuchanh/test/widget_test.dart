import 'package:flutter_test/flutter_test.dart';
import 'package:sensor_thuchanh/main.dart';

void main() {
  testWidgets('Kiểm tra khởi tạo ứng dụng', (WidgetTester tester) async {
    // Chỉ cần test xem App có load được mà không bị crash không
    await tester.pumpWidget(const SensorApp());
  });
}