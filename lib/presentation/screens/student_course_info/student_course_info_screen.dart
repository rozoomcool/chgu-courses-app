import 'package:auto_route/auto_route.dart';
import 'package:coursera/presentation/screens/student_course_info/bloc/student_course_info_bloc.dart';
import 'package:coursera/router/app_router.dart';
import 'package:coursera/utils/app_colors.dart';
import 'package:coursera/utils/constants.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';

@RoutePage()
class StudentCourseInfoScreen extends StatefulWidget {
  const StudentCourseInfoScreen({super.key, required this.id});

  final int id;

  @override
  State<StudentCourseInfoScreen> createState() =>
      _StudentCourseInfoScreenState();
}

class _StudentCourseInfoScreenState extends State<StudentCourseInfoScreen> {
  void load() {
    context.read<StudentCourseInfoBloc>().loadCourse(widget.id);
  }

  @override
  void initState() {
    super.initState();
    load();
    context.router.addListener(() {
      load();
    });
  }

  @override
  void dispose() {
    if (mounted) {
      context.router.removeListener(() {});
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentCourseInfoBloc, StudentCourseInfoState>(
      builder: (context, state) {
        if (state is StudentCourseInfoLoadedState) {
          return Scaffold(
            body: CustomMaterialIndicator(
              useMaterialContainer: false,
              indicatorBuilder: (context, controller) =>
                  LoadingAnimationWidget.staggeredDotsWave(
                      color: AppColors.primaryColor, size: 32),
              onRefresh: () async {
                load();
              },
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    foregroundColor: AppColors.backgroundColor,
                    backgroundColor: AppColors.darkBackgroundColor,
                    stretch: true,
                    centerTitle: true,
                    title: Container(
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
                      background: Image.network(
                        "$uploadsUrl/${state.course.imageUrl}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SliverPadding(padding: EdgeInsetsGeometry.all(12)),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Text(
                        state.course.description,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SliverPadding(padding: EdgeInsetsGeometry.all(12)),
                  if (state.admission == null)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: ElevatedButton(
                            onPressed: () => context
                                .read<StudentCourseInfoBloc>()
                                .addAdmission(state.course.id),
                            child: Text("Поступить на курс",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                        color: AppColors.backgroundColor))),
                      ),
                    ),
                  const SliverPadding(padding: EdgeInsetsGeometry.all(12)),
                  if (state.course.lessons != null &&
                      state.course.lessons!.isNotEmpty)
                    SliverAnimatedList(
                        initialItemCount: state.course.lessons!.length,
                        itemBuilder: (context, i, animation) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 4),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: state.admission == null
                                    ? null
                                    : () => context.pushRoute(LessonInfoRoute(
                                        id: state.course.lessons![i].id)),
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      color: AppColors.surfaceColor,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      child: Center(
                                          child: Text(
                                        "${i + 1}",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                    title: Text(state.course.lessons![i].title),
                                    subtitle: const Text("Непройдено"),
                                    trailing: state.admission == null
                                        ? IconButton(
                                            icon: Icon(Iconsax.lock),
                                            onPressed: null,
                                          )
                                        : SizedBox(),
                                  ),
                                ),
                              ),
                            )),
                  const SliverPadding(padding: EdgeInsetsGeometry.all(56)),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  foregroundColor: AppColors.backgroundColor,
                  backgroundColor: AppColors.darkBackgroundColor,
                  stretch: true,
                  centerTitle: true,
                  title: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      width: 200,
                      height: 16,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.black),
                    ),
                  ),
                  floating: true,
                  pinned: true,
                  expandedHeight: 164.0,
                  flexibleSpace: FlexibleSpaceBar(
                    background: const SizedBox(),
                  ),
                ),
                const SliverPadding(padding: EdgeInsetsGeometry.all(12)),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: 200,
                        height: 16,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.black),
                      ),
                    ),
                  ),
                ),
                const SliverPadding(padding: EdgeInsetsGeometry.all(4)),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 64.0),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        width: 164,
                        height: 16,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.black),
                      ),
                    ),
                  ),
                ),
                const SliverPadding(padding: EdgeInsetsGeometry.all(12)),
                SliverList.builder(
                    itemCount: 20,
                    itemBuilder: (context, i) => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 4),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: AppColors.surfaceColor,
                                borderRadius: BorderRadius.circular(12)),
                            child: ListTile(
                              leading: Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  width: 52,
                                  height: 52,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Colors.black),
                                ),
                              ),
                              title: Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  width: 200,
                                  height: 16,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: Colors.black),
                                ),
                              ),
                              subtitle: SizedBox(
                                width: 50,
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                    width: 100,
                                    height: 14,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.black),
                                  ),
                                ),
                              ),
                              trailing: Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ))
              ],
            ),
          );
        }
      },
      listener: (BuildContext context, StudentCourseInfoState state) {
        if (state is StudentCourseInfoErrorState) {
          load();
        }
      },
    );
  }
}
