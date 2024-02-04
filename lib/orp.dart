import 'package:flutter/material.dart';
import 'package:aplicacion_movil/main.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:aplicacion_movil/slideORP.dart';
import 'package:provider/provider.dart';
import 'package:aplicacion_movil/funciones.dart';
import 'package:firebase_database/firebase_database.dart';
class OpcionORP extends StatefulWidget {
  const OpcionORP({Key? key}) : super(key: key);

  @override
  _OpcionORPState createState() => _OpcionORPState();
}
class _OpcionORPState extends State<OpcionORP> {
  colorIndicadorClaseDos indicador = colorIndicadorClaseDos();
  final DatabaseReference databaseReference =
  FirebaseDatabase.instance.reference();
  DatabaseReference referencia= FirebaseDatabase.instance.ref('Valores actuales/ORP');
    DatabaseReference referencia_2= FirebaseDatabase.instance.ref('Valores de control/ORP');
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
          lecturaDeBD = '-1';
      
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
      body:Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("recursos/fondoAlternativo4.jpeg"),
            fit: BoxFit.cover,
          ),),
       child:  SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 18, left: 24, right: 24),
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
                      color: Color.fromARGB(255, 255, 255, 255),
                    )
                  )
                ]
              ),
               Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),  
                  
                  children: [
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[ Text(
                                'Nivel de ORP',
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
                      progressColor: indicador.colorIndicadorDos(lecturaDouble, 650,850),
                       center:  Text(
                        lecturaDeBD+"mV"
                        ,style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,color: Colors.white
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
                              'Regulación ORP',
                            ), Switch(
                            value: myModel.switchORP,
                            onChanged: (value) {
                              setState(() {
                                myModel.switchORP = value;
                              });
                              databaseReference.child("Valores de control").update({
                              'Control automatico ORP': myModel.switchORP,
                               });
                            },
            ),
                             SizedBox(height: 10), 
                             
                          ],
                        ),
                        )    ,
                       ],
                    ),
                    const SizedBox(height: 20),
                    Container(  margin: const EdgeInsets.only(left: 70, right: 70),
                      padding: const EdgeInsets.symmetric(vertical: 10), 
                      width: 12,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                            Text(
                                'Control a: '+ lectura_2,
                              style: TextStyle(
                                fontWeight: FontWeight.bold, 
                              ),
                            ), Center(
                        child: Consumer<SliderModel>(
                          builder: (context, SliderPreference, child) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                              
                                SliderORPWidget(valor: SliderPreference.sliderValue2,max: 800,min: 700),
                                
                                
                              ],
                            );
                          },
                        ),
      ),
                              
                                
                                
                              
                          
                        
                        ]
                      )
                    ) ,const SizedBox(height: 24),
                    Center(
                      child: ElevatedButton(
                        onPressed: myModel.switchORP 
                        ? (){ databaseReference.child("Valores de control").update({
                        "ORP": myModel.sliderValue2.round(),
                        });}: null,
                        child: Text('Actualizar valor de control'),
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
   Widget _roundedButton({
    required String title,
    bool isActive = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 32,
      ),
      decoration: BoxDecoration(
        color:  const Color.fromARGB(255, 130, 202, 211) ,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.indigo),
      ),
      child: Text(
        title,
        style: TextStyle(
          color:  Colors.black,fontSize: 20
        ),
      ),
    );
  }
  





  
}
