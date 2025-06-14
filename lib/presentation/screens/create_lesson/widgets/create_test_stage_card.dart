import 'package:coursera/domain/model/testStage/test_stage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';

class CreateTestStageCard extends StatelessWidget {
  const CreateTestStageCard(
      {super.key,
      required this.testStage,
      required this.onEdit,
      required this.onDelete,
      required this.onAddOption,
      required this.onDeleteOption});

  final TestStage testStage;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onAddOption;
  final void Function(int id) onDeleteOption;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: Card(
          color: const Color.fromARGB(255, 234, 234, 243),
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 1,
                        child: Text(
                          testStage.question,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )),
                    Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                onPressed: onDelete, icon: Icon(Iconsax.trash)),
                            IconButton(
                                onPressed: onEdit, icon: Icon(Iconsax.edit)),
                          ],
                        ))
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                SizedBox(
                    width: double.infinity,
                    child: TextButton.icon(
                      onPressed: onAddOption,
                      label: Text("Добавить вариант ответа"),
                      icon: Icon(Iconsax.add),
                    )),
                if (testStage.options.isNotEmpty)
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: testStage.options.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsetsGeometry.symmetric(vertical: 4),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                                flex: 3,
                                child: Row(
                                  spacing: 8,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: IconButton(
                                          onPressed: () => onDeleteOption(
                                              testStage.options[index].id),
                                          icon: Icon(
                                            Iconsax.trash,
                                            color: Colors.red.shade400,
                                          )),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        testStage.options[index].option,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                )),
                            Expanded(
                                child: Align(
                              alignment: Alignment.centerRight,
                              child: CircleAvatar(
                                radius: 12,
                                backgroundColor:
                                    testStage.options[index].isCorrect
                                        ? Colors.green
                                        : Colors.pink,
                              ),
                            ))
                          ],
                        ),
                      );
                    },
                  )
              ],
            ),
          ),
        ));
  }
}
