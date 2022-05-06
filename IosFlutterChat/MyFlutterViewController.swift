//
//  MyFlutterViewController.swift
//  IosFlutterChat
//
//  Created by Abel Rodriguez Medel on 7/2/22.
//

import Flutter
import FlutterPluginRegistrant
import Foundation

enum ChannelName {
    static let event = "com.example.flutter/event"
    static let method = "com.example.flutter/method"
}

enum ChannelMethodName {
    static let sendMessage = "sendMessage"
}

class MyFlutterViewController: FlutterViewController, FlutterStreamHandler {
    let flutterEngines = FlutterEngineGroup(name: "flutter_engines", project: nil)
    var eventChannelSink : FlutterEventSink?

    init() {
        let newEngine = flutterEngines.makeEngine(withEntrypoint: nil, libraryURI: nil)
        super.init(engine: newEngine, nibName: nil, bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupPlatformChannels(textView: UITextView) {
        let eventChannel = FlutterEventChannel(
            name: ChannelName.event,
            binaryMessenger: self.engine!.binaryMessenger
        )
        eventChannel.setStreamHandler(self)
        
        let methodChannel = FlutterMethodChannel(
            name: ChannelName.method,
            binaryMessenger: self.engine!.binaryMessenger
        )
        
        methodChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            if call.method == ChannelMethodName.sendMessage {
                let arg = call.arguments as? String
                if arg != nil {
                    textView.text = arg
                }
            } else {
                result(FlutterMethodNotImplemented)
                return
            }
        })
    }
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventChannelSink = events
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        return nil
    }
}
