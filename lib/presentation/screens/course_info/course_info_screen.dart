import 'package:auto_route/annotations.dart';
import 'package:coursera/presentation/screens/course_info/bloc/course_info_bloc.dart';
import 'package:coursera/utils/app_colors.dart';
import 'package:coursera/utils/constants.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';

@RoutePage()
class CourseInfoScreen extends StatefulWidget {
  const CourseInfoScreen({super.key, required this.id});

  final int id;

  @override
  State<CourseInfoScreen> createState() => _CourseInfoScreenState();
}

class _CourseInfoScreenState extends State<CourseInfoScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CourseInfoBloc>().loadCourse(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseInfoBloc, CourseInfoState>(
        builder: (context, state) {
      return Scaffold(
        body: CustomMaterialIndicator(
          useMaterialContainer: false,
          // backgroundColor: Colors.transparent,
          // elevation: 0,
          indicatorBuilder: (context, controller) => LoadingAnimationWidget.staggeredDotsWave(color: AppColors.primaryColor, size: 32),
          onRefresh: () async {  },
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                foregroundColor: AppColors.backgroundColor,
                backgroundColor: AppColors.darkBackgroundColor,
                stretch: true,
                centerTitle: true,
                title: state is! CourseInfoLoadedState
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          width: 200,
                          height: 16,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.black),
                        ),
                      )
                    : Container(
                      padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadiusGeometry.circular(4),
                            color: AppColors.darkBackgroundColor),
                        child: Text(state.course.title,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(color: AppColors.backgroundColor)),
                      ),
                floating: true,
                pinned: true,
                expandedHeight: 164.0,
                flexibleSpace: FlexibleSpaceBar(
                  background: state is! CourseInfoLoadedState
                      ? const SizedBox()
                      : Image.network(
                          "$uploadsUrl/${state.course.imageUrl}",
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const SliverPadding(padding: EdgeInsetsGeometry.all(12)),
              SliverAnimatedList(
                  initialItemCount: 20,
                  itemBuilder: (context, i, animation) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 4),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: AppColors.surfaceColor,
                              borderRadius: BorderRadius.circular(12)),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Center(
                                  child: Text(
                                "$i",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              )),
                            ),
                            title: const Text("Html & Css begin"),
                            subtitle: const Text("Непройдено"),
                            trailing: const Icon(Iconsax.arrow_circle_right),
                          ),
                        ),
                      ))
            ],
          ),
        ),
      );
    });
  }
}
