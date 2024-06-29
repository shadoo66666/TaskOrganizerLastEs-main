// import 'package:flutter/material.dart';
// import 'package:task_app/feature/project/screens/old/add_new_project.dart';

// import 'package:task_app/widget/common/custom_bottom_navigation_bar.dart';
// import 'package:task_app/feature/project/widgets/old/projects_view_body.dart';

// class ProjectsView extends StatelessWidget {
//   const ProjectsView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade900,
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       bottomNavigationBar: const CustomBottomNavigationBar(),
//       floatingActionButton: FloatingActionButton.extended(

//         onPressed: () {
//           showModalBottomSheet(
//             context: context,
//             builder: (context) {
//               return const AddbtnSheett();
//             },
//           );
//         },
//         label: const Text('New Project'),
//         icon: const Icon(Icons.add),
//       ),
//       body: const ProjectsViewBody(),

//     );
//   }
// }
