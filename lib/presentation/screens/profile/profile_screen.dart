import 'package:auto_route/auto_route.dart';
import 'package:coursera/presentation/screens/profile/bloc/profile_screen_bloc.dart';
import 'package:coursera/presentation/widgets/course_info_card.dart';
import 'package:coursera/presentation/widgets/course_info_shimmer_card.dart';
import 'package:coursera/router/app_router.dart';
import 'package:coursera/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer/shimmer.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileScreenBloc, ProfileScreenState>(
        builder: (context, state) {
      if (state is ProfileScreenErrorState) {
        return const Center(child: Text("Error"));
      }
      return SingleChildScrollView(
        child: ColoredBox(
          color: AppColors.surfaceColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: AppColors.backgroundColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
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
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.black),
                                  ),
                                ),
                              )
                            : Text(
                                "пока нет",
                                style: Theme.of(context).textTheme.titleLarge,
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
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.black),
                                  ),
                                ),
                              )
                            : Text(
                                state.user.email,
                                style: Theme.of(context).textTheme.bodyMedium,
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
                          onPressed: () =>
                              context.pushRoute(const CreateCourseRoute()),
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
                        : ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.courses!.length,
                            itemBuilder: (context, index) {
                              return CourseInfoCard(
                                title: state.courses![index].title,
                                description: state.courses![index].description,
                                rating: 4.9,
                                peopleCount: 136,
                                onTap: () async => await context
                                    .pushRoute(const CourseInfoRoute()),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(
                                height: 12,
                              );
                            },
                          ),
                          const SizedBox(height: 70,)
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
