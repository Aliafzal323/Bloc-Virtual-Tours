// import 'package:common/common.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';

// class DottedBorderWidget extends StatelessWidget {
//   const DottedBorderWidget({
//     super.key,
//     required this.title,
//     // required this.height,
//     this.isSubtitleTrue = false,
//     required this.icon,
//     required this.isFullWidth,
//     required this.onTap,
//     this.subtitle,
//   });

//   final String title;
//   final AssetIcons icon;
//   final bool isFullWidth;
//   // final double height;
//   final bool isSubtitleTrue;
//   final VoidCallback onTap;
//   final String? subtitle;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: DottedBorder(
//         borderType: BorderType.RRect,
//         dashPattern: const [12],
//         strokeWidth: 2,
//         color: context.grey300,
//         // strokeCap: StrokeCap.square,
//         radius: const Radius.circular(12),
//         padding: isSubtitleTrue
//             ? const EdgeInsets.all(32)
//             : const EdgeInsets.symmetric(horizontal: 16, vertical: 58),
//         child: SizedBox(
//           width: isFullWidth
//               ? double.infinity
//               : MediaQuery.of(context).size.width * 0.35,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               AssetIcon.monotone(
//                 color: context.primary500,
//                 icon,
//               ),
//               const SizedBox(
//                 height: 8,
//               ),
//               Text(
//                 title,
//                 style: context.twelve400.withColor(context.grey900),
//               ),
//               const SizedBox(
//                 height: 8,
//               ),
//               if (isSubtitleTrue)
//                 Text(
//                   subtitle ?? '',
//                   style: context.twelve400.withColor(context.grey500),
//                 )
//               else
//                 const SizedBox.shrink(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
