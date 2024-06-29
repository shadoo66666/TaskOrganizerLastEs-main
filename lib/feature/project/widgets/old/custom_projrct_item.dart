// import 'package:flutter/material.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';
// import 'package:task_app/feature/project/screens/edit_project_view.dart';


// class ProjectItem extends StatelessWidget {
//   const ProjectItem({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) {
//             return const EditProjectView();
//           }),
//         );
//       },
//       child: Container(
//         padding: const EdgeInsets.only(top: 24, bottom: 24),
//         decoration: BoxDecoration(
//           color: const Color.fromARGB(255, 199, 168, 200),
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             ListTile(
//                 title: const Text('App project',
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold)),
//                 subtitle: Padding(
//                   padding: const EdgeInsets.only(top: 16, bottom: 16),
//                   child: Text(
//                     'Description of the app project',
//                     style: TextStyle(
//                       color: Colors.black.withOpacity(0.5),
//                       fontSize: 18,
//                     ),
//                   ),
//                 )),
//                 Row(
//                children: [
//                 const Padding(
//                   padding: EdgeInsets.only(left: 18),
//                   child: Icon(
//                     color: Color.fromARGB(255, 69, 12, 79),
//                     Icons.date_range),
//                 ) ,
//                  Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Text(
//                     '28 March, at 11:30 am',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.black.withOpacity(0.5),
//                     ),
//                   ),
//                              ),
//                ],
//              ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: CircularPercentIndicator(
//                 // Add CircularPercentIndicator
//                 radius: 50,
//                 lineWidth: 10,
//                 percent: 0.5, // Set the percentage as per your requirement
//                 center: const Text(
//                   '50%',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 progressColor: const Color.fromARGB(255, 52, 25, 69),
//               ),
//              ),
//             // Text('may21 , 2022',
//             //     style: TextStyle(
//             //       color: Colors.black.withOpacity(0.5),
//             //     )),
//           ],
//         ),
//       ),
//     );
//   }
// }
