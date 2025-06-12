import 'package:auto_route/auto_route.dart';
import 'package:coursera/presentation/screens/student_profile_screen/bloc/student_profile_screen_bloc.dart';
import 'package:coursera/presentation/widgets/course_info_card.dart';
import 'package:coursera/presentation/widgets/course_info_shimmer_card.dart';
import 'package:coursera/router/app_router.dart';
import 'package:coursera/utils/app_colors.dart';
import 'package:coursera/utils/constants.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';

@RoutePage()
class StudentProfileScreen extends StatefulWidget {
  const StudentProfileScreen({super.key});

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  final IndicatorController _indicatorController = IndicatorController();
  final GlobalKey<AnimatedListState> _animatedListKey = GlobalKey();

  Future<void> _animateList(int count) async {
    for (int i = 0; i < count; i++) {
      if (i < 5) {
        await Future.delayed(const Duration(milliseconds: 150));
      }
      _animatedListKey.currentState
          ?.insertItem(i, duration: const Duration(milliseconds: 300));
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<StudentProfileScreenBloc>().loadData();
    context.router.navigationHistory.addListener(() {
      context.read<StudentProfileScreenBloc>().loadData();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<StudentProfileScreenBloc>().loadData();
  }

  @override
  void dispose() {
    _indicatorController.dispose();
    if (mounted) {
      context.router.navigationHistory.removeListener(() {});
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentProfileScreenBloc, StudentProfileScreenState>(
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
            context.read<StudentProfileScreenBloc>().loadData();
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
                          state is! StudentProfileScreenLoadedState
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
                              state is! StudentProfileScreenLoadedState
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
                              state is! StudentProfileScreenLoadedState
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 24,
                          ),
                          Text(
                            "Мои Курсы",
                            style: Theme.of(context).textTheme.titleLarge,
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          state is! StudentProfileScreenLoadedState
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
                                  initialItemCount: state.admissions?.length ?? 0,
                                  itemBuilder: (context, index, anim) {
                                    if (state.admissions == null ||
                                        index >= state.admissions!.length) {
                                      return const SizedBox.shrink();
                                    }

                                    final course = state.admissions![index].course!;
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
                                              .pushRoute(StudentCourseInfoRoute(
                                                  id: course.id)),
                                          onDelete: null,
                                          complexity: course.complexity,
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
      listener: (BuildContext context, StudentProfileScreenState state) {
        if (state is StudentProfileScreenErrorState) {
          context.read<StudentProfileScreenBloc>().loadData();
        }
        if (state is StudentProfileScreenLoadedState) {
          _animateList(state.admissions?.length ?? 0);
        }
      },
    );
  }
}