import 'package:flutter/material.dart';
import 'package:rick_morty/theme/app_colors.dart';
import 'package:rick_morty/theme/text_type.dart';
import 'package:rick_morty/utils/string_extension.dart';

class FiltersWidget extends StatefulWidget {
  const FiltersWidget({
    super.key,
    required this.filters,
    required this.initialSelectedFilter,
    required this.onFilterSelected,
  });

  final List<String> filters;
  final String initialSelectedFilter;
  final ValueChanged<String> onFilterSelected;

  @override
  State<FiltersWidget> createState() => _FiltersWidgetState();
}

class _FiltersWidgetState extends State<FiltersWidget> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();

    selectedIndex = widget.filters.indexOf(widget.initialSelectedFilter);

    if (selectedIndex == -1) selectedIndex = 0;
  }

  Widget getFiltersRow() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 20
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(widget.filters.length, (index) {
          String filter = widget.filters[index];

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });

              widget.onFilterSelected(filter);

              Navigator.pop(context);
            },
            child: FilterWidget(
              text: filter.capitalize(),
              isSelected: selectedIndex == index,
            ),
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Filters', style: TextType.title.textSyle),
          SizedBox(height: 20),
          getFiltersRow(),
        ],
      ),
    );
  }
}

class FilterWidget extends StatelessWidget {
  const FilterWidget({super.key, required this.text, required this.isSelected});

  final String text;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.cardFooterColor
            : AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text, style: TextType.description.textSyle),
    );
  }
}
