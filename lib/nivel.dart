import 'package:flutter/material.dart';
import 'package:aplicacion_movil/main.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:aplicacion_movil/funciones.dart';
import 'package:aplicacion_movil/tds.dart';
import 'package:firebase_database/firebase_database.dart';
class OpcionNivel extends StatefulWidget {
  const OpcionNivel({Key? key}) : super(key: key);

  @override
  _OpcionNivelState createState() => _OpcionNivelState();
}
class _OpcionNivelState extends State<OpcionNivel> {
  colorIndicadorClaseTres indicador = colorIndicadorClaseTres();
  final DatabaseReference databaseReference =
  FirebaseDatabase.instance.reference();
  DatabaseReference referencia= FirebaseDatabase.instance.ref('Valores actuales/Nivel agua');
  String lecturaDeBD = '';
  void initState() {
    super.initState();

    // Attach a real-time listener to fetch and update user1's data
    referencia.onValue.listen((event) {
      if (event.snapshot.value != null) {
        setState(() {
          lecturaDeBD = event.snapshot.value.toString();
         
       
        });
      } else {
        setState(() {
          lecturaDeBD = 'Error';
      
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final myModel = Provider.of<SliderModel>(context);
    return Scaffold(
       backgroundColor: Colors.indigo.shade50,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("recursos/fondoAlternativo3.jpeg"),
            fit: BoxFit.cover,
          ),),
       child:  SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 18, left: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.indigo,
                    )
                  )
                ]
              ),
               Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[ Text(
                                'Nivel de agua',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                )
                              ),
                                  SizedBox(height: 10),]),
                    CircularPercentIndicator(
                      radius: 180,
                      lineWidth: 14,
                      percent: 1,
                      progressColor: indicador.colorIndicadorTres(lecturaDeBD=="true"),
                       center:  Text(
                        textoNivelAgua(lecturaDeBD) 
                        ,style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold, color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                      Container(
                      
                        width: 200,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 126, 247, 247),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child:  Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                          
                          children: [
                            Text(
                              'Llenado automático',
                              
                            ), Switch(
                            value: myModel.switchNivel,
                            onChanged: (value) {
                              setState(() {
                                myModel.switchNivel = value;
                              });
                              databaseReference.child("Valores de control").update({
                              'Llenado automatico agua': myModel.switchNivel,
                               });
                            },
            ),
                             SizedBox(height: 10), 
                             
                          ],
                        ),
                        )    ,
                       
                      ],
                    ),
                    
                    
                    const SizedBox(height: 100),
                    Container(height: 300,
                      child:  OpcionTDS(),
                    )
                   
                  ]
                ),
              )
             ]
          )
        )
      )
        ),    
    );
 
  }
  
}