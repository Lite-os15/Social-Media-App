import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/user_details_screen.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphScreen extends StatefulWidget {
  const GraphScreen({Key? key}) : super(key: key);

  @override
  State<GraphScreen> createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
late List<GDPData> _chartData;
late TooltipBehavior _tooltipBehavior;
  @override
  void initState() {
     _chartData =getChartData();
     _tooltipBehavior =TooltipBehavior(enable: true);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: SfCircularChart(

          title: ChartTitle(text: 'continent'),
          legend: Legend(isVisible:true, overflowMode: LegendItemOverflowMode.wrap),
          tooltipBehavior: _tooltipBehavior,
          series: <CircularSeries>[
            PieSeries<GDPData,String>(
              dataSource:_chartData,
              xValueMapper: (GDPData data,_)=>data.continent,
              yValueMapper: (GDPData data,_)=> data.gdp,
              dataLabelSettings: DataLabelSettings(isVisible: true),
                enableTooltip:true,
                // maximumValue:4000,
            ),
          ],
        ),
      ),
    );
  }
  List<GDPData> getChartData(){
    final List<GDPData> chartData=[
      GDPData('Oceania',1600),
      GDPData('Oceania',1254),
      GDPData('Oceania',8542),
      GDPData('Oceania',416),
      GDPData('Oceania',8956),

    ];
    return chartData;
  }



}
class GDPData{
  GDPData(this.continent,this.gdp);
  final String continent;
  final int gdp;
}