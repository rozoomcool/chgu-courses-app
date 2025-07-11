import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  String selectedTime = 'Сегодня днем';
  String selectedBudget = 'До 3000 ₽';
  double moodValue = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Найти занятие"),
                SizedBox(height: 8),
                Text("Ответь на 3 вопроса, и я подберу идею"),
                SizedBox(height: 24),
                _buildSectionTitle("Когда?"),
                _buildChoiceChips(['Сегодня днем', 'Вечером', 'На выходных'], selectedTime, (val) => setState(() => selectedTime = val)),
                SizedBox(height: 16),
                _buildSectionTitle("Бюджет?"),
                _buildChoiceChips(['Бесплатно', 'До 1000 ₽', 'До 3000 ₽', 'Любой'], selectedBudget, (val) => setState(() => selectedBudget = val)),
                SizedBox(height: 16),
                _buildSectionTitle("Настроение?"),
                Slider(
                  value: moodValue,
                  onChanged: (val) => setState(() => moodValue = val),
                  min: 0,
                  max: 1,
                ),
                Text(
                  moodValue < 0.33
                      ? "Расслабиться"
                      : moodValue < 0.66
                          ? "Что-то интересное"
                          : "Адреналиновый маньяк",
                ),
                SizedBox(height: 24),
                _buildButton("Поехали!"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(title),
    );
  }

  Widget _buildChoiceChips(List<String> options, String selected, Function(String) onSelected) {
    return Wrap(
      spacing: 8,
      children: options.map((opt) {
        return ChoiceChip(
          label: Text(opt),
          selected: opt == selected,
          onSelected: (_) => onSelected(opt),
        );
      }).toList(),
    );
  }

  Widget _buildButton(String text) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        child: Text(text),
      ),
    );
  }
}
