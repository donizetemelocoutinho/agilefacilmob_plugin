import 'package:agilefacil_mob/helpers/tipos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class EnderecoHelper{
  static const MethodChannel _channel = const MethodChannel('agilefacil_mob');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  Endereco endereco;

  final _cepController = TextEditingController();
  final _ufController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _logradouroController = TextEditingController();
  final _numeroController = TextEditingController();
  final _bairroController = TextEditingController();
  final _referenciaController = TextEditingController();

  EnderecoHelper(Endereco endereco){
    this.endereco = endereco;
    _cepController.text = endereco.cep;
    _ufController.text = endereco.uf;
    _cidadeController.text = endereco.cidade;
    _bairroController.text = endereco.bairro;
    _logradouroController.text = endereco.logradouro;
    _numeroController.text = endereco.numero;
    _referenciaController.text = endereco.referencia;
  }

  Widget getEndereco(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "Cep"),
                      controller: _cepController,
                      validator: (value) {
                        //validar
                      },
                      onChanged: (value){endereco.cep = value;},
                    )),
                IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                    })
              ],
            ),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Estado"),
            controller: _ufController,
            validator: (value) {
              if (value.isEmpty ?? value == null) {
                return "Preencha o Estado";
              }
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Cidade"),
            controller: _cidadeController,
            validator: (value) {
              if (value.isEmpty ?? value == null) {
                return "Preencha a Cidade";
              }
            },
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "Logradouro"),
                      controller: _logradouroController,
                      validator: (value) {
                        //validar
                      },
                    )),
                IconButton(
                    icon: Icon(Icons.location_on_outlined),
                    onPressed: () {
                    })
              ],
            ),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Nº"),
            controller: _numeroController,
            validator: (value) {
              if (value.isEmpty ?? value == null) {
                return "Informe o numero";
              }
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Bairro"),
            controller: _bairroController,
            validator: (value) {
              //validar
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Referencia"),
            controller: _referenciaController,
            validator: (value) {
            },
          )
        ],
      ),
    );
  }

}