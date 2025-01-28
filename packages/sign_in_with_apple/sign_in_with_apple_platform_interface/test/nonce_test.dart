// 📦 Package imports:
import 'package:flutter_test/flutter_test.dart';

// 🌎 Project imports:
import 'package:sign_in_with_apple_platform_interface/sign_in_with_apple_platform_interface.dart';

void main() {
  test('Generates a nonce with the provided length', () {
    expect(generateNonce(length: 40), hasLength(40));
  });

  test('Generates a nonce with the default length', () {
    expect(generateNonce(), hasLength(32));
  });
}
