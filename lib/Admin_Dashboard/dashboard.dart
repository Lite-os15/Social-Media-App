
import 'package:Lets_Change/Admin_Dashboard/responsive.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(clipBehavior: Clip.none,
        padding: EdgeInsets.all(16),
        child: Column(

          children: [
            if(Responsive.isDesktop(context))
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(15)
                ),

                width: double.infinity,
                child: Row(
                  children: [
                    Text("Dashboard",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      ),
                    ),
                    Spacer(flex: 2,),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          filled: true,
                          fillColor: Colors.grey.shade100.withOpacity(0.8),

                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Colors.greenAccent,
                                    borderRadius: BorderRadius.circular(10)
                                ),

                                child: Icon(Icons.search)),
                          ),
                        ),
                      ),
                    ),


                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      padding: EdgeInsets.symmetric(vertical:5),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade300)
                      ),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            height: 40,width: 40,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text("Muncipal Corporation"),
                          ),
                        ],
                      ),
                    )


                  ],
                ),
              ),


            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Statics of the Area
                Expanded(

                  flex: 5,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.all(15),
                    height: 700,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 25.0, // soften the shadow
                            spreadRadius: 5.0, //extend the shadow
                            offset: Offset(
                              15.0, // Move to right 10  horizontally
                              15.0, // Move to bottom 10 Vertically
                            ),
                          )
                        ],
                        borderRadius: BorderRadius.circular(15)

                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: Text('Statistics',style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w500
                          ),),
                        ),
                        SizedBox(
                          height: 15,
                        ),


                        //No. of users in the Area

                        // Expanded(
                        //   child: GridView.builder(
                        //
                        //     shrinkWrap: true,
                        //       itemCount: 4,
                        //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        //           crossAxisCount: 4,crossAxisSpacing: 5
                        //       ),
                        //       itemBuilder: (context,index)=> Container(
                        //                   decoration: BoxDecoration(
                        //                     color: Colors.blue,
                        //                     borderRadius: BorderRadius.all(Radius.circular(15))
                        //                   ),
                        //                   height: 10,width: 100,
                        //                   child: ListTile(
                        //                     title: Text('User Communities'),
                        //                     trailing: Text("10"),
                        //                   )
                        //
                        //                 ),
                        //   ),
                        // ),

                        Responsive(
                          mobile: Communities_Stats(),
                          tablet: Communities_Stats(),
                          desktop: Communities_Stats()
                          ,),


                        //Line graph of issue solved overall
                        Expanded(
                          child: Container(
                            height: 500,
                            padding:EdgeInsets.all(20),

                            child: LineChart(

                                LineChartData(

                                    minX: 0,
                                    minY: 0,
                                    maxX: 11,
                                    maxY:10,
                                    titlesData: FlTitlesData(
                                        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                        bottomTitles: AxisTitles(

                                            sideTitles: SideTitles(
                                                reservedSize: 32,
                                                interval: 1,
                                                showTitles: true,
                                                getTitlesWidget: bottomTitleWidgets


                                            )
                                        )
                                    ),
                                    lineBarsData: [
                                      LineChartBarData(
                                          isCurved: true,
                                          spots: [
                                            FlSpot(0, 3),
                                            FlSpot(2.6, 2),
                                            FlSpot(4.9, 5),
                                            FlSpot(6.8, 2.5),
                                            FlSpot(8, 4),
                                            FlSpot(9.5, 3)
                                          ]
                                      ),
                                      LineChartBarData(
                                          isCurved: true,
                                          color: Colors.greenAccent,
                                          spots: [
                                            FlSpot(0, 1),
                                            FlSpot(2, 5),
                                            FlSpot(4, 4),
                                            FlSpot(6, 1),
                                            FlSpot(7, 6),
                                            FlSpot(9, 3)
                                          ]
                                      ),
                                      LineChartBarData(
                                          isCurved: true,
                                          color: Colors.red,
                                          spots: [
                                            FlSpot(1, 1),
                                            FlSpot(3, 2),
                                            FlSpot(5, 3),
                                            FlSpot(7, 4),
                                            FlSpot(9, 5),
                                            FlSpot(11, 6)
                                          ]
                                      ),
                                    ]


                                )
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                //No. of issue view in pie chart

                if(!Responsive.isMobile(context))
                  Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.all(16),
                        margin: EdgeInsets.all(15),
                        height: 500,
                        decoration: BoxDecoration(
                            color: Colors.greenAccent.shade200.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(15)

                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Problems',style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w500
                            ),),
                            Expanded(
                              child: SizedBox(
                                height: 200,
                                child: PieChart(
                                    PieChartData(
                                        startDegreeOffset: -90,
                                        sectionsSpace: 0,
                                        centerSpaceRadius: 70,
                                        sections: [
                                          PieChartSectionData(
                                              color: Colors.yellow,
                                              value: 45,
                                              radius: 20,
                                              showTitle: false
                                          ),
                                          PieChartSectionData(
                                              color: Colors.cyanAccent,
                                              value: 35,
                                              radius: 18,
                                              showTitle: false

                                          ),
                                          PieChartSectionData(
                                              color: Colors.indigo,
                                              value: 25,
                                              radius: 16,
                                              showTitle: false),
                                          PieChartSectionData(
                                              color: Colors.red,
                                              value: 15,
                                              radius: 14,
                                              showTitle: false),

                                        ]

                                    )
                                ),
                              ),
                            ),
                            ListTile(
                              leading: Icon(Icons.sync_problem),
                              horizontalTitleGap: 0,
                              title: Text('Total Issues'),
                              trailing: Text('10'),
                            ),

                          ],
                        ),
                      ))
              ],
            ),

            Container(
              alignment: Alignment.center,

              height: MediaQuery.of(context).size.height*0.65,
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 25.0, // soften the shadow
                    spreadRadius: 5.0, //extend the shadow
                    offset: Offset(
                      15.0, // Move to right 10  horizontally
                      15.0, // Move to bottom 10 Vertically
                    ),
                  )
                ],
              ),
              child: Row(

                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(15),
                          padding: EdgeInsets.all(15),
                          color: Colors.green,
                          height: MediaQuery.of(context).size.height*0.4,
                          width: MediaQuery.of(context).size.width*0.9,
                          child: AspectRatio(
                            aspectRatio: 1.7,
                            child: BarChart(
                              BarChartData(
                                gridData: FlGridData(
                                  show: false,
                                ),
                                titlesData: FlTitlesData(


                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                        reservedSize: 32,
                                        showTitles: true,
                                        getTitlesWidget: bottomBarChart

                                    ),

                                  ),

                                ),
                                borderData: FlBorderData(
                                  show: false,
                                ),
                                barGroups: [
                                  BarChartGroupData(
                                    x: 1,
                                    barRods: [
                                      BarChartRodData(
                                        toY: 5,
                                        color: Colors.blue,
                                      ),
                                      BarChartRodData(
                                        toY: 7,
                                        color: Colors.redAccent,
                                      ),
                                      BarChartRodData(
                                        toY: 4,
                                        color: Colors.orange,
                                      ),
                                    ],
                                  ),
                                  BarChartGroupData(
                                    x: 2,
                                    barRods: [
                                      BarChartRodData(
                                        toY: 3,
                                        color: Colors.blue,
                                      ),
                                      BarChartRodData(
                                        toY: 8,
                                        color: Colors.redAccent,
                                      ),
                                      BarChartRodData(
                                        toY: 5,
                                        color: Colors.orange,
                                      ),
                                    ],
                                  ),
                                  BarChartGroupData(
                                    x: 3,
                                    barRods: [
                                      BarChartRodData(
                                        toY: 6,
                                        color: Colors.blue,
                                      ),
                                      BarChartRodData(
                                        toY: 2,
                                        color: Colors.redAccent,
                                      ),
                                      BarChartRodData(
                                        toY: 7,
                                        color: Colors.orange,
                                      ),
                                    ],
                                  ),
                                  BarChartGroupData(
                                    x: 4,
                                    barRods: [
                                      BarChartRodData(
                                        toY: 9,
                                        color: Colors.blue,
                                      ),
                                      BarChartRodData(
                                        toY: 4,
                                        color: Colors.redAccent,
                                      ),
                                      BarChartRodData(
                                        toY: 6,
                                        color: Colors.orange,
                                      ),
                                    ],
                                  ),
                                  BarChartGroupData(
                                    x:5,
                                    barRods: [
                                      BarChartRodData(
                                        toY: 4,
                                        color: Colors.blue,
                                      ),
                                      BarChartRodData(
                                        toY: 5,
                                        color: Colors.redAccent,
                                      ),
                                      BarChartRodData(
                                        toY: 9,
                                        color: Colors.orange,
                                      ),
                                    ],
                                  ),
                                  BarChartGroupData(
                                    x: 6,
                                    barRods: [
                                      BarChartRodData(
                                        toY: 5,
                                        color: Colors.blue,
                                      ),
                                      BarChartRodData(
                                        toY: 7,
                                        color: Colors.redAccent,
                                      ),
                                      BarChartRodData(
                                        toY: 3,
                                        color: Colors.orange,
                                      ),
                                    ],
                                  ),
                                  BarChartGroupData(
                                    x: 7,
                                    barRods: [
                                      BarChartRodData(
                                        toY: 1,
                                        color: Colors.blue,
                                      ),
                                      BarChartRodData(
                                        toY: 7,
                                        color: Colors.redAccent,
                                      ),
                                      BarChartRodData(
                                        toY: 4,
                                        color: Colors.orange,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        if(Responsive.isMobile(context))

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Chip(
                                  backgroundColor: Colors.red,
                                  label: ListTile(
                                    leading: Text('Total Isuues'),
                                    trailing: Text('10'),
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Chip(
                                  backgroundColor: Colors.lightBlueAccent,
                                  label: ListTile(
                                    leading: Text('Completed'),
                                    trailing: Text('5'),
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Chip(
                                  backgroundColor: Colors.orangeAccent,
                                  label: ListTile(
                                    leading: Text('Pending'),
                                    trailing: Text('5'),
                                  ),
                                ),

                              ],
                            ),
                          )


                      ],
                    ),
                  ),
                  if(!Responsive.isMobile(context))
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.all(15),
                        padding: EdgeInsets.all(15),

                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.all(15),
                                padding: EdgeInsets.all(15),

                                decoration: BoxDecoration(
                                  color: Colors.blueGrey.shade100,
                                  borderRadius: BorderRadius.circular(15),
                                ),

                                child: ListTile(
                                  leading: Icon(
                                    Icons.warning,weight:6,color: Colors.red,
                                  ),
                                  title: Text('Toatal Issue'),
                                  // subtitle: Center(child: Text('25'),),
                                  trailing: Text('25'),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.all(15),
                                padding: EdgeInsets.all(15),

                                decoration: BoxDecoration(
                                  color: Colors.blueGrey.shade100,
                                  borderRadius: BorderRadius.circular(15),
                                ),

                                child: ListTile(
                                  leading: Icon(
                                    Icons.question_mark,weight:6,color: Colors.red.shade900,
                                  ),
                                  title: Text('Pending'),
                                  trailing: Text('25'),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.all(15),
                                padding: EdgeInsets.all(15),

                                decoration: BoxDecoration(
                                  color: Colors.blueGrey.shade100,
                                  borderRadius: BorderRadius.circular(15),
                                ),

                                child: ListTile(
                                  leading: Icon(
                                    Icons.check_outlined,weight:6,color: Colors.greenAccent,
                                  ),
                                  title: Text('Completed'),
                                  trailing: Text('25'),
                                ),
                              ),
                            )
                          ],
                        ),

                      ),
                    ),


                ],
              ),

            ),




          ],
        ),
      ),

    );
  }
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );

    final Map<int, String> dayMap = {
      1: 'Monday',
      3: 'Tuesday',
      5: 'Wednesday',
      7: 'Thursday',
      9: 'Friday',
    };

    final text = dayMap[value.toInt()] ?? ''; // Use the map to get the text or an empty string if not found

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: Text(
        text,
        style: style,
      ),
    );
  }


  Widget bottomBarChart(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );

    final Map<int, String> dayMap = {
      1: 'Monday',
      2: 'Tuesday',
      3: 'Wednesday',
      4: 'Thursday',
      5: 'Friday',
      6: 'Saturday',
      7: 'Sunday'
    };

    final text = dayMap[value.toInt()] ?? ''; // Use the map to get the text or an empty string if not found

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: Text(
        text,
        style: style,
      ),
    );
  }

}


class Communities_Stats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (context, constraints) {
        // Choose the layout based on screen width
        if (Responsive.isDesktop(context)) {
          // Mobile view with Row
          return buildRowView();
        } else {
          // Larger screens with GridView
          return buildGridView();
        }
      },
    );
  }

  Widget buildRowView() {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildItem("User Communities", "10", Colors.blue),
        buildItem("NGO", "10", Colors.greenAccent),
        buildItem("Municipal", "0", Colors.red),
        buildItem("Coming Soon!!!", "0", Colors.yellow),
      ],
    );
  }

  Widget buildGridView() {
    return
      Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Chip(
            label: ListTile(
              leading: Text('User Communities'),
              trailing: Text('5'),
            ),
          ),
          SizedBox(height: 5,),
          Chip(
            label: ListTile(
              leading: Text('NGO'),
              trailing: Text('5'),
            ),
          ),
          SizedBox(height: 5,),
          Chip(
            label: ListTile(
              leading: Text('Muncipal Corporation'),
              trailing: Text('5'),
            ),
          ),
          SizedBox(height: 5,),
          Chip(
            label: ListTile(
              leading: Text('Coming Soon!!!'),
              trailing: Text('5'),
            ),
          ),
        ],
      );
    //   GridView.count(
    // crossAxisCount: 2,
    //   // Number of columns
    //   children: [
    //     buildItem("User Communities", "10", Colors.blue),
    //     buildItem("NGO", "10", Colors.greenAccent),
    //     buildItem("Municipal", "0", Colors.red),
    //     buildItem("Coming Soon!!!", "0", Colors.yellow),
    //   ],
    // );
  }

  Widget buildItem(String title, String count, Color color) {

    return Expanded(
      child: Container(
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        height: 100 ,
        width: 200,
        child: ListTile(
          title: Text(title),
          trailing: Text(count),
        ),
      ),
    );
  }
}
