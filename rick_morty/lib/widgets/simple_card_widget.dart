import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rick_morty/theme/app_colors.dart';
import 'package:rick_morty/widgets/shimmer_widget.dart';

class SimpleCardWidget extends StatelessWidget {
  final List<dynamic> items;
  final bool isLoading;
  final bool isConnecting;
  final int minimumLength;
  final Color boxColor;
  final TextStyle textStyle;

  const SimpleCardWidget({
    super.key,
    required this.items,
    required this.isLoading,
    required this.isConnecting,
    required this.minimumLength,
    required this.boxColor,
    required this.textStyle
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(
        right: 10,
        left: 10,
        top: 15,
        bottom: items.length < minimumLength
            ? 200 * ((minimumLength / 2) - (items.length / 2).ceil()).toDouble()
            : 0,
      ),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1,
        ),
        delegate: SliverChildBuilderDelegate((context, index) {
          if (isConnecting) {
            return ShimmerWidget.rectangular(
              height: double.infinity,
              width: double.infinity,
              borderRadius: 12,
              baseColor: AppColors.baseShimmerColor(context),
              highlightColor: AppColors.highlightShimmerColor(context),
            );
          }

          final item = items[index];

          return Container(
            decoration: BoxDecoration(
              color: boxColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${item.name}',
                  style: textStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }, childCount: isConnecting ? minimumLength : items.length),
      ),
    );
  }
}
