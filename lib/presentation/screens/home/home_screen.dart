import 'package:auto_route/auto_route.dart';
import 'package:coursera/domain/state/course/course_bloc.dart';
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
    return BlocConsumer<CourseBloc, CourseState>(
        builder: (context, state) {
          if (state is CourseLoaded) {
            return AnimatedList(
                shrinkWrap: true,
                initialItemCount: state.courses.length,
                itemBuilder: (context, i, animation) {
                  return ListTile(
                    leading: state.courses[i].imageUrl == null
                        ? const CircleAvatar()
                        : CircleAvatar(
                            foregroundImage: NetworkImage(
                                "$baseUrl/uploads/${state.courses[i].imageUrl}"),
                          ),
                    title: Text(state.courses[i].title),
                    subtitle: Text(
                      state.courses[i].description,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                });
          } else {
            return CircularProgressIndicator();
          }
        },
        listener: (BuildContext context, CourseState state) {});
  }
}
