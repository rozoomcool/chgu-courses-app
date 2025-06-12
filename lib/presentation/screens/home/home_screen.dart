import 'package:auto_route/auto_route.dart';
import 'package:coursera/domain/state/course/course_bloc.dart';
import 'package:coursera/presentation/widgets/course_info_card.dart';
import 'package:coursera/utils/app_colors.dart';
import 'package:coursera/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      child: BlocConsumer<CourseBloc, CourseState>(
          builder: (context, state) {
            if (state is CourseLoaded) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: AnimatedList(
                    shrinkWrap: true,
                    initialItemCount: state.courses.length,
                    itemBuilder: (context, i, animation) {
                      final course = state.courses[i];
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: CourseInfoCard(
                            title: course.title,
                            description: course.description,
                            rating: 4,
                            peopleCount: 100,
                            imageUrl: "$uploadsUrl/${course.imageUrl}",
                            complexity: course.complexity),
                      );
                    }),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
          listener: (BuildContext context, CourseState state) {}),
    );
  }
}
