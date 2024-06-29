
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_app/core/constants/app_assets.dart';
import 'package:task_app/core/constants/app_colors.dart';
import 'package:task_app/core/constants/app_strings.dart';
import 'package:task_app/feature/auth/screens/on_boarding_screens.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  void navigate(){
    // bool isVisted = await sl<CacheHelper>().getData(
    //       key: AppStrings.onBoardingKey,
    //     ) ??
    //     false;
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => OnBoaringScreens()
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppAssets.logo),
          const SizedBox(height: 24),
          Text(
            AppStrings.appName,
            style: GoogleFonts.lato(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 40,
              
            )
          )
        ],
      )),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:gap/gap.dart';
// import 'package:task_app/views/login_page.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   @override
//   void initState() {
//     super.initState();
//     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//       statusBarColor: Colors.transparent,
//     ));

//     Future.delayed(const Duration(seconds: 2), () {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(
//           builder: (context) => LoginPage(),
//         ),
//       );
//     });
//   }

//   @override
//   void dispose() {
//     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//       statusBarColor: Colors.transparent,
//     ));
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Container(
//             height: 450,
//             width: double.infinity,
//             decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.only(bottomRight: Radius.circular(80)),
//             ),
//             child: Image.asset('assets/images/splach.jpg')),
//           Gap(10),
//           const Text(
//             'Cresola',
//             style: TextStyle(
//                 color: Color(0xff8144E5),
//                 fontSize: 90,
//                 fontFamily: 'Caveat',
//                 fontWeight: FontWeight.bold),
//           ),
//         ],
//       ),
//     );
//   }
// }