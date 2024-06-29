
import 'package:task_app/core/constants/app_assets.dart';
import 'package:task_app/core/constants/app_strings.dart';

class OnBoardingModel {
  final String imgpath;
  final String title;
  final String subtitle;

  OnBoardingModel(
      {required this.imgpath, required this.title, required this.subtitle});
  static List<OnBoardingModel> OnBoardingScreens = [
    OnBoardingModel(
        imgpath: AppAssets.on1,
        title: AppStrings.onBoardingTitleOne,
        subtitle: AppStrings.onBoardingSubTitleOne),
    OnBoardingModel(
        imgpath: AppAssets.on2,
        title: AppStrings.onBoardingTitleTwo,
        subtitle: AppStrings.onBoardingSubTitleTwo),
    OnBoardingModel(
        imgpath: AppAssets.on3,
        title: AppStrings.onBoardingTitleThree,
        subtitle: AppStrings.onBoardingSubTitleThree)
  ];
}
