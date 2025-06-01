import 'package:flutter/material.dart';
import 'bingo_cell_widget.dart';
import 'custom_text_field_widget.dart';
import 'package:bingo/widgets/custom_main_button_widget.dart';

class TheatreCreationForm extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSubmit;
  final VoidCallback onCancel;

  final List<TextEditingController> bingoControllers;

  const TheatreCreationForm({
    super.key,
    required this.controller,
    required this.onSubmit,
    required this.onCancel,
    required this.bingoControllers,
  });

  void _showEditDialog(BuildContext context, TextEditingController controller, int cellNumber) {
    final TextEditingController tempController = TextEditingController(text: controller.text);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        title: Text(
          'Edit Cell ${cellNumber + 1}',
          style: TextStyle(color: Colors.redAccent.shade100),
        ),
        content: TextField(
          controller: tempController,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Enter text',
            hintStyle: TextStyle(color: Colors.redAccent.shade100),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.redAccent.shade100),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.redAccent.shade200, width: 2.0),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel', style: TextStyle(color: Colors.white)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
            ),
            onPressed: () {
              controller.text = tempController.text;
              Navigator.pop(context);
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomTextField(
          label: 'Theatre name',
          controller: controller,
        ),
        CustomTextField(
          label: 'Movie name',
          controller: controller,
        ),
        const SizedBox(height: 16),
        Text(
          'Bingo Cases',
          style: TextStyle(
            color: Colors.redAccent.shade100,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1,
          ),
          itemCount: 25,
          itemBuilder: (context, index) {
            if (index == 12) {
              return BingoCell(
                controller: TextEditingController(text: 'FREE'),
                onTap: () {},
                isFree: true,
              );
            } else {
              final realIndex = index < 12 ? index : index - 1;
              return BingoCell(
                controller: bingoControllers[realIndex],
                onTap: () {
                  _showEditDialog(context, bingoControllers[realIndex], realIndex);
                },
              );
            }
          },
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: CustomMainButton(
                text: "Create",
                onPressed: onSubmit,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: CustomMainButton(
                text: "Cancel",
                onPressed: onCancel,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
