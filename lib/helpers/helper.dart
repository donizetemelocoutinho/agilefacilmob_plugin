import 'dart:io';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';
import 'package:device_info/device_info.dart';


class Helper{
  static const MethodChannel _channel = const MethodChannel('agilefacil_mob');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }


  static List<String> UFs = ["","AC","AL","AP","AM","BA","CE","DF","ES","GO","MA","MT","MS",
  "MG","PA","PB","PR","PE","PI","RJ","RN","RS", "RO","RR","SC","SP","SE","TO"];

  static List<String> Estados = ["Selecione o seu estado","Acre","Alagoas","Amapá","Amazonas","Bahia","Ceará","Distrito Federal",
  "Espírito Santo","Goiás","Maranhão","Mato Grosso","Mato Grosso do Sul","Minas Gerais","Pará","Paraíba",
  "Paraná","Pernambuco","Piauí","Rio de Janeiro","Rio Grande do Norte","Rio Grande do Sul","Rondônia",
  "Roraima","Santa Catarina","São Paulo","Sergipe","Tocantins"];

  static Map loja;
  static Map usuario;

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

  static String getUFDescricao(int i){
    return Estados[i];
  }

  static String getEstado(int i){
    return Estados[i];
  }

  static int getUFPosition(String uf){
    int pos = -1;
    for (int i = 0; i < 27; i++) {
      if (uf.toUpperCase().compareTo(UFs[i]) == 0){
        pos = i;
        break;
      }
    }
    return pos;
  }


  static DateTime strToDateTime(String date){
    if (!(date.isEmpty || date == null))
      return DateTime.parse(date);
  }

  static String DateTimeToStr(DateTime date){
    return date.toString();
  }




}

