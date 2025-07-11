import 'package:auto_route/auto_route.dart';
import 'package:eventrecs/domain/model/user/user.dart';
import 'package:eventrecs/domain/state/auth/auth_cubit.dart';
import 'package:eventrecs/domain/state/theme/theme_cubit.dart';
import 'package:eventrecs/domain/state/user/user_cubit.dart';
import 'package:eventrecs/presentation/widgets/custom_bottom_navigation_bar.dart';
import 'package:eventrecs/presentation/widgets/gradient_container.dart';
import 'package:eventrecs/router/app_router.dart';
import 'package:eventrecs/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glossy/glossy.dart';
import 'package:iconsax/iconsax.dart';

final gradients = [
  GradientContainer(
      alignment: Alignment.topCenter, color: Colors.cyan, radius: 0.6),
  GradientContainer(
      alignment: Alignment.topLeft, color: Colors.teal, radius: 0.85),
  GradientContainer(
      alignment: Alignment.topRight, color: Colors.pink, radius: 0.8),
  GradientContainer(
      alignment: Alignment.bottomLeft,
      color: Colors.red.withAlpha(100),
      radius: 0.8),
  GradientContainer(
      alignment: Alignment.bottomRight,
      color: Colors.purple.withAlpha(50),
      radius: 0.9),
  GradientContainer(
      alignment: Alignment.bottomCenter,
      color: Colors.cyan.withAlpha(50),
      radius: 0.8),
];

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
            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/sunny.jpg"),
                          fit: BoxFit.cover)),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black26, // тёмный полупрозрачный слой
                  ),
                ),
                // ...gradients,
                AutoTabsScaffold(
                  // scaffoldKey: GetIt.I<CustomScaffoldUtil>().key,
                  backgroundColor: Colors.transparent,
                  extendBody: true,
                  extendBodyBehindAppBar: true,
                  // backgroundColor: AppColors.backgroundColor,
                  routes: [
                    if (authState.user.role == Role.STUDENT.name) HomeRoute(),
                    ServiceRoute(),
                    ProfileRoute(),
                  ],
                  // appBarBuilder: (context, tabsRouter) {
                  //   return AppBar(
                  //     backgroundColor: Colors.transparent,
                  //     // backgroundColor: AppColors.backgroundColor,
                  //     title: Row(
                  //       children: [
                  //         SizedBox(
                  //             width: 28,
                  //             height: 28,
                  //             child: SvgPicture.asset("assets/logo_s.svg")),
                  //         const SizedBox(
                  //           width: 8,
                  //         ),
                  //         Text(
                  //           "НеВесело",
                  //           style: Theme.of(context)
                  //               .textTheme
                  //               .bodyLarge
                  //               ?.copyWith(
                  //                   fontWeight: FontWeight.bold,
                  //                   fontSize: 28,
                  //                   color: AppColors.primaryColor),
                  //         )
                  //       ],
                  //     ),
                  //     centerTitle: false,
                  //     actions: [
                  //       // IconButton(
                  //       //   onPressed: () {
                  //       //     context.read<ThemeCubit>().toggleTheme();
                  //       //   },
                  //       //   icon: Icon(state is LightModeThemeState
                  //       //       ? Iconsax.sun_1
                  //       //       : Iconsax.moon5),
                  //       // ),
                  //       IconButton(
                  //         onPressed: () {
                  //           context.read<AuthCubit>().logOut();
                  //         },
                  //         icon: const Icon(Iconsax.logout),
                  //       ),
                  //     ],
                  //   );
                  // },
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
                    return CustomBottomNavigationBar(
                        selectedIndex: tabsRouter.activeIndex,
                        onTap: tabsRouter.setActiveIndex,
                        items: [
                          CustomBottomNavigationBarItem(
                              label: 'Statistics',
                              selectedIcon: Iconsax.home,
                              defaultIcon: Iconsax.home),
                          CustomBottomNavigationBarItem(
                              label: 'Home',
                              selectedIcon: Iconsax.search_favorite,
                              defaultIcon: Iconsax.search_favorite),
                          CustomBottomNavigationBarItem(
                              label: 'Settings',
                              selectedIcon: Iconsax.user,
                              defaultIcon: Iconsax.user),
                          // CustomBottomNavigationBarItem(
                          //     label: 'Statistics', selectedIcon: Icons.graphic_eq_rounded, defaultIcon: Icons.graphic_eq_outlined),
                        ]);
                  },
                ),
              ],
            );
          });
        },
      ),
    );
  }
}
