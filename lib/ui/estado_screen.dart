import 'package:agilefacil_mob/helpers/tipos.dart';
import 'package:flutter/material.dart';

class EstadoScreen extends StatefulWidget {
  @override
  _EstadoScreenState createState() => _EstadoScreenState();
}

class _EstadoScreenState extends State<EstadoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).primaryColor,iconTheme: IconThemeData(color: Colors.white),
        title: Text("Estados", style: TextStyle(fontSize: 22,fontFamily: 'Secular',color: Colors.white)),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemCount: Diversos.Estados.length,
              itemBuilder: biuldItem
            )
          )
        ],
      ),
    );
  }

  Widget biuldItem(context, index) {
    return GestureDetector(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(Diversos.Estados[index],style: TextStyle(fontSize: 16.0, color: Theme.of(context).primaryColor)),
          Divider()
        ],
      ),
      onTap: (){
        Estado estado = Estado();
        estado.descricao = Estado.getEstado(index);
        estado.uf = Estado.getUF(index);
        estado.codibge = Estado.getCodIbge(index);
        Navigator.pop(context,estado);
      },
    );
  }
}


