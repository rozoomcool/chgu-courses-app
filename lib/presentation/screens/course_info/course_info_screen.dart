import 'package:auto_route/annotations.dart';
import 'package:coursera/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

@RoutePage()
class CourseInfoScreen extends StatefulWidget {
  const CourseInfoScreen({super.key});

  @override
  State<CourseInfoScreen> createState() => _CourseInfoScreenState();
}

class _CourseInfoScreenState extends State<CourseInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            foregroundColor: AppColors.backgroundColor,
            backgroundColor: AppColors.darkBackgroundColor,
            stretch: true,
            centerTitle: true,
            title: Text("Javascript for beginners",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: AppColors.backgroundColor)),
            floating: true,
            pinned: true,
            expandedHeight: 164.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                'https://248006.selcdn.ru/main/iblock/962/96208c049e9bc631c06ba4a24943dbd9/219c0e5d1826ee7f7a1f4a9c023abe27.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SliverPadding(padding: EdgeInsetsGeometry.all(12)),
          SliverAnimatedList(
              initialItemCount: 20,
              itemBuilder: (context, i, animation) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceColor,
                    borderRadius: BorderRadius.circular(12)
                  ),
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
    );
  }
}
