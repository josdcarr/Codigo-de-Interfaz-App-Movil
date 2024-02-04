import 'package:aplicacion_movil/main.dart';
import 'package:aplicacion_movil/slideTemp.dart';
import 'package:aplicacion_movil/funciones.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:firebase_database/firebase_database.dart';
class OpcionTemperatura extends StatefulWidget {
  const OpcionTemperatura({Key? key}) : super(key: key);
 
  @override
  _OpcionTemperaturaState createState() => _OpcionTemperaturaState();
}
class _OpcionTemperaturaState extends State<OpcionTemperatura> {
  colorIndicadorClase indicador = colorIndicadorClase();
  final DatabaseReference databaseReference =
  FirebaseDatabase.instance.reference();
  DatabaseReference referencia= FirebaseDatabase.instance.ref('Valores actuales/Temperatura');
  DatabaseReference referencia_2= FirebaseDatabase.instance.ref('Valores de control/Temperatura');
  String lecturaDeBD = '';
  double lecturaDouble=0;
  //Lectura de valor de control
  String lectura_2 = '';
  double lecturaDouble_2=0;
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
          lecturaDeBD = '0';
      
        });
      }
    });
        referencia_2.onValue.listen((event) {
      if (event.snapshot.value != null) {
        setState(() {
          lectura_2 = event.snapshot.value.toString();
          lecturaDouble_2=double.parse(lectura_2);
        
        });
      } else {
        setState(() {
          lectura_2 = '0';
      
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
            image: AssetImage("recursos/fondo1.jpg"),
            fit: BoxFit.cover,
          ),),
       child: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 18, left: 24, right: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.indigo,
                    )
                  ),
                ]
              ),
               Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const SizedBox(height: 10),
                     Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [const Text(
                    'TEMPERATURA',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),const SizedBox(height: 10),
                   Container( height: 180,width: 200,child :CircularPercentIndicator(
                                          radius: 180,
                                          lineWidth: 14,
                                          percent: 1,
                                          progressColor: indicador.colorIndicador(lecturaDouble, 0, 15, 35, 64),
                                          center:  Text(
                                           lecturaDeBD+"°C"
                                            ,style: TextStyle(
                                              fontSize: 42,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )) ] ),               

                    const SizedBox(height: 25),
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
                              'Encender calefón',
                              
                            ), Switch(
                            value: myModel.switchTemperatura,
                            onChanged: (value) {
                              setState(() {
                                myModel.switchTemperatura = value;
                              });
                              databaseReference.child("Valores de control").update({
                              'Control automatico temperatura': myModel.switchTemperatura,
                               });
                            },
            ),
                             SizedBox(height: 10), 
                             
                          ],
                        ),
                        )    ,
                       
                      ],
                    ),
                    const SizedBox(height: 25),
                    Container(margin: const EdgeInsets.only(left: 70, right: 70),
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 235, 186, 251),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                           Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: Text(
                              // ignore: prefer_interpolation_to_compose_strings
                              'Control a: '+ lectura_2+" °C",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        Center(
                        child: Consumer<SliderModel>(
                          builder: (context, SliderModel, child) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                              
                                SliderTemperaturaWidget(valor: SliderModel.sliderValue1,max: 40,min: 25),
                                
                                
                              ],
                            );
                          },
                        ),
      ),
                        
                        ]
                      )
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: const Color.fromARGB(255, 103, 187, 255)),
                        onPressed: myModel.switchTemperatura 
                        ? (){ databaseReference.child("Valores de control").update({
                        "Temperatura": myModel.sliderValue1.round(),
                        });}: null,
                        child: Text('Actualizar temperatura seleccionada',style: TextStyle(
                        color: Colors.white)),
                      ),
                    ),
                  ]
                )
              )
             ]
          )
        )
      )
        ),   
    );
 
  }


}
