import 'package:coursera/domain/model/course/course.dart';
import 'package:coursera/presentation/widgets/text_chip.dart';
import 'package:coursera/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

Color complexityColor(Complexity complexity) {
  return {
        Complexity.EASY: Colors.green,
        Complexity.MEDIUM: Colors.deepOrange,
        Complexity.HARD: Colors.pink,
      }[complexity] ??
      Colors.green;
}

class CourseInfoCard extends StatelessWidget {
  const CourseInfoCard(
      {super.key,
      required this.title,
      required this.description,
      required this.rating,
      required this.peopleCount,
      this.onTap,
      this.onDelete,
      required this.imageUrl,
      required this.complexity});

  final String title;
  final String description;
  final String imageUrl;
  final double rating;
  final int peopleCount;
  final Function? onTap;
  final Function? onDelete;
  final Complexity complexity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.backgroundColor),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    height: 72,
                    width: 72,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.blueGrey,
                        image: DecorationImage(
                            image: NetworkImage(imageUrl), fit: BoxFit.cover)),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          description,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 12,
                    children: [
                      TextChip(
                          label: Text("$peopleCount",
                              style: Theme.of(context).textTheme.bodyLarge),
                          icon: const Icon(
                            Iconsax.people,
                            color: Colors.black,
                          )),
                      TextChip(
                          label: Text(complexity.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      fontWeight: FontWeight.w900,
                                      color: complexityColor(complexity))),
                          icon: const Icon(Iconsax.arrow_up, color: Colors.black)),
                    ],
                  ),
                  Row(
                    spacing: 8,
                    children: [
                      onDelete != null
                          ? TextButton.icon(
                              onPressed: () {
                                onDelete!();
                              },
                              label: Text(
                                "Delete",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                        color: Colors.red.withAlpha(200)),
                              ),
                              icon: Icon(Iconsax.trash,
                                  color: Colors.red.withAlpha(200)),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
