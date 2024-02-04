import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aplicacion_movil/main.dart';

class SliderORPWidget extends StatefulWidget {
   final double valor;
   final double min;
   final double max;
  
   const SliderORPWidget({Key? key, required this.valor, required this.min, required this.max}) : super(key: key);
   
  @override
  _SliderVerticalWidgetState createState() => _SliderVerticalWidgetState(valor: this.valor,min: this.min,max: this.max);
}

class _SliderVerticalWidgetState extends State<SliderORPWidget> {
  
  
  double valor;
  double min;
  double max;
  
  _SliderVerticalWidgetState({required this.valor,required this.min,required this.max,});
  
  @override
  Widget build(BuildContext context) {

   
    return SliderTheme(
      data: SliderThemeData(
        trackHeight: 80,
        thumbShape: SliderComponentShape.noOverlay,
        overlayShape: SliderComponentShape.noOverlay,
        valueIndicatorShape: SliderComponentShape.noOverlay,

        trackShape: RectangularSliderTrackShape(),

        
        activeTickMarkColor: Colors.transparent,
        inactiveTickMarkColor: Colors.transparent,
      ),
      child: Container(
        height: 270,
        child: Column(
          children: [
            buildSideLabel(max),
            const SizedBox(height: 16),
            Expanded(
              child: Stack(
                children: [
                  RotatedBox(
                    quarterTurns: 3,
                    child: Slider(
                      value: valor,
                      activeColor: Colors.blue,
                      min: min,
                      max: max,
                      divisions: 40,
                      label: (valor).toString(),
                      onChanged: (value)   {setState(() => valor = value);
                      Provider.of<SliderModel>(context, listen: false)
                        .sliderValue2 = value;
                  },
                      
                    ),
                  ),
                  Center(
                    child: Text(
                      '${valor.round()}',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            buildSideLabel(min),
          ],
        ),
      ),
    );
  }

  Widget buildSideLabel(double value) => Text(
        value.round().toString(),
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      );


}
