import AuthenticationServices
import Flutter
import UIKit

public class SwiftSignInWithApplePlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(
            name: methodChannelName,
            binaryMessenger: registrar.messenger()
        )

        if #available(iOS 13.0, *) {
            let instance = SignInWithAppleAvailablePlugin()
            registrar.addMethodCallDelegate(instance, channel: channel)
        } else {
            let instance = SignInWithAppleUnavailablePlugin()
            registrar.addMethodCallDelegate(instance, channel: channel)
        }
    }
}
