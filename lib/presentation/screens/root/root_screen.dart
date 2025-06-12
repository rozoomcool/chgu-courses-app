import 'package:auto_route/auto_route.dart';
import 'package:coursera/domain/model/user/user.dart';
import 'package:coursera/domain/state/auth/auth_cubit.dart';
import 'package:coursera/domain/state/theme/theme_cubit.dart';
import 'package:coursera/domain/state/user/user_cubit.dart';
import 'package:coursera/router/app_router.dart';
import 'package:coursera/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';

@RoutePage()
class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserCubit()..init()),
        ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return BlocBuilder<AuthCubit, AuthState>(
            builder: (context, authState) {
              if (authState is! AuthenticatedAuthState) return Scaffold();
              return AutoTabsScaffold(
                // scaffoldKey: GetIt.I<CustomScaffoldUtil>().key,
                backgroundColor: AppColors.backgroundColor,
                routes: [
                  if (authState.user.role == Role.STUDENT.name) HomeRoute(),
                  ServiceRoute(),
                  (authState.user.role != Role.STUDENT.name) ? ProfileRoute(): StudentProfileRoute(),
                ],
                appBarBuilder: (context, tabsRouter) {
                  return AppBar(
                    backgroundColor: AppColors.backgroundColor,
                    title: Row(
                      children: [
                        SizedBox(
                            width: 28,
                            height: 28,
                            child: SvgPicture.asset("assets/logo_s.svg")),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "CourseUp",
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                              color: AppColors.primaryColor),
                        )
                      ],
                    ),
                    centerTitle: false,
                    actions: [
                      // IconButton(
                      //   onPressed: () {
                      //     context.read<ThemeCubit>().toggleTheme();
                      //   },
                      //   icon: Icon(state is LightModeThemeState
                      //       ? Iconsax.sun_1
                      //       : Iconsax.moon5),
                      // ),
                      IconButton(
                        onPressed: () {
                          context.read<AuthCubit>().logOut();
                        },
                        icon: const Icon(Iconsax.logout),
                      ),
                    ],
                  );
                },
                transitionBuilder: (context, child, animation) =>
                    TransitionsBuilders.slideLeftWithFade(
                        context, animation, animation, child),
                // floatingActionButton: FloatingActionButton.extended(
                //   onPressed: () {
                //     context.pushRoute(const MapsRoute());
                //   },
                //   label: const FaIcon(FontAwesomeIcons.locationDot),
                // ),
                // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                bottomNavigationBuilder: (context, tabsRouter) {
                  return BottomNavigationBar(
                    backgroundColor: AppColors.backgroundColor,
                    elevation: 4,
                    currentIndex: tabsRouter.activeIndex,
                    onTap: tabsRouter.setActiveIndex,
                    selectedItemColor: Colors.black87,
                    unselectedItemColor: Colors.black54,
                    items: [
                      if (authState.user.role == Role.STUDENT.name) BottomNavigationBarItem(
                          label: 'Главная', icon: Icon(Iconsax.home)),
                      BottomNavigationBarItem(
                          label: 'Уведомления', icon: Icon(Iconsax.notification)),
                      BottomNavigationBarItem(
                          label: 'Профиль', icon: Icon(Iconsax.user)),
                    ],
                  );
                },
              );
            }
          );
        },
      ),
    );
  }
}
