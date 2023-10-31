import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:async';
import 'dart:math';

class FirstTab extends StatefulWidget {
  const FirstTab({super.key});

  @override
  State<FirstTab> createState() => _FirstTabState();
}

class _FirstTabState extends State<FirstTab> {
  late List<GDPData> _chartData;
  late TooltipBehavior _tooltipBehavior;
  Timer? _timer;

  @override
  void initState() {
    _chartData = getInitialChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);

    _timer = Timer.periodic(Duration(seconds: 4), (timer) {
      // Update data dynamically every 2 seconds
      setState(() {
        _chartData = getRandomChartData();
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int totalIssues = _chartData.fold(0, (sum, data) => sum + data.number);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          margin: EdgeInsets.symmetric(vertical: 25,horizontal: 10),
          elevation: 15,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          child: SfCircularChart(
            title: ChartTitle(text: 'ISSUES'),
            legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
            tooltipBehavior: _tooltipBehavior,
            series: <CircularSeries>[
              PieSeries<GDPData, String>(
                dataSource: _chartData,
                xValueMapper: (GDPData data, _) => data.States,
                yValueMapper: (GDPData data, _) => data.number,
                dataLabelSettings: DataLabelSettings(
                  isVisible: true,
                  labelPosition: ChartDataLabelPosition.outside,
                ),
                enableTooltip: true,
              ),
            ],
          ),
        ),
        Text(
          'Total Issues: $totalIssues',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  List<GDPData> getInitialChartData() {
    final List<GDPData> chartData = [
      GDPData('Solved', 16),
      GDPData('OnGoing', 12),
      GDPData('Pending', 24),
    ];
    return chartData;
  }

  List<GDPData> getRandomChartData() {
    final Random random = Random();
    final List<GDPData> chartData = [
      GDPData('Solved', random.nextInt(20)),
      GDPData('OnGoing', random.nextInt(15)),
      GDPData('Pending', random.nextInt(30)),
    ];
    return chartData;
  }
}

class GDPData {
  GDPData(this.States, this.number);
  final String States;
  final int number;
}


//
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
//
// class FirstTab extends StatefulWidget {
//   const FirstTab({super.key});
//
//   @override
//   State<FirstTab> createState() => _FirstTabState();
// }
//
// class _FirstTabState extends State<FirstTab> {
//   late List<GDPData> _chartData;
//   late TooltipBehavior _tooltipBehavior;
//
//   @override
//   void initState() {
//     _chartData = getChartData();
//     _tooltipBehavior = TooltipBehavior(enable: true);
//     super.initState();
//   }
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return  Card(
//       elevation: 15,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
//
//
//       child: SfCircularChart(
//
//         title: ChartTitle(text: 'ISSUES'),
//         legend: Legend(isVisible:true, overflowMode: LegendItemOverflowMode.wrap),
//         tooltipBehavior: _tooltipBehavior,
//         series: <CircularSeries>[
//           PieSeries<GDPData,String>(
//             dataSource:_chartData,
//             xValueMapper: (GDPData data,_)=>data.States,
//             yValueMapper: (GDPData data,_)=> data.number,
//             dataLabelSettings: const DataLabelSettings(isVisible: true),
//             enableTooltip:true,
//             // maximumValue:4000,
//           ),
//         ],
//       ),
//     );
//
//   }
// }
//
// List<GDPData> getChartData(){
//   final List<GDPData> chartData=[
//     GDPData('Solved',16),
//     GDPData('OnGoing',12),
//     GDPData('Pending',24),
//
//
//   ];
//   return chartData;
// }
//
//
//
//
// class GDPData{
//   GDPData(this.States,this.number);
//   final String States;
//   final int number;
// }
