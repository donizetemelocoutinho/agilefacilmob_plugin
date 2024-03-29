import 'dart:io';
import 'package:agilefacil_mob/helpers/pdv_model.dart';
import 'package:agilefacil_mob/helpers/usuario_helper.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'funcionario_helper.dart';
import 'loja_helper.dart';



class Helper{
  static const MethodChannel _channel = const MethodChannel('agilefacil_mob');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static late Loja loja;
  static late Usuario usuario;
  static late PDVJason? pdv;
  static late Funcionario funcionario;
  static late String fcm_token;
  static late String AppTitle;


  static String newGuid(){
    return Uuid().v1();
  }

  static Future<String> getId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String id = "";
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      id = androidInfo.id ?? "";
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      id = iosInfo.identifierForVendor ?? "";
    }
    return id;
  }

  static Future<String?> getNome() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String nome = "";
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      nome = androidInfo.model ?? "";
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      nome = iosInfo.model ?? "";
    }
    return nome;
  }

  static DateTime? strToDateTime(String date){
    if (!(date.isEmpty || date == null))
      return DateTime.tryParse(date);
  }

  static String DateTimeToStr(DateTime date){
    return date.toString();
  }

  static WhatsApp(String number,{String ?msg}) async {
    var whatsappUrl = "whatsapp://send?phone=+55$number&text=${msg == null ? "": msg}";

    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      throw 'Erro ao tentar abrir o whatsApp';
    }
  }

  static launchWhatsApp(String number,{String? msg}) async {
    final link = WhatsAppUnilink(
      phoneNumber: '+55$number',
      text: "${msg == null ? "" : msg}",
    );
    await launch('$link');
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
    }
    else if (Platform.isIOS) {
      await launch(appleUrl);
    }
  }

  static navigateTo(double lat, double lng) async {
    var uri = Uri.parse("google.navigation:q=$lat,$lng&mode=d");
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      throw 'Não foi possível iniciar ${uri.toString()}';
    }
  }

  static Call(String number){
    launch('tel:+55$number');
  }
}

