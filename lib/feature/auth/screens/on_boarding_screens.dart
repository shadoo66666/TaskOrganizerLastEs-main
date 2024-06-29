import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:task_app/core/constants/app_colors.dart';
import 'package:task_app/core/constants/app_strings.dart';
import 'package:task_app/feature/auth/model/on_boarding_model.dart';
import 'package:task_app/views/home_screen.dart';
import 'package:task_app/feature/auth/screens/signUp.dart';

class OnBoaringScreens extends StatelessWidget {
  OnBoaringScreens({super.key});
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: PageView.builder(
            controller: controller,
            itemCount: OnBoardingModel.OnBoardingScreens.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  index != 2
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            child: Text(AppStrings.skip,
                                style: GoogleFonts.lato(
                                  color: AppColors.white.withOpacity(0.44), // Corrected opacity value
                                  fontSize: 16,
                                )),
                            onPressed: () {
                              controller.jumpToPage(2);
                            },
                          ),
                        )
                      : SizedBox(
                          height: 50,
                        ),
                  SizedBox(height: 16),
                  Image.asset(OnBoardingModel.OnBoardingScreens[index].imgpath),
                  SizedBox(height: 16),
                  //dots
                  SmoothPageIndicator(
                    controller: controller,
                    count: 3,
                    effect: const ExpandingDotsEffect(
                        activeDotColor: AppColors.primary,
                        dotHeight: 10,
                        spacing: 8
                        // dotWidth: 10
                        ),
                  ),
                  const SizedBox(
                    height: 52,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          //Title
                          Text(OnBoardingModel.OnBoardingScreens[index].title,
                              style: GoogleFonts.lato(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 32,
                              )),
                          SizedBox(height: 18),
                          //SubTitle
                          Text(OnBoardingModel.OnBoardingScreens[index].subtitle,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lato(
                                color: AppColors.white,
                                fontSize: 16,
                              )),
                          SizedBox(height: 60),
                          //Buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //backbutton
                              index != 0
                                  ? TextButton(
                                      child: Text(AppStrings.back,
                                          style: GoogleFonts.lato(
                                            color: AppColors.white.withOpacity(0.44), // Corrected opacity value
                                            fontSize: 16,
                                          )),
                                      onPressed: () {
                                        controller.previousPage(
                                            duration: Duration(milliseconds: 1000),
                                            curve: Curves.fastLinearToSlowEaseIn);
                                      },
                                    )
                                  : Container(),
                              Spacer(),
                              //nextbutton
                              index != 2
                                  ? ElevatedButton(
                                      onPressed: () {
                                        controller.nextPage(
                                            duration: Duration(milliseconds: 1000),
                                            curve: Curves.fastLinearToSlowEaseIn);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.primary,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(4),
                                          )),
                                      child: Text(
                                        AppStrings.next,
                                        style: GoogleFonts.lato(
                                          color: Color.fromARGB(255, 66, 64, 64), // Text color set to gray
                                        ),
                                      ),
                                    )
                                  : ElevatedButton(
                                      onPressed: () {
                                        //navigate to home screen
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => SignUpPage()));
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.primary,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(4),
                                          )),
                                      child: Text(
                                        AppStrings.getStarted,
                                        style: GoogleFonts.lato(
                                          color: Color.fromARGB(255, 66, 64, 64), // Text color set to gray
                                        ),
                                      ),
                                    )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
