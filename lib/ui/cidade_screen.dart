import 'package:agilefacil_mob/helpers/api_helper.dart';
import 'package:agilefacil_mob/helpers/tipos.dart';
import 'package:flutter/material.dart';

class CidadeScreen extends StatefulWidget {

  final String uf;
  CidadeScreen(this.uf);

  @override
  _CidadeScreenState createState() => _CidadeScreenState();

}

class _CidadeScreenState extends State<CidadeScreen> {

  String uf = "";
  static String _search = "";
  int _startrow = 0;

  Future<Map> _getList() async {
    ApiHelper api = ApiHelper();
    return await api.get("common/cidade/list",params: {"uf": uf,"search": _search,"startrow": _startrow.toString()});
  }


  @override
  void initState() {
    super.initState();
    this.uf = widget.uf;

    _getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).primaryColor,iconTheme: IconThemeData(color: Colors.white),
        title: Text("Cidades", style: TextStyle(fontSize: 22,fontFamily: 'Secular',color: Colors.white)),
      ),
      body: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField(style: TextStyle(color: Theme.of(context).primaryColor),
                  decoration: InputDecoration(labelText: "Pesquise aqui"),autofocus: true,onChanged: (value){
                  setState(() {
                    _search = value;
                  });
                },)
            ),
            Expanded(
              child: FutureBuilder(
                future: _getList(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return Container(
                        width: 200.0,
                        height: 200.0,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                          strokeWidth: 5.0,
                        ),
                      );
                    default:
                      if (snapshot.hasError)
                        return Container();
                      else
                        return _createCidadeTable(context, snapshot);
                  }
                },
              )
            )
          ]
      )
    );
  }


  Widget _createCidadeTable(BuildContext context, AsyncSnapshot snapshot) {
    return ListView.builder(
      padding: EdgeInsets.all(10.0),
      itemCount: snapshot.data["cidades"].length,
      itemBuilder: (context,index){
        return GestureDetector(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(snapshot.data["cidades"][index]["descricao"],style: TextStyle(fontSize: 16.0, color: Theme.of(context).primaryColor)),
              Divider()
            ],
          ),
          onTap: (){
            Cidade cidade = Cidade.fromMap(snapshot.data["cidades"][index]);
            Navigator.pop(context,cidade);
          },
        );
      });
  }
}
