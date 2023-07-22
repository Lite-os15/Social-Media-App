import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FirstTab extends StatefulWidget {
  const FirstTab({super.key});

  @override
  State<FirstTab> createState() => _FirstTabState();
}

class _FirstTabState extends State<FirstTab> {
  late List<GDPData> _chartData;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Colors.green,

      child: SfCircularChart(

        title: ChartTitle(text: 'ISSUES'),
        legend: Legend(isVisible:true, overflowMode: LegendItemOverflowMode.wrap),
        tooltipBehavior: _tooltipBehavior,
        series: <CircularSeries>[
          PieSeries<GDPData,String>(
            dataSource:_chartData,
            xValueMapper: (GDPData data,_)=>data.States,
            yValueMapper: (GDPData data,_)=> data.number,
            dataLabelSettings: DataLabelSettings(isVisible: true),
              enableTooltip:true,
              // maximumValue:4000,
          ),
        ],
      ),
    );

  }
}

List<GDPData> getChartData(){
  final List<GDPData> chartData=[
    GDPData('Solved',1600),
    GDPData('OnGoing',1254),
    GDPData('Pending',8542),


  ];
  return chartData;
}




class GDPData{
  GDPData(this.States,this.number);
  final String States;
  final int number;
}
