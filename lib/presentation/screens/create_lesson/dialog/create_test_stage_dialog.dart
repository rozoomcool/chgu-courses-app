import 'package:auto_route/auto_route.dart';
import 'package:coursera/domain/model/testStage/testStageType.dart';
import 'package:coursera/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CreateTestStageDialog extends StatefulWidget {
  const CreateTestStageDialog(
      {super.key, required this.onOk, required this.testId});

  final void Function(String, TestStageType) onOk;
  final int testId;

  @override
  State<CreateTestStageDialog> createState() => _CreateTestStageDialogState();
}

class _CreateTestStageDialogState extends State<CreateTestStageDialog> {
  TestStageType testStageType = TestStageType.OPTIONAL;
  final _optionController = TextEditingController();

  void onTypeChanged(TestStageType? type) {
    if (type != null) {
      setState(() {
        testStageType = type;
      });
    }
  }

  @override
  void dispose() {
    _optionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 4,
          children: [
            TextField(
              controller: _optionController,
              decoration: InputDecoration(hint: Text("Вопрос")),
            ),
            DropdownButton<TestStageType>(
                hint: Text("Формат ответа"),
                dropdownColor: AppColors.surfaceColor,
                borderRadius: BorderRadius.circular(12),
                value: testStageType,
                items: [
                  DropdownMenuItem(
                      value: TestStageType.OPTIONAL, child: Text("Выбор")),
                  DropdownMenuItem(
                      value: TestStageType.MANUAL, child: Text("Вручную")),
                ],
                onChanged: onTypeChanged),
            SizedBox(
              height: 48,
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    widget.onOk(_optionController.text,
                        testStageType);
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
  }
}
