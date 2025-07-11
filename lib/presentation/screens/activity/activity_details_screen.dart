import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ActivityDetailsScreen extends StatefulWidget {
  const ActivityDetailsScreen(
      {super.key,
      required this.id,
      required this.title,
      this.description,
      this.previewUrl});

  final String id;
  final String title;
  final String? description;
  final String? previewUrl;

  @override
  State<ActivityDetailsScreen> createState() => _ActivityDetailsScreenState();
}

class _ActivityDetailsScreenState extends State<ActivityDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: ListView(
        children: [
          if (widget.previewUrl != null)
            Hero(
              tag: 'activity-image-$widget.id',
              child: Image.network(
                widget.previewUrl!,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.description ?? "No description provided.",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
    ;
  }
}
