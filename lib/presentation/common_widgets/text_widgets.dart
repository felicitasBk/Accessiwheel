import 'package:flutter/material.dart';

// Classes to create reusable text widgets

class SubtitleText extends StatelessWidget {
  final String text;

  const SubtitleText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}

class TextButtonLabel extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const TextButtonLabel({Key? key, required this.text, required this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
    );
  }
}

class RouteCardTitle extends StatelessWidget {
  final String text;

  const RouteCardTitle({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class RouteCardLocation extends StatelessWidget {
  final String text;

  const RouteCardLocation({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 12),
    );
  }
}

class RouteCardRating extends StatelessWidget {
  final String text;

  const RouteCardRating({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 12),
    );
  }
}

class RouteCardDescription extends StatelessWidget {
  final String text;

  const RouteCardDescription({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 12, color: Colors.black54),
      overflow: TextOverflow.ellipsis,
    );
  }
}

class SlidingUpPanelHighlights extends StatelessWidget {
  final String text;

  const SlidingUpPanelHighlights({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
