import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:firebase_database/firebase_database.dart';


class FirebaseLineChart extends StatefulWidget {

   final String parametro;
   final double minimo;
   final double maximo;

  FirebaseLineChart({Key? key,  
  
  required this.parametro,
  required this.minimo,
  required this.maximo
  }) : super(key: key);

  @override
  _FirebaseLineChartState createState() => _FirebaseLineChartState(
  minimo: this.minimo,
  maximo: this.maximo,
  parametro: this.parametro);
}
class _FirebaseLineChartState extends State<FirebaseLineChart> {
  final List<String> id=[];
  final List<double> mediciones=[];
  String parametro;
  double minimo;
  double maximo;
  _FirebaseLineChartState ({
  required this.minimo,
  required this.maximo,
 required this.parametro});
  @override
  void initState() {
    super.initState();
    // Initialize Firebase connection and set up listeners
    DatabaseReference reference = FirebaseDatabase.instance.reference().child('Valores medidos');

    reference.onChildAdded.listen(( event) {
      // Update the X and Y values when new data is added to Firebase
      setState(() {
        if(id.length>9){
          id.removeAt(0);
          mediciones.removeAt(0);
        }
        if(event.snapshot.child("Hora").value.toString()!="null" && 
        !id.contains(event.snapshot.child("Hora").value.toString())){
        
        id.add(event.snapshot.child("Hora").value.toString());
        mediciones.add(double.parse(event.snapshot.child("Sensor $parametro").value.toString()));
      
       }

       
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return 
        Column(
           mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("Registro de $parametro",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                 Container(
                  decoration: BoxDecoration(color: Colors.blue.withOpacity(0)),
          height: 330, 
          padding: EdgeInsets.all(15.0),
          child: 
          LineChart(
            LineChartData(
              backgroundColor: const Color.fromARGB(255, 150, 204, 247),
              minX: 0, 
              maxY: maximo,
              minY: minimo,
              maxX: 10,
              titlesData:  FlTitlesData(rightTitles: AxisTitles(),
              topTitles:AxisTitles(), 
              leftTitles:AxisTitles(sideTitles: SideTitles(showTitles: true,reservedSize: 40),
              axisNameWidget: Text("$parametro",
              style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20)
              ),axisNameSize: 25),
              bottomTitles: 
               AxisTitles(sideTitles: generarGrafica()
              ,axisNameSize: 30) ,),
              gridData: FlGridData(
              show: true,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: const Color(0xff37434d),
                  strokeWidth: 3,
                );
              },
              drawVerticalLine: false
            ),
              borderData: FlBorderData(
              show: true,
              border: Border.all(color: const Color(0xff37434d), width: 1),
            ),
               lineBarsData: [
                LineChartBarData(
                  
                  spots: List.generate(mediciones.length, (index) {
                    return FlSpot(index.toDouble(), mediciones[index].toDouble());
                  }),
                  isCurved: true,
                  color: const Color.fromARGB(255, 28, 28, 29),dotData: FlDotData(
                  show: true,)
                 
                ),
              ],
            ),
          ),
        ),
        ],); 
  }
  SideTitles generarGrafica() {
      return SideTitles(
        reservedSize: 50,
        showTitles: true,
        
        getTitlesWidget: (value, meta) {
              int index = value.toInt();
              
              if (index >= 0 && index < id.length) {
                String posicion=id[index];
                
                return SideTitleWidget( angle: 1, axisSide: meta.axisSide, child: Text(posicion));
              }
              return SideTitleWidget(axisSide: meta.axisSide, child: Text(""),);
            },
      );
    }
}