import 'package:aplicacion_movil/temperatura.dart';
import 'package:aplicacion_movil/pH.dart';
import 'package:aplicacion_movil/orp.dart';
import 'package:aplicacion_movil/nivel.dart';
import 'package:aplicacion_movil/registroDatos.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:aplicacion_movil/funciones.dart';
import 'package:aplicacion_movil/ajustes.dart';
void main() async {



  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyDKF5rpyd2-GvOxe8BQAfE0_04GodHXSZk",
      appId: "1:826979249794:android:9d784ecace7936a12a4e9b",
      messagingSenderId: "826979249794",
      projectId: "tesis-706e5",
    ),
  );
  runApp(MyApp());
}
class SliderModel extends ChangeNotifier {
  //Memoria interna para guardar valores de los sliders
  double _sliderValue1 =35.0;
  double _sliderValue2 = 700.0;
  double _sliderValue3 = 7.0;
  bool _switchTemperatura= false;
  bool _switchPH= false;
  bool _switchORP= false;
  bool _switchNivel= false;
  double _control=0;
  bool _subirBajarpH=false;


  double get sliderValue1 => _sliderValue1;
  double get sliderValue2 => _sliderValue2;
  double get sliderValue3 => _sliderValue3;
  bool get switchTemperatura => _switchTemperatura;
  bool get switchPH => _switchPH;
  bool get switchORP => _switchORP;
  bool get switchNivel => _switchNivel;
  double get control => _control;
   bool get subirBajarpH => _subirBajarpH;
  
  set sliderValue1(double value) {
    _sliderValue1 = value;
    notifyListeners();
  }

  set sliderValue2(double value) {
    _sliderValue2 = value;
    notifyListeners();
  }
  set sliderValue3(double value) {
    _sliderValue3 = value;
    notifyListeners();
  }
  set switchTemperatura(bool value) {
    _switchTemperatura = value;
    notifyListeners();
  }
  set switchPH(bool value) {
    _switchPH = value;
    notifyListeners();
  }
  set switchORP(bool value) {
    _switchORP = value;
    notifyListeners();
  }
  set switchNivel(bool value) {
    _switchNivel = value;
    notifyListeners();
  }
    set control(double value) {
    _control = value;
    notifyListeners();
  }
    set subirBajarpH(bool value) {
    _subirBajarpH = value;
    notifyListeners();
  }

}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SliderModel(),
      child: MaterialApp(
        title: 'Control de agua',
      theme: ThemeData(

        primarySwatch: Colors.cyan, 
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
      ),
    );
  }
}


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {


  CreadorRutas rutaConstruir = CreadorRutas();
  bool valorSwitch = false;
  final DatabaseReference databaseReference =
  FirebaseDatabase.instance.reference();

 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 218, 219, 220),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("recursos/fondo6.jpg"),
            fit: BoxFit.cover,
          ),),
       child:
       SafeArea(
        
        child: Container(
          margin: const EdgeInsets.only(top: 18, left: 24, right: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                   Text(
                    'Panel Inicial',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                ],
              ),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [ const SizedBox(height: 32),
                    Center(
                      child: Image.asset(
                        'recursos/logoESPOL2.png',
                         height: 100,
                         width: 300,
                      )
                          ),
                    const SizedBox(height: 16),
                     Center(

                      child:  Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,horizontal: 16,
                        ),
                        width: 400,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 240, 241, 241),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child:  Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                          
                          children: [
                            Text(
                              'Encendido de bomba  ',
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black,fontSize: 20,),
                            ),Switch(
                                // This bool value toggles the switch.
                                value: valorSwitch ,
                                activeColor: Colors.red,
                                onChanged: (bool value) {
                                  // This is called when the user toggles the switch.
                                  
                                  setState(() {
                                    valorSwitch  = value;
                                  });
                                  databaseReference.child("Valores de control").update({
                              'Encendido de bomba': valorSwitch,
                               });
                                },
                              ),
                             SizedBox(height: 10), 
                             
                          ],
                        ),
                        )    
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'OPCIONES',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        opciones(
                          onTap: () {
                                Navigator.of(context).push(rutaConstruir.createRoute(OpcionTemperatura()) );
                              },
                          icon: 'recursos/temperatura.png',
                          title: 'Temperatura',
                          tamano: 80,
                          color: const Color.fromARGB(255, 250, 191, 191)
                          
                        ),opciones(
                            onTap: () {
                                Navigator.of(context).push(rutaConstruir.createRoute(OpcionORP()));
                              },
                          icon: 'recursos/orp.png',
                          title: 'ORP',
                          tamano: 80,
                          color: const Color.fromARGB(255, 127, 174, 254)
                        ),
                      ]
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        opciones(
                            onTap: () {
                                Navigator.of(context).push(rutaConstruir.createRoute(Opcionph()));
                              },
                          icon: 'recursos/pH.png',
                          title: 'pH',
                          tamano: 80,
                          color: const Color.fromARGB(255, 127, 174, 254)
                        ),opciones(
                              onTap: () {
                                Navigator.of(context).push(rutaConstruir.createRoute(OpcionNivel()));
                              },
                                icon: 'recursos/waterLevel.png',
                                title: 'Nivel de agua/TDS',
                                tamano: 80,
                                color: const Color.fromARGB(255, 250, 191, 191)
                        )
                      


                      
                      ]
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                            opciones(
                              onTap: () { 
                                Navigator.of(context).push(rutaConstruir.createRoute(OpcionRegistroDatos()));
                              },
                                icon: 'recursos/estadistico.png',
                                title: 'Registro de datos',
                                tamano: 80,
                                color:  Color.fromARGB(255, 100, 221, 120)
                        ),opciones(
                              onTap: () { 
                                Navigator.of(context).push(rutaConstruir.createRoute(OpcionAjustes()));
                              },
                                icon: 'recursos/ajustes.png',
                                title: 'Ajustes',
                                tamano: 80,
                                color:  Color.fromARGB(255, 100, 221, 120)
                        )
                      ]
                    )       
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

  Widget opciones({
    required String title,
    required String icon,
    required double tamano,
    required Color color,
    VoidCallback? onTap,
    
    Color fontColor = Colors.black,
  }){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
        ),
        width: 150,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            Image.asset(icon,height: tamano,
                         width: tamano,),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, color: fontColor),
            )
          ],
        ),
      ),
    );

  }

}


