import 'package:agilefacil_mob/helpers/tipos.dart';
import 'package:agilefacil_mob/ui/cidade_screen.dart';
import 'package:agilefacil_mob/ui/estado_screen.dart';
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
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "Estado"),
                      controller: _ufController,
                      enabled: false
                    )),
                IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () async{
                      Estado estado = await Navigator.push(context, MaterialPageRoute(builder: (context) => EstadoScreen()));
                      if (estado.uf != _ufController.text) {
                        _ufController.text = estado.descricao;
                        _cidadeController.text = "";
                        endereco.uf = estado.uf;
                        endereco.cidade = null;
                        endereco.codcidade = null;
                        endereco.codcidadeibge = null;
                      }

                    })
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "Cidade"),
                      controller: _cidadeController,
                      enabled: false,
                    )),
                IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () async{
                      Cidade cidade = await Navigator.push(context, MaterialPageRoute(builder: (context) => CidadeScreen(endereco.uf)));
                      _cidadeController.text = cidade.descricao;
                      _ufController.text = cidade.uf;

                      endereco.uf = cidade.uf;
                      endereco.cidade = cidade.descricao;
                      endereco.codcidade = cidade.codcidade;
                      endereco.codcidadeibge = cidade.codcidadeibge;

                    })
              ],
            ),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Bairro"),
            controller: _bairroController,
            validator: (value) {
              //validar
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