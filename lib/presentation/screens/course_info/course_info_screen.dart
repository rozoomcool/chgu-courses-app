import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:coursera/presentation/screens/course_info/bloc/course_info_bloc.dart';
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
class CourseInfoScreen extends StatefulWidget {
  const CourseInfoScreen({super.key, required this.id});

  final int id;

  @override
  State<CourseInfoScreen> createState() => _CourseInfoScreenState();
}

class _CourseInfoScreenState extends State<CourseInfoScreen> {
  void load() {
    context.read<CourseInfoBloc>().loadCourse(widget.id);
  }

  void onNavHistUpdate() => load();

  void onLongPressCard(int lessonId) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Iconsax.trash,
                  size: 64,
                  color: Colors.redAccent.shade400,
                ),
                SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade700),
                    onPressed: () {
                      context.read<CourseInfoBloc>().deleteLesson(
                          courseId: widget.id, lessonId: lessonId);
                      context.pop();
                    },
                    child: Text(
                      "Удалить урок?",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: AppColors.backgroundColor),
                    ))
              ],
            ),
          ));
        });
  }

  @override
  void initState() {
    super.initState();
    load();
    context.router.addListener(onNavHistUpdate);
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
    return BlocBuilder<CourseInfoBloc, CourseInfoState>(
        builder: (context, state) {
      if (state is CourseInfoLoadedState) {
        return Scaffold(
          floatingActionButton: state.isOwner
              ? Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  spacing: 12,
                  children: [
                    FloatingActionButton(
                      heroTag: "one",
                      onPressed: () => context.pushRoute(
                          CreateLessonRoute(courseId: state.course.id)),
                      child: const Icon(Iconsax.add),
                    ),
                    FloatingActionButton(
                      heroTag: "two",
                      onPressed: () => context
                          .pushRoute(CreateCourseRoute(id: state.course.id)),
                      child: const Icon(Iconsax.edit),
                    ),
                  ],
                )
              : const SizedBox.shrink(),
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
                if (state.course.lessons != null &&
                    state.course.lessons!.isNotEmpty)
                  SliverAnimatedList(
                      initialItemCount: state.course.lessons!.length,
                      itemBuilder: (context, i, animation) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 4),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () => context.pushRoute(LessonInfoRoute(
                                  id: state.course.lessons![i].id)),
                              onLongPress: () =>
                                  onLongPressCard(state.course.lessons![i].id),
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
                                  trailing: IconButton(
                                    icon: Icon(Iconsax.edit),
                                    onPressed: () {
                                      context.pushRoute(CreateLessonRoute(
                                          id: state.course.lessons![i].id,
                                          courseId: widget.id));
                                    },
                                  ),
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
    });
  }
}
