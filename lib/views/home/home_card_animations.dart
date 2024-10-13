// ignore_for_file: must_be_immutable

import 'package:job_finder_flutter/constants/app_colors.dart';
import 'package:job_finder_flutter/constants/app_sizes.dart';
import 'package:job_finder_flutter/views/home/card_item.dart';
import 'package:job_finder_flutter/views/job_detail/job_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/job_data.dart';

List<JobData> appColors = [
  JobData(jobTitle: "Flutter Developer", id: 1, shiftType: "Full-Time", description: "As a Flutter Developer, you will be in charge of reviewing the software specifications and UI mockups, developing a cross-browser mobile application from scratch, and leading the application testing effort. You'll work alongside a backend developer, as well as a UI designer to ensure you create high-performing application with a a smooth user experience.", salary: "140k+", reviews: "60", jobPoster: "Chetan Vaghela", increaseText: "Increase Every Six Month",company: "Google INC."),
  JobData(jobTitle: "Android Developer", id: 2, shiftType: "Part-Time", description: "As a Flutter Developer, you will be in charge of reviewing the software specifications and UI mockups, developing a cross-browser mobile application from scratch, and leading the application testing effort. You'll work alongside a backend developer, as well as a UI designer to ensure you create high-performing application with a a smooth user experience.", salary: "200k+", reviews: "76", jobPoster: "Rohit Vaghela", increaseText: "Increase Every Three Month",company: "Meta INC."),
  JobData(jobTitle: "Senior Mobile Developer", id: 3, shiftType: "Full-Time", description: "As a Flutter Developer, you will be in charge of reviewing the software specifications and UI mockups, developing a cross-browser mobile application from scratch, and leading the application testing effort. You'll work alongside a backend developer, as well as a UI designer to ensure you create high-performing application with a a smooth user experience.", salary: "60k-70k", reviews: "82", jobPoster: "Manisha Vaghela", increaseText: "Increase Every Six Month",company: "Oracle INC."),
  JobData(jobTitle: "DevOps Developer", id: 4, shiftType: "Part-Time", description: "As a Flutter Developer, you will be in charge of reviewing the software specifications and UI mockups, developing a cross-browser mobile application from scratch, and leading the application testing effort. You'll work alongside a backend developer, as well as a UI designer to ensure you create high-performing application with a a smooth user experience.", salary: "60k-90k", reviews: "77", jobPoster: "Abc Def", increaseText: "Increase Every Three Month",company: "Microsoft INC."),
  JobData(jobTitle: "Data Engineer", id: 5, shiftType: "Contract", description: "As a Flutter Developer, you will be in charge of reviewing the software specifications and UI mockups, developing a cross-browser mobile application from scratch, and leading the application testing effort. You'll work alongside a backend developer, as well as a UI designer to ensure you create high-performing application with a a smooth user experience.", salary: "80k-90k", reviews: "99", jobPoster: "John Doe", increaseText: "Increase Every Six Month",company: "NASA INC."),
  JobData(jobTitle: "IOS developer", id: 6, shiftType: "Contract", description: "As a Flutter Developer, you will be in charge of reviewing the software specifications and UI mockups, developing a cross-browser mobile application from scratch, and leading the application testing effort. You'll work alongside a backend developer, as well as a UI designer to ensure you create high-performing application with a a smooth user experience.", salary: "120k+", reviews: "140", jobPoster: "Peter Wilson", increaseText: "Increase Every Six Month",company: "LinkedIn INC."),
  JobData(jobTitle: "Backend Developer", id: 7, shiftType: "Full-Time", description: "As a Flutter Developer, you will be in charge of reviewing the software specifications and UI mockups, developing a cross-browser mobile application from scratch, and leading the application testing effort. You'll work alongside a backend developer, as well as a UI designer to ensure you create high-performing application with a a smooth user experience.", salary: "20k-40k", reviews: "123", jobPoster: "Chetan Vaghela", increaseText: "Increase Every Three Month",company: "Swiggy Foods."),
];

class HomeCardAnimations extends StatefulWidget {
  AnimationController backgroundAnimationController;
  AnimationController controller;
  HomeCardAnimations(
      {super.key,
      required this.backgroundAnimationController,
      required this.controller});

  @override
  State<HomeCardAnimations> createState() => _HomeCardAnimationsState();
}

class _HomeCardAnimationsState extends State<HomeCardAnimations> {
  late Animation<Offset> _offsetAnimations;
  late Animation<double> _opacityAnimations;
  late Animation<double> _scaleAnimations;
  List<JobData> colors = [];
  List<JobData> displayed = [];

  @override
  void initState() {
    super.initState();
    colors = [...appColors];
    displayed = [appColors[0]];
    _setupAnimations();
  }

  void _setupAnimations() {
    for (int i = 0; i < colors.length; i++) {
      double ratio = 1 / colors.length;
      double delayStart = (i.toDouble() * (ratio / 2));
      double delayEnd = .5 + (i * (.5 / colors.length));
      var curve = CurvedAnimation(
        parent: widget.controller,
        curve: Interval(delayStart, delayEnd, curve: Curves.easeOut),
      );
      _offsetAnimations = Tween<Offset>(
        begin: Offset.zero,
        end: const Offset(.8, 0.0),
      ).animate(curve);
      _opacityAnimations = Tween<double>(
        begin: 1,
        end: 0,
      ).animate(curve);
      _scaleAnimations = Tween<double>(
        begin: 1,
        end: .4,
      ).animate(curve);
    }
  }

  _changeCurrentColor(JobData color) {
    setState(() {
      colors.remove(color);
    });
  }

  _scaleNext(JobData color) {
    int index = colors.indexOf(color);
    if (colors.elementAtOrNull(index + 1) != null) {
      setState(() {
        displayed.add(colors[index + 1]);
      });
    }
  }

  _restartAnimation() {
    setState(() {
      colors = [...appColors];
      displayed = [colors[0]];
    });
  }

  _goToDetail(int id, JobData jobData) {
    widget.backgroundAnimationController
        .reverse()
        .then((value) => Navigator.of(context)
                .push(PageRouteBuilder(
                    pageBuilder: ((context, animation, secondaryAnimation) {
                      return JobDetail(id: id,jobData: jobData,);
                    }),
                    transitionDuration: const Duration(milliseconds: 600)))
                .then((value) {
              widget.backgroundAnimationController.forward();
            }));
  }

  @override
  Widget build(BuildContext context) {
    AppSizes size = AppSizes(context);
    TextTheme theme = Theme.of(context).textTheme;
    return AnimatedBuilder(
        animation: widget.controller,
        builder: (context, child) {
          return FractionalTranslation(
            translation: _offsetAnimations.value,
            child: Transform.scale(
              scale: _scaleAnimations.value,
              child: Opacity(opacity: _opacityAnimations.value, child: child),
            ),
          );
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: size.HEIGHT * .65,
              width: size.WIDTH * .8,
              child: GestureDetector(
                onTap: () {
                  _restartAnimation();
                },
                child: Center(
                  child: Container(
                      padding: EdgeInsets.all(size.CONTENT_SPACE * 2),
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(20)),
                      child: Icon(
                        CupertinoIcons.refresh,
                        color: AppColors.dark,
                        size: theme.headlineLarge!.fontSize,
                      )),
                ),
              ),
            ),
            ...colors.reversed.toList().asMap().entries.map((e) {
              int index = colors.length - e.key - 1;
              return CardItem(
                color: colors[index],
                index: index,
                isDisplayed: displayed.contains(colors[index]),
                onCardSwipped: _scaleNext,
                onTapCallback: () {
                  _goToDetail(index,colors[index]);
                },
                onCardSwipAnimationComplete: _changeCurrentColor,
              );
            }).toList()
          ],
        ));
  }
}
