import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agilefacil_mob/agilefacil_mob.dart';

void main() {
  const MethodChannel channel = MethodChannel('agilefacil_mob');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await AgilefacilMob.platformVersion, '42');
  });
}
