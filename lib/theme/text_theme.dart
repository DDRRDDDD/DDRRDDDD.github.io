import 'package:flutter/material.dart';

const defaultTextTheme = TextThemeExtension._(
  heroTitle: TextStyle(
    fontWeight: FontWeight.w900,
    fontSize: 60.0,
    height: 1.1,
  ),
  heroBadge: TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 14.0,
  ),
  sectionTitle: TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 30.0,
  ),
  sectionDescription: TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 16.0,
    letterSpacing: -0.2,
    height: 1.5,
  ),
  cardTitle: TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 20.0,
    letterSpacing: -0.3,
  ),
  timelineTitle: TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 18.0,
    letterSpacing: -0.3,
  ),
  bodyLead: TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 18.0,
    letterSpacing: -0.3,
    height: 1.6,
  ),
  bodyRegular: TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14.0,
    letterSpacing: -0.2,
    height: 1.5,
  ),
  buttonText: TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 16.0,
  ),
  labelSmall: TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 12.0,
    letterSpacing: -0.1,
  ),
);

class TextThemeExtension extends ThemeExtension<TextThemeExtension> {
  final TextStyle heroTitle;
  final TextStyle heroBadge;
  final TextStyle sectionTitle;
  final TextStyle sectionDescription;
  final TextStyle cardTitle;
  final TextStyle timelineTitle;
  final TextStyle bodyLead;
  final TextStyle bodyRegular;
  final TextStyle buttonText;
  final TextStyle labelSmall;

  factory TextThemeExtension.defaultTheme() => defaultTextTheme;

  const TextThemeExtension._({
    required this.heroTitle,
    required this.heroBadge,
    required this.sectionTitle,
    required this.sectionDescription,
    required this.cardTitle,
    required this.timelineTitle,
    required this.bodyLead,
    required this.bodyRegular,
    required this.buttonText,
    required this.labelSmall,
  });

  @override
  TextThemeExtension copyWith({
    TextStyle? heroTitle,
    TextStyle? heroBadge,
    TextStyle? sectionTitle,
    TextStyle? sectionDescription,
    TextStyle? cardTitle,
    TextStyle? timelineTitle,
    TextStyle? bodyLead,
    TextStyle? bodyRegular,
    TextStyle? buttonText,
    TextStyle? labelSmall,
  }) {
    return TextThemeExtension._(
      heroTitle: heroTitle ?? this.heroTitle,
      heroBadge: heroBadge ?? this.heroBadge,
      sectionTitle: sectionTitle ?? this.sectionTitle,
      sectionDescription: sectionDescription ?? this.sectionDescription,
      cardTitle: cardTitle ?? this.cardTitle,
      timelineTitle: timelineTitle ?? this.timelineTitle,
      bodyLead: bodyLead ?? this.bodyLead,
      bodyRegular: bodyRegular ?? this.bodyRegular,
      buttonText: buttonText ?? this.buttonText,
      labelSmall: labelSmall ?? this.labelSmall,
    );
  }

  @override
  TextThemeExtension lerp(TextThemeExtension? other, double t) {
    if (other == null) {
      return this;
    }

    return TextThemeExtension._(
      heroTitle: TextStyle.lerp(heroTitle, other.heroTitle, t)!,
      heroBadge: TextStyle.lerp(heroBadge, other.heroBadge, t)!,
      sectionTitle: TextStyle.lerp(sectionTitle, other.sectionTitle, t)!,
      sectionDescription: TextStyle.lerp(sectionDescription, other.sectionDescription, t)!,
      cardTitle: TextStyle.lerp(cardTitle, other.cardTitle, t)!,
      timelineTitle: TextStyle.lerp(timelineTitle, other.timelineTitle, t)!,
      bodyLead: TextStyle.lerp(bodyLead, other.bodyLead, t)!,
      bodyRegular: TextStyle.lerp(bodyRegular, other.bodyRegular, t)!,
      buttonText: TextStyle.lerp(buttonText, other.buttonText, t)!,
      labelSmall: TextStyle.lerp(labelSmall, other.labelSmall, t)!,
    );
  }
}