import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AclAwait{

  Widget Loading(Function future, Function ret){
    return Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              child: FutureBuilder(
                future: future(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return Center(
                        child: Container(
                          width: 140.0,
                          height: 140.0,
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                            strokeWidth: 5.0,
                          ),
                        ),
                      );
                    default:
                      if (snapshot.hasError)
                        return Container(child: Text(snapshot.error.toString()));
                      else if (snapshot.data != null)
                        return ret(context);
                      else{
                        return Center(
                          child: ElevatedButton(
                            child: Text("Usuario sem permissão"),
                            onPressed: (){
                              Navigator.pop(context);
                            },
                          ),
                        );
                      }
                  }
                },
              ),
            ),
          ],
        ));
  }
}