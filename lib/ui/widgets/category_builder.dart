import 'package:exam_6/ui/widgets/special/text_field_widget.dart';
import 'package:exam_6/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CategoryBuilder extends StatefulWidget {
  final dynamic state;
  String selectedCategory;
  int? selectedChip;
  final Function(String) onCategorySelected;

  CategoryBuilder({
    super.key,
    required this.state,
    required this.selectedCategory,
    required this.selectedChip,
    required this.onCategorySelected,
  });

  @override
  State<CategoryBuilder> createState() => _CategoryBuilderState();
}

class _CategoryBuilderState extends State<CategoryBuilder> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 100),
          itemCount: widget.state.categories.length,
          itemBuilder: (ctx, index) {
            return InkWell(
              child: Chip(
                label: Text(widget.state.categories[index]),
                backgroundColor:
                    widget.state.categories[index] == widget.selectedCategory
                        ? AppColors.primaryColor2
                        : AppColors.colorWhite,
              ),
              onTap: () {
                setState(() {
                  widget.selectedCategory = widget.state.categories[index];
                  widget.selectedChip = index;
                });

                // Call the callback function to notify the parent
                widget.onCategorySelected(widget.selectedCategory);
              },
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: InkWell(
            child: const Chip(
              label: Icon(Icons.add),
            ),
            onTap: () {
              final categoryController = TextEditingController();
              showDialog(
                context: context,
                builder: (ctx) {
                  return AlertDialog(
                    content: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40.0),
                      child: TextFieldWidget(
                        keyboard: TextInputType.text,
                        controller: categoryController,
                        hintText: 'Category name',
                      ),
                    ),
                    actions: [
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel"),
                          ),
                          FilledButton(
                            onPressed: () {
                              setState(() {
                                widget.selectedCategory =
                                    categoryController.text;
                                widget.selectedChip = null;
                              });

                              // Notify parent with the new category
                              widget
                                  .onCategorySelected(widget.selectedCategory);

                              Navigator.pop(context);
                            },
                            child: const Text("Add"),
                          ),
                        ],
                      )
                    ],
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  String getSelectedCategory() {
    return widget.selectedCategory;
  }
}
