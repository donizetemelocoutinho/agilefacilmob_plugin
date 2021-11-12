import 'dart:io';
import 'package:agilefacil_mob/helpers/pdv_model.dart';
import 'package:agilefacil_mob/helpers/usuario_helper.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import 'package:device_info/device_info.dart';

import 'funcionario_helper.dart';
import 'loja_helper.dart';

class Helper{
  static const MethodChannel _channel = const MethodChannel('agilefacil_mob');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Loja loja;
  static Usuario usuario;
  static PDVJason pdv;
  static Funcionario funcionario;
  static String fcm_token;
  static String AppTitle;


  static String newGuid(){
    return Uuid().v1();
  }

  static Future<String> getId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String id = "";
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      id = androidInfo.id;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      id = iosInfo.identifierForVendor;
    }
    return id;
  }

  static Future<String> getNome() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String nome = "";
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      nome = androidInfo.model;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      nome = iosInfo.model;
    }
    return nome;
  }

  static DateTime strToDateTime(String date){
    if (!(date.isEmpty || date == null))
      return DateTime.parse(date);
  }

  static String DateTimeToStr(DateTime date){
    return date.toString();
  }

  static WhatsApp(String number,{String msg}) async {
    var whatsappUrl = "whatsapp://send?phone=+55$number&text=${msg == null ? "": msg}";

    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      throw 'Erro ao tentar abrir o whatsApp';
    }
  }

  static double toDouble(String v){
    v = v.isEmpty ? "0": v;

    if (v.contains(","))
      v = v.replaceAll(".", "");

    v = v.replaceAll(",", ".");
    return double.parse(v);
  }

  static Maps(double lat,double lng) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    String appleUrl = 'https://maps.apple.com/?sll=$lat,$lng';
    if (Platform.isAndroid){
      await launch(googleUrl);
    } else if (Platform.isIOS) {
      await launch(appleUrl);
    }
  }

  static Call(String number){
    launch('tel:+55$number');
  }

}

