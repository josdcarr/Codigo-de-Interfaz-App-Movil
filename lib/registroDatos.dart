
import 'package:flutter/material.dart';
import 'package:aplicacion_movil/graficoDatos.dart';
import 'package:aplicacion_movil/funciones.dart';
import 'package:aplicacion_movil/registroDetallado.dart';
class OpcionRegistroDatos extends StatefulWidget {
  const OpcionRegistroDatos({Key? key}) : super(key: key);
 
  @override
  OpcionRegistroDatosState createState() => OpcionRegistroDatosState();
}

class OpcionRegistroDatosState extends State<OpcionRegistroDatos> {
  CreadorRutas rutaConstruir = CreadorRutas();
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de Datos'),
        backgroundColor: const Color.fromARGB(255, 172, 238, 238),
      ),
      backgroundColor: Colors.blue.withOpacity(0),
      body: Container(
        decoration: BoxDecoration(
         image: DecorationImage(
            image: AssetImage("recursos/fondoAlternativo5.jpg"),
            fit: BoxFit.cover,
          ),),
       child:
       SafeArea(
        
        child: Container(
          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
           
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                  
                    const SizedBox(height: 16),
                    FirebaseLineChart(parametro: 'Temperatura', minimo: 0, maximo: 65,),
                   
                    const SizedBox(height: 16),
                    FirebaseLineChart(parametro: 'TDS', minimo: 0, maximo: 1500,) ,    
                    const SizedBox(height: 16),
                    FirebaseLineChart(parametro: 'PH', minimo: 0, maximo: 14,),   
                    const SizedBox(height: 16), 
                     FirebaseLineChart(parametro: 'ORP', minimo: -500, maximo: 1000,),
                    ElevatedButton(onPressed: (){
                      Navigator.of(context).push(rutaConstruir.createRoute(FirebaseDataScreen()));
                    }, child: Text('Registro detallado',style: TextStyle(
          color:  Colors.black ,fontWeight: FontWeight.bold 
        ),),)
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


