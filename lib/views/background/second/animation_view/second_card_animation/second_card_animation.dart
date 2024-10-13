// ignore_for_file: must_be_immutable

import 'dart:math';
import 'dart:ui';

import 'package:job_finder_flutter/Utils/number.dart';
import 'package:job_finder_flutter/constants/app_sizes.dart';
import 'package:job_finder_flutter/views/common/job_card/job_card.dart';
import 'package:flutter/material.dart';

import '../../../../../models/job_data.dart';

List<JobData> appColors = [
  JobData(jobTitle: "Flutter Developer", id: 1, shiftType: "Full-Time", description: "As a Flutter Developer, you will be in charge of reviewing the software specifications and UI mockups, developing a cross-browser mobile application from scratch, and leading the application testing effort. You'll work alongside a backend developer, as well as a UI designer to ensure you create high-performing application with a a smooth user experience.", salary: "140k+", reviews: "60", jobPoster: "Chetan Vaghela", increaseText: "Increase Every Six Month",company: "Google INC."),
  JobData(jobTitle: "Android Developer", id: 2, shiftType: "Part-Time", description: "As a Flutter Developer, you will be in charge of reviewing the software specifications and UI mockups, developing a cross-browser mobile application from scratch, and leading the application testing effort. You'll work alongside a backend developer, as well as a UI designer to ensure you create high-performing application with a a smooth user experience.", salary: "200k+", reviews: "76", jobPoster: "Rohit Vaghela", increaseText: "Increase Every Three Month",company: "Meta INC."),
  JobData(jobTitle: "Senior Mobile Developer", id: 3, shiftType: "Full-Time", description: "As a Flutter Developer, you will be in charge of reviewing the software specifications and UI mockups, developing a cross-browser mobile application from scratch, and leading the application testing effort. You'll work alongside a backend developer, as well as a UI designer to ensure you create high-performing application with a a smooth user experience.", salary: "60k-70k", reviews: "82", jobPoster: "Manisha Vaghela", increaseText: "Increase Every Six Month",company: "Oracle INC."),
  JobData(jobTitle: "DevOps Developer", id: 4, shiftType: "Part-Time", description: "As a Flutter Developer, you will be in charge of reviewing the software specifications and UI mockups, developing a cross-browser mobile application from scratch, and leading the application testing effort. You'll work alongside a backend developer, as well as a UI designer to ensure you create high-performing application with a a smooth user experience.", salary: "60k-90k", reviews: "77", jobPoster: "Abc Def", increaseText: "Increase Every Three Month",company: "Microsoft INC."),
  JobData(jobTitle: "Data Engineer", id: 5, shiftType: "Contract", description: "As a Flutter Developer, you will be in charge of reviewing the software specifications and UI mockups, developing a cross-browser mobile application from scratch, and leading the application testing effort. You'll work alongside a backend developer, as well as a UI designer to ensure you create high-performing application with a a smooth user experience.", salary: "80k-90k", reviews: "99", jobPoster: "John Doe", increaseText: "Increase Every Six Month",company: "NASA INC."),
  JobData(jobTitle: "IOS developer", id: 6, shiftType: "Contract", description: "As a Flutter Developer, you will be in charge of reviewing the software specifications and UI mockups, developing a cross-browser mobile application from scratch, and leading the application testing effort. You'll work alongside a backend developer, as well as a UI designer to ensure you create high-performing application with a a smooth user experience.", salary: "120k+", reviews: "140", jobPoster: "Peter Wilson", increaseText: "Increase Every Six Month",company: "LinkedIn INC."),
  JobData(jobTitle: "Backend Developer", id: 7, shiftType: "Full-Time", description: "As a Flutter Developer, you will be in charge of reviewing the software specifications and UI mockups, developing a cross-browser mobile application from scratch, and leading the application testing effort. You'll work alongside a backend developer, as well as a UI designer to ensure you create high-performing application with a a smooth user experience.", salary: "20k-40k", reviews: "123", jobPoster: "Chetan Vaghela", increaseText: "Increase Every Three Month",company: "Swiggy Foods."),
];

class SecondCardAnimation extends StatefulWidget {
  AnimationController appearAnimationController;
  AnimationController disappearAnimationController;
  int heroTagDiff;
  SecondCardAnimation(
      {super.key,
      required this.appearAnimationController,
      required this.disappearAnimationController,
      required this.heroTagDiff});

  @override
  State<SecondCardAnimation> createState() => _SecondCardAnimationState();
}

class _SecondCardAnimationState extends State<SecondCardAnimation> {
  List<JobData> colors = [...appColors];
  final List<Animation<double>> _appearAnimations = [];
  final List<Animation<double>> _disappearAnimations = [];
  @override
  void initState() {
    super.initState();
    _setupAnimation();
  }

  _setupAnimation() {
    for (int i = 0; i < colors.length; i++) {
      double ratio = 1 / colors.length;
      double start = i * (ratio / 5);
      double end = (i + 1) * ratio;
      int reversedIndex = colors.length - i - 1;
      end = 1 - (reversedIndex * ratio / 5);
      Curve curve = Interval(start, end, curve: Curves.easeOut);
      Tween<double> tween = Tween<double>(begin: 0, end: 1);
      Animation<double> appearAnimation = tween.animate(CurvedAnimation(
          parent: widget.appearAnimationController, curve: curve));
      Animation<double> disappearAnimation = tween.animate(CurvedAnimation(
          parent: widget.disappearAnimationController, curve: curve));
      _appearAnimations.add(appearAnimation);
      _disappearAnimations.add(disappearAnimation);
    }
  }

  @override
  Widget build(BuildContext context) {
    AppSizes size = AppSizes(context);
    return AnimatedBuilder(
      animation: widget.disappearAnimationController,
      builder: (context, child) {
        return AnimatedBuilder(
          animation: widget.appearAnimationController,
          builder: (context, child) {
            return Stack(
              children: List.generate(colors.length, (index) {
                double sigma = index == 0 ? 0 : 5.0;
                return Opacity(
                  opacity: _appearAnimations[index].value,
                  child: Container(
                    transformAlignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, .001)
                      ..scale(_appearAnimations[index].value)
                      ..translate(
                          (_disappearAnimations[index].value * 300),
                          (index * size.HEIGHT * .08),
                          (getReverse(_disappearAnimations[index].value) * 40))
                      ..rotateY((pi * .5) * _disappearAnimations[index].value)
                      ..rotateX((-pi * .1) * _disappearAnimations[index].value),
                    child: Stack(
                      children: [
                        JobCard(
                          id: index + widget.heroTagDiff,
                          isRecentView: true,
                          jobData: appColors[index],
                        ),
                        Positioned.fill(
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40)),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                  sigmaX: sigma, sigmaY: sigma),
                              child: const SizedBox(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).reversed.toList(),
            );
          },
        );
      },
    );
  }
}
