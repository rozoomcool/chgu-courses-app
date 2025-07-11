import 'package:auto_route/auto_route.dart';
import 'package:eventrecs/router/app_router.dart';
import 'package:eventrecs/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ActivityCard extends StatelessWidget {
  final String title;
  final String? description;
  final List<String> weatherTypes;
  final List<String> timeOfDay;
  final int minBudget;
  final int? maxBudget;
  final bool isOutdoor;
  final bool isHomeActivity;
  final bool isActive;
  final String? previewUrl;

  const ActivityCard({
    super.key,
    required this.title,
    this.description,
    required this.weatherTypes,
    required this.timeOfDay,
    required this.minBudget,
    this.maxBudget,
    required this.isOutdoor,
    required this.isHomeActivity,
    required this.isActive,
    this.previewUrl,
  });

  @override
  Widget build(BuildContext context) {
    final budgetText =
        maxBudget != null ? '\$$minBudget - \$$maxBudget' : 'From \$$minBudget';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          context.pushRoute(ActivityDetailsRoute(
              id: "1",
              title: title,
              previewUrl: previewUrl,
              description: description));
        },
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (previewUrl != null)
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.network(
                    previewUrl!,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            )),
                    const SizedBox(height: 8),
                    if (description != null)
                      Text(description!,
                          style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: [
                        TagChip(
                          label: weatherTypes.join(", "),
                          icon: Icons.wb_sunny,
                        ),
                        TagChip(
                          label: timeOfDay.join(", "),
                          icon: Icons.schedule,
                        ),
                        TagChip(
                          label: budgetText,
                          icon: Icons.attach_money,
                        ),
                        if (isOutdoor)
                          TagChip(
                            label: 'Outdoor',
                            icon: Icons.park,
                          ),
                        if (isHomeActivity)
                          TagChip(
                            label: "Home",
                            icon: Icons.home,
                          ),
                        TagChip(
                            label: isActive ? 'Active' : 'Inactive',
                            icon: isActive ? Icons.check_circle : Icons.cancel,
                            color: isActive ? Colors.green : Colors.red),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TagChip extends StatelessWidget {
  const TagChip(
      {super.key, required this.icon, required this.label, this.color});

  final IconData icon;
  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Chip(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      avatar: Icon(icon, size: 16, color: color ?? Theme.of(context).iconTheme.color),
      label: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
    ;
  }
}
