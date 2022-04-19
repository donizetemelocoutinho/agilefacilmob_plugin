import 'package:agilefacil_mob/helpers/api_helper.dart';
import 'package:agilefacil_mob/helpers/helper.dart';
import 'package:agilefacil_mob/helpers/tipos.dart';
import 'package:agilefacil_mob/ui/cidade_screen.dart';
import 'package:agilefacil_mob/ui/estado_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';

class EnderecoHelper{
  static const MethodChannel _channel = const MethodChannel('agilefacil_mob');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  Endereco endereco = new Endereco();

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
                      keyboardType: TextInputType.numberWithOptions(decimal: false),
                      onChanged: (value){endereco.cep = value;},
                    )),
                IconButton(
                    icon: Icon(Icons.search,color: Theme.of(context).primaryColor),
                    onPressed: () async{
                      ApiHelper api = ApiHelper();
                      Map map = await api.get("common/getenderecocep",params: {"cep": _cepController.text});
                      if (map["id"] == 0){
                        endereco.cep = map["cep"];
                        endereco.logradouro = map["logradouro"];
                        endereco.referencia = map["complemento"];
                        endereco.bairro = map["bairro"];
                        endereco.cidade = map["localidade"];
                        endereco.codcidade;
                        endereco.uf = map["uf"];
                        endereco.codcidadeibge = int.parse(map["ibge"]);

                        _logradouroController.text = endereco.logradouro;
                        _referenciaController.text = endereco.referencia;
                        _bairroController.text = endereco.bairro;
                        _cidadeController.text = endereco.cidade;
                        _ufController.text = endereco.uf;
                        _numeroController.text = endereco.numero;
                      } else{
                        SnackBar snackBar = SnackBar(content: Text(map["msg"],style: TextStyle(fontSize: 15.0)),backgroundColor: Colors.red,duration: Duration(seconds: 5));
                        Scaffold.of(context).showSnackBar(snackBar);
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
                      decoration: InputDecoration(labelText: "Estado"),
                      controller: _ufController,
                      enabled: false
                    )),
                IconButton(
                    icon: Icon(Icons.search,color: Theme.of(context).primaryColor),
                    onPressed: () async{
                      Estado estado = await Navigator.push(context, MaterialPageRoute(builder: (context) => EstadoScreen()));
                      if (estado.uf != _ufController.text) {
                        _ufController.text = estado.descricao;
                        _cidadeController.text = "";
                        endereco.uf = estado.uf;
                        endereco.cidade;
                        endereco.codcidade;
                        endereco.codcidadeibge;
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
                    icon: Icon(Icons.search,color: Theme.of(context).primaryColor),
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
                    ))
              ],
            ),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Nº"),
            controller: _numeroController,
            validator: (value) {
              if (value!.isEmpty && value == 0) {
                return "Informe o numero";
              }
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Referencia"),
            controller: _referenciaController,
            validator: (value) {
            },
          ),
          Padding(padding: EdgeInsets.all(12.0),
            child: TextButton(
              child: Icon(Icons.location_on_outlined,color: Theme.of(context).primaryColor),
              onPressed: () async {
                // ApiHelper api = ApiHelper();
                // Map ret = await api.get("common/geo",params: {"uf": endereco.uf,"cidade": endereco.cidade,"logradouro": endereco.logradouro,"numero": endereco.numero});
                List<Location> locations = await locationFromAddress("Gronausestraat 710, Enschede");
                //List<Location> locations = await locationFromAddress("$_logradouroController + $_numeroController + $_cidadeController + $_ufController  ");
                print('antes $locations');
                Helper.navigateTo(locations[0].latitude, locations[1].longitude);
                // if (ret["id"] == 0){
                //   Helper.navigateTo(ret[locations[0]], ret[locations[1]]);
                //   print('depois $locations');
                // }
              },
            ),
          )
        ],
      ),
    );
  }
}