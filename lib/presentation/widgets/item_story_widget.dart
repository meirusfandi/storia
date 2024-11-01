import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:storia/core/helper/date_helper.dart';
import 'package:storia/core/routes/router.dart';
import 'package:storia/core/utils/color_widget.dart';
import 'package:storia/core/utils/container_widget.dart';
import 'package:storia/core/utils/text_widget.dart';

class ItemStoryWidget extends StatelessWidget {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String createdAt;

  const ItemStoryWidget(
      {super.key,
      required this.name,
      required this.description,
      required this.imageUrl,
      required this.createdAt,
      required this.id});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.pushRoute(DetailStoryRoute(storyId: id)),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                blurRadius: 6,
                color: Colors.black.withOpacity(0.15),
                spreadRadius: -1,
                offset: const Offset(1, -1),
              ),
              const BoxShadow()
            ],
            color: Colors.white),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl,
              width: 120,
              height: 80,
              fit: BoxFit.fill,
              placeholder: (context, url) => const SizedBox(
                  width: 24, height: 24, child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ).rightPadded(8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget.manropeSemiBold(name,
                      size: 16, color: ColorWidget.textSecondaryColor),
                  TextWidget.manropeRegular(description,
                      maxLine: 3,
                      size: 12,
                      color: ColorWidget.textSecondaryColor),
                  TextWidget.manropeRegular(DateHelper.parseDate(createdAt),
                      size: 12, color: ColorWidget.textSecondaryColor),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded)
          ],
        ).padded(),
      ).horizontalPadded().verticalPadded(8),
    );
  }
}
