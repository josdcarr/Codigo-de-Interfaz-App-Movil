import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:aplicacion_movil/funciones.dart';
import 'package:firebase_database/firebase_database.dart';
class OpcionTDS extends StatefulWidget {
  const OpcionTDS({Key? key}) : super(key: key);

  @override
  OpcionTDSState createState() => OpcionTDSState();
}
class OpcionTDSState extends State<OpcionTDS> {
  colorIndicadorClaseCuatro indicador = colorIndicadorClaseCuatro();
  final DatabaseReference databaseReference =
  FirebaseDatabase.instance.reference();
  DatabaseReference referencia= FirebaseDatabase.instance.ref('Valores actuales/TDS');
  String lecturaDeBD = '';
  double lecturaDouble=0;
  void initState() {
    super.initState();

    referencia.onValue.listen((event) {
      if (event.snapshot.value != null) {
        setState(() {
          lecturaDeBD = event.snapshot.value.toString();
          lecturaDouble=double.parse(lecturaDeBD);
       
        });
      } else {
        setState(() {
          lecturaDeBD = '-1';
      
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return  ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[ Text(
                                'Particulas por millón',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                )
                              ),
                                  SizedBox(height: 10),]),
                    CircularPercentIndicator(
                      radius: 180,
                      lineWidth: 14,
                      percent: 1,
                      progressColor:indicador.colorIndicadorCuatro(lecturaDouble),
                       center:  Text(
                        lecturaDeBD
                        ,style: TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.bold,color: Colors.white
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Center(
                      child: Text(
                        'ppm',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white,fontSize: 30),
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    
                  ]
                );
              
 
  }

}
