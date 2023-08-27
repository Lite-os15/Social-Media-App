import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';



class SecondTab extends StatefulWidget {
  const SecondTab({super.key});

  @override
  State<SecondTab> createState() => _SecondTabState();
}

class _SecondTabState extends State<SecondTab> {



  final List<ChartData> chartData = [
    ChartData('Very Good', 10,),
    ChartData('Good', 20),
    ChartData('Ok', 30),
    ChartData('Bad', 40),
    ChartData('Angry',50),
  ];




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.5,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
              boxShadow: [

            BoxShadow(
            color: Colors.grey,
            blurRadius: 10.0, // soften the shadow
            spreadRadius: 5.0, //extend the shadow
            offset: Offset(
              10.0, // Move to right 10  horizontally
              10.0, // Move to bottom 10 Vertically
            ),
          )
              ]
          ),
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            series: [
              StackedColumnSeries<ChartData,String>(
                  dataSource: chartData,
                  xValueMapper: (ChartData ch, _) => ch.x,
                  yValueMapper: (ChartData ch, _) => ch.y1,
              ),
              // StackedColumnSeries<ChartData,String>(
              //   dataSource: chartData,
              //   xValueMapper: (ChartData ch, _) => ch.x,
              //   yValueMapper: (ChartData ch, _) => ch.y2,
              // ),
              // StackedColumnSeries<ChartData,String>(
              //   dataSource: chartData,
              //   xValueMapper: (ChartData ch, _) => ch.x,
              //   yValueMapper: (ChartData ch, _) => ch.y3,
              // ),
              // StackedColumnSeries<ChartData,String>(
              //   dataSource: chartData,
              //   xValueMapper: (ChartData ch, _) => ch.x,
              //   yValueMapper: (ChartData ch, _) => ch.y4,
              // ),
              // StackedColumnSeries<ChartData,String>(
              //   dataSource: chartData,
              //   xValueMapper: (ChartData ch, _) => ch.x,
              //   yValueMapper: (ChartData ch, _) => ch.y5,
              // ),
            ],



          ),
        ),
      ),

    );
  }
}



class ChartData{
  final String x;
  final int y1;
  // final int y2;
  // final int y3;
  // final int y4;
  // final int y5;
  ChartData(this.x,this.y1,
      // this.y2,this.y3,this.y4,this.y5
      );
}