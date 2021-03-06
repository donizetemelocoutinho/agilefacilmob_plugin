import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'db_helper.dart';

final String table = "COUNTS";
final String idColumn = "ID";
final String cpfcnpjColumn = "CPF_CNPJ";
final String codlojaColumn = "COD_LOJA";
final String loginColumn = "LOGIN";
final String codusuarioColumn = "COD_USUARIO";
final String loginfotolinkColumn = "LINK_FOTO";
final String senhaColumn = "SENHA";
final String apitokenColumn = "API_TOKEN";
final String empresalogolinkColumn = "LINK_LOGO";
final String jusuarioColumn = "J_USUARIO";
final String jlojaColumn = "J_LOJA";
final String celularColumn = "CELULAR";
final String descricaoColumn = "DESCRICAO";

class DBCountsHelper{

  Database _db;

  String toScript(){
    return "CREATE TABLE $table("
        "$idColumn INTEGER PRIMARY KEY, "
        "$cpfcnpjColumn TEXT,"
        "$codlojaColumn INTEGER,"
        "$loginColumn TEXT,"
        "$senhaColumn TEXT,"
        "$codusuarioColumn INTEGER,"
        "$loginfotolinkColumn TEXT,"
        "$apitokenColumn TEXT,"
        "$empresalogolinkColumn TEXT,"
        "$jusuarioColumn TEXT,"
        "$celularColumn TEXT,"
        "$descricaoColumn TEXT,"
        "$jlojaColumn TEXT)";
  }

  Future<DBCount> save(DBCount count) async {
    Database d = await DBHelper().db;

    //verifico se este usuário esta liberado para esta loja
    if (count.id == null)
      count.id = await Exists(count.codloja,count.codusuario);

    //Verifico se retornou o id caso não tenha retornado insiro
    if (count.id == null)
      count.id = await d.insert(table, count.toMap());
    else
      await update(count);

    //print(count.toString());

    return count;
  }

  Future<DBCount> get(int id) async {
    Database d = await DBHelper().db;
    List<Map> maps = await d.query(table,
        columns: [idColumn, cpfcnpjColumn, cpfcnpjColumn, cpfcnpjColumn, codlojaColumn,
          loginColumn,senhaColumn,codusuarioColumn,loginfotolinkColumn,apitokenColumn,empresalogolinkColumn,
          jusuarioColumn,jlojaColumn,celularColumn,descricaoColumn],
        where: "$idColumn = ?",
        whereArgs: [id]);
    if (maps.length > 0)
      return DBCount.fromMap(maps.first);
    else
      return null;
  }

  Future<int> delete(int id) async {
    Database d = await DBHelper().db;
    return await d.delete(table, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int> update(DBCount count) async {
    Database d = await DBHelper().db;
    return await d.update(table, count.toMap(), where: "$idColumn = ?", whereArgs: [count.id]);
  }

  Future<int> count() async{
    Database d = await DBHelper().db;
    return Sqflite.firstIntValue(await d.rawQuery("SELECT COUNT(*) FROM $table"));
  }

  Future<List> getAll() async {
    Database d = await DBHelper().db;
    List listMap = await d.rawQuery("SELECT * FROM $table");
    List<DBCount> list = [];

    //print("Count: ${listMap.length}");

    for (Map m in listMap){
      DBCount count = DBCount.fromMap(m);
      list.add(count);
    }
    return list;
  }


  Future<int> Exists(codloja,codusuario) async {
    Database d = await DBHelper().db;
    List<Map> maps = await d.query(table,
        columns: [idColumn],
        where: "$codlojaColumn = ? AND $codusuarioColumn = ?",
        whereArgs: [codloja,codusuario]);
    if (maps.length > 0)
      return maps.first[idColumn];
    else
      return null;
  }

}

class DBCount{
  int id;
  String cpfcnpj;
  int codloja;
  String login;
  int codusuario;
  String loginfotolink;
  String senha;
  String apitoken;
  String empresalogolink;
  String celular;
  String descricao;
  Map usuario;
  Map loja;

  DBCount.fromMap(Map map){
    id = map[idColumn];
    cpfcnpj = map[cpfcnpjColumn];
    codloja = map[codlojaColumn];
    login = map[loginColumn];
    senha = map[senhaColumn];
    apitoken = map[apitokenColumn];
    empresalogolink = map[empresalogolinkColumn];
    loginfotolink = map[loginfotolinkColumn];
    usuario = convert.jsonDecode(map[jusuarioColumn]);
    loja = convert.jsonDecode(map[jlojaColumn]);
    celular = map[celularColumn];
    descricao = map[descricaoColumn];
  }

  Map toMap(){
    Map<String, dynamic> map = {
      cpfcnpjColumn: cpfcnpj,
      codlojaColumn: codloja,
      loginColumn: login,
      codusuarioColumn: codusuario,
      loginfotolinkColumn : loginfotolink,
      senhaColumn: senha,
      apitokenColumn: apitoken,
      empresalogolinkColumn: empresalogolink,
      celularColumn : celular,
      descricaoColumn : descricao,
      jusuarioColumn: convert.jsonEncode(usuario),
      jlojaColumn: convert.jsonEncode(loja)

    };

    if (id != null) {
      map[idColumn] = id;
    }
    return map;
  }

  DBCount();
  /*
  @override
  String toString() {
    return toMap().toString();
  }
  */
}
