import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_as_default/open_as_default.dart';

void main() {
  const MethodChannel channel = MethodChannel('open_as_default');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getFileIntent', () async {
    expect(await OpenAsDefault.getFileIntent, '42');
  });
}
