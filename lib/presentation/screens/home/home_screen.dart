import 'package:auto_route/auto_route.dart';
import 'package:coursera/domain/state/course/course_bloc.dart';
import 'package:coursera/presentation/widgets/course_info_card.dart';
import 'package:coursera/router/app_router.dart';
import 'package:coursera/utils/app_colors.dart';
import 'package:coursera/utils/constants.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.surfaceColor,
      child: CustomMaterialIndicator(
        useMaterialContainer: false,
        indicatorBuilder: (context, controller) =>
            LoadingAnimationWidget.staggeredDotsWave(
                color: AppColors.primaryColor, size: 32),
        onRefresh: () async {
          context.read<CourseBloc>().loadCourses();
        },
        child: BlocConsumer<CourseBloc, CourseState>(
            builder: (context, state) {
              if (state is CourseLoaded) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 16,
                        ),
                        AnimatedList(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            initialItemCount: state.courses.length,
                            itemBuilder: (context, i, animation) {
                              final course = state.courses[i];
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: CourseInfoCard(
                                    onTap: () {
                                      context.pushRoute(
                                          StudentCourseInfoRoute(id: course.id));
                                    },
                                    title: course.title,
                                    description: course.description,
                                    rating: 4,
                                    peopleCount: 100,
                                    imageUrl: "$uploadsUrl/${course.imageUrl}",
                                    complexity: course.complexity),
                              );
                            }),
                        SizedBox(
                          height: 16,
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return CircularProgressIndicator();
              }
            },
            listener: (BuildContext context, CourseState state) {}),
      ),
    );
  }
}
