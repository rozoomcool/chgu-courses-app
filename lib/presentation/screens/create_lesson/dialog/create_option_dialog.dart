import 'package:auto_route/auto_route.dart';
import 'package:coursera/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CreateOptionDialog extends StatefulWidget {
  const CreateOptionDialog({super.key, required this.onCreate});

  final void Function(String, bool) onCreate;

  @override
  State<CreateOptionDialog> createState() => _CreateOptionDialogState();
}

class _CreateOptionDialogState extends State<CreateOptionDialog> {
  final _optionController = TextEditingController();
  bool isCorrect = false;

  void toggleCorrect() {
    setState(() {
      isCorrect = !isCorrect;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [
            TextField(
              controller: _optionController,
              decoration: InputDecoration(hint: Text("Вариант ответа")),
            ),
            GestureDetector(
              onTap: toggleCorrect,
              child: Container(
                width: double.infinity,
                height: 42,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: isCorrect ? Colors.green : Colors.blueGrey.shade400),
                child: Center(
                  child: Text(
                    isCorrect ? "Верный ответ" : "Не верный ответ",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: isCorrect ? Colors.white : Colors.black45),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 48,
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    widget.onCreate(_optionController.text, isCorrect);
                    context.pop();
                  },
                  child: Text(
                    "Сохранить",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: AppColors.backgroundColor),
                  )),
            )
          ],
        ),
      ),
    );
    ;
  }
}
