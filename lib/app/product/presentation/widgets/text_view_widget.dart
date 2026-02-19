import '../../../../core/constants/exports.dart';

class TextViewWidget extends StatelessWidget {
  const TextViewWidget(
    this.text, {
    super.key,
    this.style,
    this.isEllipsis = false,
    this.textScaleFactor = false,
    this.maxLines,
    this.align,
  });

  final String? text;
  final TextStyle? style;
  final TextAlign? align;
  final bool isEllipsis;
  final bool textScaleFactor;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "Null",
      textScaler: textScaleFactor ? const TextScaler.linear(1.0) : null,
      overflow: isEllipsis ? TextOverflow.ellipsis : null,
      softWrap: true,
      style: style ?? textTheme.labelMedium,
      maxLines: maxLines,
      textHeightBehavior: const TextHeightBehavior(
        applyHeightToFirstAscent: false,
      ),
      textAlign: align,
    );
  }
}
