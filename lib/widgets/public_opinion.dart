



import 'dart:async';
import 'dart:math';

import 'package:Lets_Change/utils/colour.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SecondTab extends StatefulWidget {
  const SecondTab({super.key});

  @override
  State<SecondTab> createState() => _SecondTabState();
}

class _SecondTabState extends State<SecondTab> {
  List<ChartData> chartData = [
    ChartData('Very Good', 10),
    ChartData('Good', 20),
    ChartData('Ok', 30),
    ChartData('Bad', 40),
    ChartData('Angry', 50),
  ];

  @override
  void initState() {
    super.initState();
    // Start a timer to update the chart data every 3-4 seconds
    Timer.periodic(Duration(seconds: 3), (Timer timer) {
      setState(() {
        // Randomly update the chart data values
        chartData = List<ChartData>.generate(
          5,
              (index) => ChartData(
            chartData[index].x,
            Random().nextInt(100),
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(

              margin: EdgeInsets.symmetric(vertical: 25),
              color: Colors.lightBlueAccent,
              child: Text(
                '            Vote for your \n MUNCIPAL CORPORATION',
                style: TextStyle(fontSize: 20),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 10.0, // soften the shadow
                      spreadRadius: 5.0, //extend the shadow
                      offset: Offset(
                        10.0, // Move to right 10  horizontally
                        10.0, // Move to bottom 10 Vertically
                      ),
                    )
                  ]),
              child: SfCartesianChart(
                enableAxisAnimation: true,
                primaryXAxis: CategoryAxis(),
                series: [
                  StackedColumnSeries<ChartData, String>(
                    borderRadius: BorderRadius.circular(10),
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
        ],
      ),
    );
  }
}

class ChartData {
  final String x;
  final int y1;
  // final int y2;
  // final int y3;
  // final int y4;
  // final int y5;
  ChartData(
      this.x,
      this.y1,
      // this.y2,this.y3,this.y4,this.y5
      );
}



// import 'dart:async';
// import 'dart:math';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
//
// class SecondTab extends StatefulWidget {
//   const SecondTab({Key? key});
//
//   @override
//   State<SecondTab> createState() => _SecondTabState();
// }
//
// class _SecondTabState extends State<SecondTab> {
//   List<BarChartGroupData> chartData = [
//     BarChartGroupData(
//       x: 1,
//       barRods: [BarChartRodData(toY: 10)],
//     ),
//     BarChartGroupData(
//       x: 2,
//       barRods: [BarChartRodData(toY: 20)],
//     ),
//     BarChartGroupData(
//       x: 3,
//       barRods: [BarChartRodData(toY: 30)],
//     ),
//     BarChartGroupData(
//       x: 4,
//       barRods: [BarChartRodData(toY: 40)],
//     ),
//     BarChartGroupData(
//       x: 5,
//       barRods: [BarChartRodData(toY: 50)],
//     ),
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     Timer.periodic(Duration(seconds: 3), (Timer timer) {
//       setState(() {
//         chartData = List<BarChartGroupData>.generate(
//           5,
//           (index) => BarChartGroupData(
//             x: index,
//             barRods: [
//               BarChartRodData(
//                 toY: Random().nextInt(100).toDouble(),
//               ),
//             ],
//           ),
//         );
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Card(
//             margin: EdgeInsets.symmetric(vertical: 25),
//             color: Colors.lightBlueAccent,
//             child: Text(
//               '            Vote for your \n MUNICIPAL CORPORATION',
//               style: TextStyle(fontSize: 20),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//             child: Container(
//               height: MediaQuery.of(context).size.height * 0.5,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(25),
//                 boxShadow: const [
//                   BoxShadow(
//                     color: Colors.grey,
//                     blurRadius: 10.0,
//                     spreadRadius: 5.0,
//                     offset: Offset(10.0, 10.0),
//                   )
//                 ],
//               ),
//               child: BarChart(
//                 BarChartData(
//                   titlesData: FlTitlesData(
//                     leftTitles: AxisTitles(
//                       sideTitles: SideTitles(showTitles: true ,reservedSize: 30,getTitlesWidget: defaultGetTitle
//                       ),
//
//
//                     ),
//                     rightTitles: AxisTitles(
//                       sideTitles: SideTitles(showTitles: false),
//                     ),
//                     topTitles: AxisTitles(
//                       sideTitles: SideTitles(showTitles: false,),
//                     ),
//                     bottomTitles: AxisTitles(
//                       sideTitles: SideTitles(
//                         showTitles: true,
//                         // getTitles: (double value) {
//                         //   switch (value.toInt()) {
//                         //     case 0:
//                         //       return 'A';
//                         //     case 1:
//                         //       return 'B';
//                         //     case 2:
//                         //       return 'C';
//                         //     case 3:
//                         //       return 'D';
//                         //     case 4:
//                         //       return 'E';
//                         //     default:
//                         //       return '';
//                         //   }
//                         // },
//                       ),
//                     ),
//                   ),
//                   gridData: FlGridData(show: false),
//                   borderData: FlBorderData(show: false),
//                   barGroups: chartData,
//                   barTouchData: BarTouchData(
//                     touchTooltipData: BarTouchTooltipData(
//                       tooltipBgColor: Colors.blueGrey,
//                       getTooltipItem: (group, groupIndex, rod, rodIndex) {
//                         return BarTooltipItem(
//                           rod.toY.round().toString(),
//                           TextStyle(color: Colors.white),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }