// ignore_for_file: deprecated_member_use

// 📦 Package imports:
import 'package:flutter_test/flutter_test.dart';

// 🌎 Project imports:
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  tearDown(() {
    SignInWithApple.channel.setMockMethodCallHandler(null);
  });

  test('performAuthorizationRequest -> Apple ID', () async {
    SignInWithApple.channel.setMockMethodCallHandler((methodCall) async {
      if (methodCall.method == 'performAuthorizationRequest') {
        return {
          'type': 'appleid',
          'userIdentifier': 'some userIdentifier',
          'givenName': 'some givenName',
          'familyName': 'some familyName',
          'email': 'some@email.com',
          'identityToken': 'identityToken',
          'authorizationCode': 'authorizationCode',
        };
      }

      throw Exception('Unexpected method');
    });

    expect(
      await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.name,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: 'com.example',
          redirectUri: Uri.parse('https://example.com'),
        ),
      ),
      isA<AuthorizationCredentialAppleID>(),
    );
  });

  test('performAuthorizationRequest -> Username/Password', () async {
    SignInWithApple.channel.setMockMethodCallHandler((methodCall) async {
      if (methodCall.method == 'performAuthorizationRequest') {
        return {
          'type': 'password',
          'username': 'user1',
          'password': 'admin',
        };
      }

      throw Exception('Unexpected method');
    });

    expect(
      await SignInWithApple.getKeychainCredential(),
      isA<AuthorizationCredentialPassword>(),
    );
  });
}
