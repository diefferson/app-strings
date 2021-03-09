import 'package:flutter/material.dart';

class StringsRichText extends StatelessWidget {
  const StringsRichText({
    Key? key,
    required this.text,
    this.style,
    this.textAlign,
    this.onTap,
    this.spanColor,
  }) : super(key: key);

  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final VoidCallback? onTap;
  final Color? spanColor;

  @override
  Widget build(BuildContext context) {
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    TextStyle? effectiveTextStyle = style;
    if (style == null || style!.inherit)
      effectiveTextStyle = defaultTextStyle.style.merge(style);
    if (MediaQuery.boldTextOverride(context))
      effectiveTextStyle = effectiveTextStyle!
          .merge(const TextStyle(fontWeight: FontWeight.bold));
    return GestureDetector(
      onTap: onTap,
      child: RichText(
        textAlign: textAlign ?? TextAlign.start,
        text: TextSpan(
          style: effectiveTextStyle,
          children: _getSpans(text),
        ),
      ),
    );
  }

  List<TextSpan> _getSpans(String text) {
    final List<TextSpan> spans = [];
    var boldText = false;
    var italicText = false;
    var colorText = false;
    var hasOpenTag = false;
    var finalText = '';
    for (int i = 0; i < text.length; i++) {
      if (text[i] == '<') {
        hasOpenTag = true;
        if (finalText.isNotEmpty) {
          spans.add(_createSpan(finalText, boldText, italicText, colorText));
          finalText = '';
          boldText = false;
          italicText = false;
          colorText = false;
        }

        if (i + 1 < text.length) {
          if (text[i + 1] == 'b') {
            boldText = true;
            i++;
          } else if (text[i + 1] == 'i') {
            italicText = true;
            i++;
          } else if (text[i + 1] == 'c') {
            colorText = true;
            i++;
          }
        }
      } else if (text[i] == '/') {
        if (hasOpenTag) {
          i++;
        } else {
          finalText += text[i];
        }
      } else if (text[i] == '>') {
        if (hasOpenTag) {
          hasOpenTag = false;
        } else {
          finalText += text[i];
        }
      } else {
        finalText += text[i];
      }

      if (i + 1 >= text.length) {
        spans.add(_createSpan(finalText, boldText, italicText, colorText));
      }
    }
    return spans;
  }

  TextSpan _createSpan(
      String finalText, bool boldText, bool italicText, bool colorText) {
    if (boldText) {
      return _boldSpan(finalText, colorText);
    } else if (italicText) {
      return _italicSpan(finalText, colorText);
    } else if (colorText) {
      return _colorSpan(finalText);
    } else {
      return TextSpan(text: finalText);
    }
  }

  TextSpan _boldSpan(String text, bool colorText) => TextSpan(
        text: text,
        style: TextStyle(
          fontWeight: style?.fontWeight == FontWeight.w300
              ? FontWeight.w500
              : FontWeight.bold,
          color: colorText ? spanColor : style?.color,
        ),
      );

  TextSpan _italicSpan(String text, bool colorText) => TextSpan(
        text: text,
        style: TextStyle(
          fontStyle: FontStyle.italic,
          color: colorText ? spanColor : style?.color,
        ),
      );

  TextSpan _colorSpan(String text) => TextSpan(
        text: text,
        style: TextStyle(color: spanColor),
      );
}
