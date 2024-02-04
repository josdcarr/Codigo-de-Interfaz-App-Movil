import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:aplicacion_movil/main.dart';
import 'package:provider/provider.dart';
import 'package:aplicacion_movil/slidepH.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:aplicacion_movil/funciones.dart';
class Opcionph extends StatefulWidget {
  const Opcionph({Key? key}) : super(key: key);

  @override
  _OpcionphState createState() => _OpcionphState();
}
class _OpcionphState extends State<Opcionph> {
  colorIndicadorClaseDos indicador = colorIndicadorClaseDos();
  final DatabaseReference databaseReference =
  FirebaseDatabase.instance.reference();
  DatabaseReference referencia= FirebaseDatabase.instance.ref('Valores actuales/ph');
    DatabaseReference referencia_2= FirebaseDatabase.instance.ref('Valores de control/pH');
  String lecturaDeBD = '';
  double lecturaDouble=0;
    //Lectura de valor de control
  String lectura_2 = '';
  double lecturaDouble_2=0;
  void initState() {
    super.initState();

    // Attach a real-time listener to fetch and update user1's data
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
      body:  Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("recursos/fondo3.jpeg"),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Color.fromARGB(255, 251, 251, 251),
                    )
                  ),
                  
                ]
              ),
               Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                   const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[ Text(
                                'Nivel de pH',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.bold,
                                )
                              ),
                                  SizedBox(height: 10),]),
                    CircularPercentIndicator(
                     
                      radius: 180,
                      lineWidth: 14,
                      percent: 1,
                      progressColor:  indicador.colorIndicadorDos(lecturaDouble, 7,8),
                       center:  Text(
                        lecturaDeBD
                        ,style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,color: Color.fromARGB(255, 0, 0, 0)
                        ),
                      ),
                    ),
                     SizedBox(height: 32),
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
                              'Regulación pH',
                              
                            ), Switch(
                            value: myModel.switchPH,
                            onChanged: (value) {
                              setState(() {
                                myModel.switchPH = value;
                              });
                              databaseReference.child("Valores de control").update({
                              'Control automatico pH': myModel.switchPH,
                               });
                            },
            ),
                             SizedBox(height: 10), 
                             
                          ],
                        ),
                        )    ,
                       
                      ],
                    ),
                    const SizedBox(height: 32),
                    Container(margin: const EdgeInsets.only(left: 70, right: 70),
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                           Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: Text(
                               'Control a: '+ lectura_2,
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
                              
                                SliderPHWidget(valor: SliderModel.sliderValue3,max: 8,min: 7),
                               
                                
                              ],
                            );
                          },
                        ),
      ),
                        ]
                      )
                    ),const SizedBox(height: 24),
                     Center(
                      child: ElevatedButton(

                 onPressed: myModel.switchPH 
              ? (){ databaseReference.child("Valores de control").update({
                    "pH": (myModel.sliderValue3 * 10).round() / 10,
                  });
                     }: null,
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
        color: const Color.fromARGB(255, 182, 182, 182) ,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color.fromARGB(255, 191, 192, 194)),
      ),
      child: Text(
        title,
        style: TextStyle(
          color:  Colors.black ,
        ),
      ),
    );
  }
   void _onButtonPressed() {
    // Add your button press logic here
    print('Button Pressed!');
  }


}
