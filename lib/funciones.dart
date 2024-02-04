  import 'package:flutter/material.dart';

  class colorIndicadorClase {
  Color colorIndicador(double valor, double valor1,double valor2,double valor3,double valor4) {
    // Funcion de cambio de color para la temperatura
    if (valor1<valor && valor<valor2) {
      return Colors.blue;
    } else if (valor2<=valor && valor<valor3) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }
  }
    class colorIndicadorClaseDos {
  Color colorIndicadorDos(double valor, double valor1,double valor2) {
    // Funcion de cambio de color para pH y ORP
    if (valor>=valor1 && valor<=valor2) {
      return Colors.green;
    } else {
      return Colors.red;
    } 
  }
  }
      class colorIndicadorClaseTres {
  Color colorIndicadorTres(bool valor) {
    // Funcion de cambio de color para el nivel de agua
    if (valor) {
      return Colors.green;
    } else {
      return Colors.red;
    } 
  }
  }
        class colorIndicadorClaseCuatro {
  Color colorIndicadorCuatro(double valor) {
    // Funcion de cambio de color para datos TDS
    if (valor<=1000) {
      return Colors.green;
    } else {
      return Colors.red;
    } 
  }
  }
    String textoNivelAgua(String nivel) {
    // Cambio de texto en la pantalla de nivel de agua
    if (nivel=="true") {
     
      return 'Normal';
    }  else {
      return 'Bajo';
    }
  }
class CreadorRutas{
Route createRoute(ruta  ) {
  
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>  ruta,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}}
