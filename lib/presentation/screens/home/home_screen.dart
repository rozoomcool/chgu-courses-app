import 'package:auto_route/auto_route.dart';
import 'package:eventrecs/presentation/widgets/activity_card_glossy.dart';
import 'package:flutter/material.dart';
import 'package:glossy/glossy.dart';
import 'package:iconsax/iconsax.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> activities = List.generate(20, (i) => 'Activity ${i + 1}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 162,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GlossyActivityCard(
                      previewUrl:
                          "https://miro.medium.com/v2/resize:fit:1200/1*3nvcKMlIJTpOguHbOaNP_A.jpeg",
                      title: "Activity 1",
                      description: "Description 1",
                      weatherTypes: ["Sunny", "Cloudy"],
                      timeOfDay: ["Morning", "Afternoon"],
                      minBudget: 100,
                      isOutdoor: false,
                      isHomeActivity: false,
                      isActive: true,
                    );
                  },
                  itemCount: activities.length,
                ),
              ],
            ),
          ),
          Transform.translate(
              offset: Offset(0, -1),
              child: GlossyContainer(
                height: 220,
                width: double.infinity,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32)),
                child: SafeArea(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        spacing: 12,
                        children: [
                          Text(
                            "Найти занятие",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                    fontWeight: FontWeight.w900),
                          ),
                          TextField(
                            decoration: InputDecoration(
                              filled: false,
                              prefixIcon: Icon(Iconsax.search_favorite),
                              // icon: Icon(Iconsax.search_favorite),
                              hint: Text("Введите название активности"),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)
                              )
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
