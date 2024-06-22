import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:mqtt_client/mqtt_client.dart' as mqtt;
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttProvider with ChangeNotifier {
  final String broker = '192.168.1.9';
  final int port = 1883;
  final String username = 'reem10';
  final String passwd = '1234567Me';
  final String clientIdentifier = 'android';
  late MqttServerClient client;
  late mqtt.MqttConnectionState connectionState;
  late StreamSubscription subscription;

  SensorData? sensorData;
  String? latestFlameMessage;
  String? latestRainMessage;

  MqttProvider() {
    connect();
  }

  void connect() async {
    client = MqttServerClient(broker, clientIdentifier)
      ..port = port
      ..logging(on: true)
      ..onDisconnected = _onDisconnected
      ..connectionMessage = mqtt.MqttConnectMessage()
          .withClientIdentifier(clientIdentifier)
          .startClean()
          .withWillQos(mqtt.MqttQos.atMostOnce);

    try {
      await client.connect(username, passwd);
    } catch (e) {
      print(e);
      disconnect();
    }

    if (client.connectionStatus!.state == mqtt.MqttConnectionState.connected) {
      print('MQTT client connected');
      connectionState = client.connectionStatus!.state;
      subscription = client.updates!.listen(onMessage);
      subscribeToTopic("home/temperature");
      subscribeToTopic("home/flame");
      subscribeToTopic("home/rain");
      subscribeToTopic("home/control");
      subscribeToTopic("home/ldr");
      print('el denya tamam');
    } else {
      print('ERROR MQTT client connection failed - disconnecting');
      disconnect();
    }
  }

  void disconnect() {
    client.disconnect();
    print('Disconnected');
  }

  void _onDisconnected() {
    print('Disconnected');
  }

  void onMessage(List<mqtt.MqttReceivedMessage<mqtt.MqttMessage>> event) {
    final mqtt.MqttPublishMessage recMess = event[0].payload as mqtt.MqttPublishMessage;
    final String message = mqtt.MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
    final String topic = event[0].topic;

    print('Received message: $message from topic: $topic');

    if (topic == 'home/temperature') {
      final Map<String, dynamic> jsonData = json.decode(message);
      sensorData = SensorData.fromJson(jsonData);
      notifyListeners();
    } else if (topic == 'home/flame') {
      latestFlameMessage = message;
      notifyListeners();
    } else if (topic == 'home/rain') {
      latestRainMessage = message;
      notifyListeners();
    } else if (topic == 'home/control') {
      // Handle control topic
    } else if (topic == 'home/ldr') {
      // Handle LDR topic
    } else if (topic == 'home/motion') {
      // Handle motion topic
    }
  }

  void subscribeToTopic(String topic) {
    if (connectionState == mqtt.MqttConnectionState.connected) {
      client.subscribe(topic, mqtt.MqttQos.exactlyOnce);
      print('Subscribing to $topic');
    }
  }

  void publishMessage(String topic, String message) {
    if (client.connectionStatus?.state == mqtt.MqttConnectionState.connected) {
      final builder = mqtt.MqttClientPayloadBuilder();
      builder.addString(message);
      client.publishMessage(topic, mqtt.MqttQos.exactlyOnce, builder.payload!);
      print('Publishing message "$message" to topic $topic');
    }
  }

  void clearLatestFlameMessage() {
    latestFlameMessage = null;
  }

  void clearLatestRainMessage() {
    latestRainMessage = null;
  }
}

class SensorData {
  final double temperature;
  final double humidity;
  final int timestamp;

  SensorData({required this.temperature, required this.humidity, required this.timestamp});

  factory SensorData.fromJson(Map<String, dynamic> json) {
    return SensorData(
      temperature: json['temperature'],
      humidity: json['humidity'],
      timestamp: json['timestamp'],
    );
  }
}
