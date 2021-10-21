// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:parcial3_2506632017/providers/usuarios_provider.dart';

class UsuariosScreen extends StatefulWidget {
  const UsuariosScreen({Key? key}) : super(key: key);

  @override
  State<UsuariosScreen> createState() => _UsuariosScreenState();
}

class _UsuariosScreenState extends State<UsuariosScreen> {
  @override
  Widget build(BuildContext context) {

    UsuariosProvider usuariosProvider = UsuariosProvider();

    return Container(
      color: Colors.deepOrange.shade700,
          child: FutureBuilder(
            future: usuariosProvider.getUsuarios(),
            builder: (context, snapshot){

              if(snapshot.hasData){
                final datos = snapshot.data;

                return _crearListViewDatos(context, datos, usuariosProvider);
              } else if (snapshot.hasError) {
                return Center(child: CircularProgressIndicator());
              } else{
                return Center(child: CircularProgressIndicator());
              }

            },
          ),
    );
  }

  Widget _crearListViewDatos(BuildContext context, data, UsuariosProvider usuariosProvider){
    List items = data;

    return Scaffold(
      appBar: AppBar(
        title: Text('Toca rápidamente una vez para editar\n manten presionado para eliminar', style: TextStyle(fontSize: 12.0),),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, i) => Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.deepOrange.shade200,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 5.0)
                )
              ]
            ),
            child: TextButton(
              child: Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(items[i].nombre, style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold)),
                      Text(items[i].correo, style: TextStyle(color: Colors.white, fontSize: 12.0, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
              onPressed: (){
    
                Navigator.pushNamed(context, 'usuario_edit', arguments: items[i].id);
    
              },
              onLongPress: (){
                usuariosProvider.elmUsuario(items[i].id);
    
                setState(() { });
                
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.person_add_rounded),
        onPressed: () => Navigator.pushNamed(context, 'usuario_add'),
      ),
    );
  }
}