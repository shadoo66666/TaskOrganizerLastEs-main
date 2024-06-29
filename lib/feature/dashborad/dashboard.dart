import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:task_app/core/constants/app_colors.dart';
import 'package:task_app/widget/common/custom_bottom_navigation_bar.dart';



class TheDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Dashboard(),
    );
  }
}

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.primary,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 40, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.sort,
                            color: Colors.black,
                            size: 20,
                          ),
                        ),              
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10,
                      left: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Dashboard",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 0),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 2,
                          mainAxisSpacing: 0.5,
                        ),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          Color backgroundColor;
                          String statusText;
                          int value = 0;
                          switch (index) {
                            case 0:
                              backgroundColor = Colors.blue;
                              statusText = "In Progress";
                              value = 6;
                              break;
                            case 1:
                              backgroundColor = Colors.pink;
                              statusText = "In Review";
                              value = 8;
                              break;
                            case 2:
                              backgroundColor =
                                  Color.fromARGB(255, 118, 107, 3);
                              statusText = "On Hold";
                              value = 10;
                              break;
                            case 3:
                              backgroundColor =
                                  const Color.fromARGB(255, 7, 177, 13);
                              statusText = "Completed";
                              value =15;
                              break;
                            default:
                              backgroundColor = Colors.grey;
                              statusText = "Unknown";
                          }
                          return InkWell(
                            onTap: () {},
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: backgroundColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                  )
                                ],
                              ),
                              child: Stack(
                                children: [
                                  Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          statusText,
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          '$value',
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Icon(
                                      Icons.more_horiz,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    _buildPieChart(context),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Monthly Progress',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              '80%',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Total Working Hours',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              '160',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
bottomNavigationBar: const CustomBottomNavigationBar(),

    );
  }

  Widget _buildPieChart(BuildContext context) {
    Map<String, int> taskData = {
      "In Progress": 6,
      "In Review": 8,
      "On Hold": 10,
      "Completed": 15,
    };

    List<PieChartSectionData> sections = [];

    taskData.forEach((category, count) {
      sections.add(PieChartSectionData(
        color: getCategoryColor(category),
        value: count.toDouble(),
        title: count.toString(),
        radius: 80,
        titleStyle: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ));
    });

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AnotherPage()),
        );
      },
      child: Container(
        height: 250,
        padding: EdgeInsets.all(16),
        child: PieChart(
          PieChartData(
            sections: sections,
            borderData: FlBorderData(show: false),
            centerSpaceRadius: 30,
            sectionsSpace: 0,
          ),
        ),
      ),
    );
  }

  Color getCategoryColor(String category) {
    switch (category) {
      case "In Progress":
        return Colors.blue;
      case "In Review":
        return Colors.pink;
      case "On Hold":
        return Color.fromARGB(255, 118, 107, 3);
      case "Completed":
        return Color.fromARGB(255, 7, 177, 13);
      default:
        return Colors.grey;
    }
  }
}

class AnotherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Another Page'),
      ),
      body: Center(
        child: Text('This is another page.'),
      ),
    );
  }
}
