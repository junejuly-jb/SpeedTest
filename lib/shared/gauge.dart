import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Gauge extends StatelessWidget {
  final double transferRateState;
  final String unitText;
  const Gauge({ Key? key, required this.transferRateState, required this.unitText }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      enableLoadingAnimation: true,
      animationDuration: 4000,
      axes: [
        RadialAxis(
          axisLabelStyle: const GaugeTextStyle(
            color: Colors.white
          ),
          axisLineStyle: const AxisLineStyle(
            thickness: 20, 
            color: Color.fromARGB(255, 35, 47, 78)
          ), 
          showTicks: false,
          minimum: 0, 
          maximum: 50,
          // interval: 10,
          pointers: [
            NeedlePointer(
              needleStartWidth: 3,
              needleEndWidth: 10, 
              needleLength: 0.5,
              needleColor: const Color(0xFFDADADA),
              gradient: const LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.white, Colors.transparent,
                ]
              ),
              knobStyle: const KnobStyle(
                color: Colors.transparent,
                // knobRadius: 0.13,
                // borderWidth: 0.08
              ),
              
              value: transferRateState,
              enableAnimation: true,
            ),
            RangePointer(
              value: transferRateState, 
              width: 20, 
              enableAnimation: true, 
              // color: Colors.blue
              gradient: const SweepGradient(
                colors: <Color>[Color.fromARGB(255, 0, 164, 223), Color.fromARGB(255, 23, 187, 130)],
                stops: <double>[0.25, 0.75]
              )
            )
          ],
          annotations: [
            GaugeAnnotation(
              angle: 90,
              positionFactor: 1,
              widget: AnimatedFlipCounter(
                value: transferRateState,
                fractionDigits: 2, // decimal precision
                suffix: unitText,
                textStyle: const TextStyle(
                    fontSize: 18,
                    color: Colors.white
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}