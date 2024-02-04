import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseDataScreen extends StatelessWidget {
  final DatabaseReference _database = FirebaseDatabase.instance.ref('Valores medidos');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro Detallado'),
        backgroundColor: Colors.amberAccent,
      ),
      body: FirebaseAnimatedList(
        query: _database.limitToLast(20),
        itemBuilder: ( context,  snapshot,  animation,  index) {
          return Card(color: const Color.fromARGB(255, 151, 223, 233),
            child: ListTile(
            title: Text("${snapshot.child("Mes").value} ${snapshot.child("Día").value}, ${snapshot.child("Hora").value}",style: const TextStyle(
          color:  Colors.black ,fontWeight: FontWeight.bold 
        )
            ),subtitle:  Text("pH: ${snapshot.child("Sensor PH").value}     ORP: ${snapshot.child("Sensor ORP").value}     Temp: ${snapshot.child("Sensor Temperatura").value}°C     Nivel: ${snapshot.child("Sensor Nivel de agua").value}\nTDS: ${snapshot.child("Sensor TDS").value}",style: const TextStyle(
          color:  Colors.black ,
        )),
          
          ));
        },
      ),
    );
  }
}