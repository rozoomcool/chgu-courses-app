import 'package:auto_route/auto_route.dart';
import 'package:eventrecs/presentation/screens/profile/bloc/profile_screen_bloc.dart';
import 'package:eventrecs/router/app_router.dart';
import 'package:eventrecs/utils/app_colors.dart';
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<ProfileScreenBloc>().loadData();
  }

  @override
  void dispose() {
    _indicatorController.dispose();
    if (mounted) {
      context.router.navigationHistory.removeListener(() {});
    }
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
                                      "Шарпудди",
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
                    // Container(
                    //   padding: const EdgeInsets.symmetric(horizontal: 16),
                    //   child: Column(
                    //     children: [
                    //       const SizedBox(
                    //         height: 24,
                    //       ),
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         crossAxisAlignment: CrossAxisAlignment.center,
                    //         children: [
                    //           Text(
                    //             "Мои Курсы",
                    //             style: Theme.of(context).textTheme.titleLarge,
                    //             textAlign: TextAlign.start,
                    //           ),
                    //           OutlinedButton.icon(
                    //             onPressed: null,
                    //             label: const Text("Добавить"),
                    //             icon: const Icon(Iconsax.add),
                    //           )
                    //         ],
                    //       ),
                    //       const SizedBox(
                    //         height: 24,
                    //       ),
                    //       const SizedBox(
                    //         height: 70,
                    //       )
                    //     ],
                    //   ),
                    // )
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
      },
    );
  }
}
