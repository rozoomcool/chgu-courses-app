import 'package:auto_route/auto_route.dart';
import 'package:coursera/domain/model/course/course.dart';
import 'package:coursera/presentation/screens/profile/bloc/profile_screen_bloc.dart';
import 'package:coursera/presentation/widgets/course_info_card.dart';
import 'package:coursera/presentation/widgets/course_info_shimmer_card.dart';
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
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final IndicatorController _indicatorController = IndicatorController();
  final GlobalKey<AnimatedListState> _animatedListKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    context.read<ProfileScreenBloc>().loadData();
    context.router.navigationHistory.addListener(() {
      context.read<ProfileScreenBloc>().loadData();
    });
  }

  @override
  void dispose() {
    _indicatorController.dispose();
    context.router.navigationHistory.removeListener(() {});
    super.dispose();
  }

  Future<void> _animateList(int count) async {
    for (int i = 0; i < count; i++) {
      if (i < 5) {
        await Future.delayed(const Duration(milliseconds: 150));
      }
      _animatedListKey.currentState
          ?.insertItem(i, duration: const Duration(milliseconds: 300));
    }
  }

  Future<void> _deleteCourse(Course course, int index) async {
    context.read<ProfileScreenBloc>().deleteCourse(course.id, () {
      _animatedListKey.currentState?.removeItem(
          index,
          (context, anim) => SlideTransition(
              position: Tween<Offset>(
                      begin: const Offset(-1, 0), end: const Offset(0, 0))
                  .animate(CurvedAnimation(
                      parent: anim,
                      curve: Curves.easeIn,
                      reverseCurve: Curves.easeInBack)),
              child: CourseInfoCard(
                title: course.title,
                description: course.description,
                imageUrl: "$uploadsUrl/${course.imageUrl}",
                rating: 4.9,
                peopleCount: 136,
                onTap: () async =>
                    await context.pushRoute(CourseInfoRoute(id: course.id)),
                onDelete: () => _deleteCourse(course, index),
              )),
          duration: const Duration(milliseconds: 300));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileScreenBloc, ProfileScreenState>(
      builder: (context, state) {
        return CustomMaterialIndicator(
          useMaterialContainer: false,
          indicatorBuilder: (context, controller) {
            return LoadingAnimationWidget.stretchedDots(
                color: AppColors.primaryColor, size: 32);
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          onRefresh: () async {
            context.read<ProfileScreenBloc>().loadData();
          },
          child: ListView(
            children: [
              ColoredBox(
                color: AppColors.surfaceColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      color: AppColors.backgroundColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 24),
                      child: Row(
                        children: [
                          state is! ProfileScreenLoadedState
                              ? Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: const CircleAvatar(
                                    radius: 32,
                                    // backgroundColor: Colors.black,
                                  ),
                                )
                              : const CircleAvatar(
                                  radius: 32,
                                  backgroundColor: Colors.black,
                                ),
                          const SizedBox(
                            width: 16,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              state is! ProfileScreenLoadedState
                                  ? SizedBox(
                                      width: 200,
                                      height: 20,
                                      child: Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: Container(
                                          width: 200,
                                          height: 16,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              color: Colors.black),
                                        ),
                                      ),
                                    )
                                  : Text(
                                      "пока нет",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                              const SizedBox(
                                height: 4,
                              ),
                              state is! ProfileScreenLoadedState
                                  ? SizedBox(
                                      width: 180,
                                      height: 18,
                                      child: Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: Container(
                                          width: 200,
                                          height: 20,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              color: Colors.black),
                                        ),
                                      ),
                                    )
                                  : Text(
                                      state.user.email,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 24,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Мои Курсы",
                                style: Theme.of(context).textTheme.titleLarge,
                                textAlign: TextAlign.start,
                              ),
                              OutlinedButton.icon(
                                onPressed: () => context
                                    .pushRoute(CreateCourseRoute()),
                                label: const Text("Добавить"),
                                icon: const Icon(Iconsax.add),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          state is! ProfileScreenLoadedState
                              ? ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: 10,
                                  itemBuilder: (context, index) {
                                    return const CourseInfoShimmerCard();
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const SizedBox(
                                      height: 12,
                                    );
                                  },
                                )
                              : AnimatedList.separated(
                                  key: _animatedListKey,
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  initialItemCount: state.courses?.length ?? 0,
                                  itemBuilder: (context, index, anim) {
                                    if (state.courses == null ||
                                        index >= state.courses!.length) {
                                      return const SizedBox.shrink();
                                    }

                                    final course = state.courses![index];
                                    return FadeTransition(
                                      opacity: Tween<double>(begin: 0, end: 1)
                                          .animate(CurvedAnimation(
                                              parent: anim,
                                              curve: Curves.easeIn,
                                              reverseCurve: Curves.easeInBack)),
                                      child: ScaleTransition(
                                        scale: Tween<double>(begin: 0.4, end: 1)
                                            .animate(CurvedAnimation(
                                                parent: anim,
                                                curve: Curves.easeIn,
                                                reverseCurve:
                                                    Curves.easeInBack)),
                                        child: CourseInfoCard(
                                          title: course.title,
                                          description: course.description,
                                          imageUrl:
                                              "$uploadsUrl/${course.imageUrl}",
                                          rating: 4.9,
                                          peopleCount: 136,
                                          onTap: () async => await context
                                              .pushRoute(CourseInfoRoute(
                                                  id: course.id)),
                                          onDelete: () =>
                                              _deleteCourse(course, index),
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index, anim) {
                                    return const SizedBox(
                                      height: 12,
                                    );
                                  },
                                  removedSeparatorBuilder:
                                      (BuildContext context, int index,
                                          Animation<double> animation) {
                                    return const SizedBox();
                                  },
                                ),
                          const SizedBox(
                            height: 70,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
      listener: (BuildContext context, ProfileScreenState state) {
        if (state is ProfileScreenErrorState) {
          context.read<ProfileScreenBloc>().loadData();
        }
        if (state is ProfileScreenLoadedState) {
          _animateList(state.courses?.length ?? 0);
        }
      },
    );
  }
}
