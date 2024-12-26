import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:common/widgets/asset_icon.dart';
import 'package:common/widgets/custom_list_tile.dart';
import 'package:virtual_tours_bloc/virtual_tours/components/custom_color_container.dart';

class CustomListTileWidget extends StatelessWidget {
  const CustomListTileWidget({
    super.key,
    this.icon,
    this.title,
    this.subTitle,
    this.isVerified = false,
  });
  final AssetIcons? icon;
  final String? title;
  final String? subTitle;
  final bool isVerified;

  @override
  Widget build(BuildContext context) {
    return CustomColorContainer(
      margin: const EdgeInsets.only(top: 16),
      child: CustomListTile(
        titleStyle: context.sixteen400.withColor(context.grey500),
        subtitleStyle: context.sixteen400,
        leading: Stack(
          children: [
            if (icon != null)
              ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(50),
                ),
                child: AssetIcon.multicolor(icon ?? AssetIcons.Avatar),
              )
            else
              Image.asset('assets/images/Avatar.png'),
            if (isVerified)
              const Positioned(
                left: 27.0,
                bottom: 0.0,
                child: AssetIcon.multicolor(AssetIcons.Avatar),
              )
            else
              const SizedBox.shrink(),
          ],
        ),
        customTitle: Text(
          title ?? '',
          style: context.sixteen400.withColor(context.grey300),
        ),
        customSubtitle: Text(
          subTitle ?? '-----------',
          style: subTitle != null
              ? context.sixteen400.withColor(context.grey900)
              : context.sixteen400.withColor(context.grey300),
        ),
        trailing: AssetIcon.monotone(
          AssetIcons.arrow_right,
          color: subTitle != null ? context.grey900 : context.grey300,
        ),
      ),
    );
  }
}
