import 'package:aplicacion_movil/main.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
class OpcionAjustes extends StatefulWidget {
  const OpcionAjustes({Key? key}) : super(key: key);
 
  @override
  OpcionAjustesState createState() => OpcionAjustesState();
}

class OpcionAjustesState extends State<OpcionAjustes> {
  
  final DatabaseReference databaseReference =
  FirebaseDatabase.instance.reference();
  DatabaseReference referencia= FirebaseDatabase.instance.ref('Valores de control');
  
  String lecturaLitrosDeBD = '';
  String litros='';
  void initState() {
    super.initState();

    referencia.onValue.listen((event) {
      if (event.snapshot.value != null) {
        setState(() {
          lecturaLitrosDeBD = event.snapshot.child("Litros de piscina").value.toString();
                 
        });
      } else {
        setState(() {
          lecturaLitrosDeBD = '0';
          
        });
      }
    });
  }
    @override
  Widget build(BuildContext context) {
    final myModel = Provider.of<SliderModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Ajustes'),
        backgroundColor: const Color.fromARGB(255, 172, 238, 238),
      ),
      backgroundColor: Colors.blue.withOpacity(0),
      body: Container(
        decoration: BoxDecoration(
         image: DecorationImage(
            image: AssetImage("recursos/fondoAlternativo6.jpg"),
            fit: BoxFit.cover,
          ),),
       child:
       SafeArea(
        
        child: Container(
           margin: const EdgeInsets.only(top: 18, left: 24, right: 24),
          child: Column(
           
            children: [
           
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Contenido de la piscina ",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                      Text(lecturaLitrosDeBD+"Lt",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                    ],
                    ),
                    const SizedBox(height: 50),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Container( width: 100,
                      child: TextField(keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                      onChanged:(value){
                        litros=value;
                        print(litros);
                      }
                      )),
                       ElevatedButton(style: ElevatedButton.styleFrom(primary: const Color.fromARGB(255, 103, 187, 255)),
                        onPressed: (){
                          databaseReference.child("Valores de control").update({
                              'Litros de piscina':double.parse(litros) ,
                               }); 
                        }, child: Text('Actualizar',style: TextStyle(
                           color:  Colors.black ,fontWeight: FontWeight.bold 
                            ),),)
                             ],
                    ),const SizedBox(height: 50),
                    Container(
                        child: Consumer<SliderModel>(
                          builder: (context, SliderModel, child) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                              
                              Text("Metodo de control",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 23)),
                                const SizedBox(height: 20),
                                  ListTile(
                                    title: const Text('ON/OFF'),
                                    leading: Radio(
                                      value: 0,
                                      groupValue: myModel.control,
                                      onChanged: (value) {
                                        setState(() {
                                          myModel.control= 0;
                                        
                                        });
                                        databaseReference.child("Valores de control").update({
                                          'Control': 0,
                                          });
                                      },
                                    ),
                                  ),
                                  ListTile(
                                    title: const Text('Proporcional'),
                                    leading: Radio(
                                      value: 1,
                                      groupValue: myModel.control,
                                      onChanged: (value) {
                                        setState(() {
                                          myModel.control= 1;
                                        
                                        });
                                        databaseReference.child("Valores de control").update({
                                          'Control': 1,
                                          });
                                              },
                                            ),
                                          ), 
                                          ListTile(
                                    title: const Text('PID'),
                                    leading: Radio(
                                      value: 2,
                                      groupValue: myModel.control,
                                      onChanged: (value) {
                                        setState(() {
                                          myModel.control= 2;
                                        
                                        });
                                        databaseReference.child("Valores de control").update({
                                          'Control': 2,
                                          });
                                              },
                                            ),
                                          )
                                          ,                
                                          ],
                                        );
                                      },
                                    ),
                  ),
                                

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      ),
    );

  }

  }
