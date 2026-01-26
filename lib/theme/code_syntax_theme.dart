import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../extension/brightness_extension.dart';
import '../extension/common_extension.dart';

final atomOneLightTheme = CodeSyntaxThemeExtension.fromMap(
  doctag: const TextStyle(color: Color(0xffa626a4)),
  keyword: const TextStyle(color: Color(0xffa626a4)),
  formula: const TextStyle(color: Color(0xffa626a4)),
  section: const TextStyle(color: Color(0xffe45649)),
  name: const TextStyle(color: Color(0xffe45649)),
  selectorTag: const TextStyle(color: Color(0xffe45649)),
  deletion: const TextStyle(color: Color(0xffe45649)),
  subst: const TextStyle(color: Color(0xffe45649)),
  literal: const TextStyle(color: Color(0xff0184bb)),
  string: const TextStyle(color: Color(0xff50a14f)),
  regexp: const TextStyle(color: Color(0xff50a14f)),
  addition: const TextStyle(color: Color(0xff50a14f)),
  attribute: const TextStyle(color: Color(0xff50a14f)),
  metaString: const TextStyle(color: Color(0xff50a14f)),
  builtIn: const TextStyle(color: Color(0xffc18401)),
  attr: const TextStyle(color: Color(0xff986801)),
  variable: const TextStyle(color: Color(0xff986801)),
  templateVariable: const TextStyle(color: Color(0xff986801)),
  type: const TextStyle(color: Color(0xff986801)),
  selectorClass: const TextStyle(color: Color(0xff986801)),
  selectorAttr: const TextStyle(color: Color(0xff986801)),
  selectorPseudo: const TextStyle(color: Color(0xff986801)),
  number: const TextStyle(color: Color(0xff986801)),
  symbol: const TextStyle(color: Color(0xff4078f2)),
  bullet: const TextStyle(color: Color(0xff4078f2)),
  link: const TextStyle(color: Color(0xff4078f2)),
  meta: const TextStyle(color: Color(0xff4078f2)),
  selectorId: const TextStyle(color: Color(0xff4078f2)),
  title: const TextStyle(color: Color(0xff4078f2)),
  comment: const TextStyle(color: Color(0xffa0a1a7), fontStyle: FontStyle.italic),
  quote: const TextStyle(color: Color(0xffa0a1a7), fontStyle: FontStyle.italic),
);

final atomOneDarkTheme = CodeSyntaxThemeExtension.fromMap(
  doctag: const TextStyle(color: Color(0xffc678dd)),
  keyword: const TextStyle(color: Color(0xffc678dd)),
  formula: const TextStyle(color: Color(0xffc678dd)),
  section: const TextStyle(color: Color(0xffe06c75)),
  name: const TextStyle(color: Color(0xffe06c75)),
  selectorTag: const TextStyle(color: Color(0xffe06c75)),
  deletion: const TextStyle(color: Color(0xffe06c75)),
  subst: const TextStyle(color: Color(0xffe06c75)),
  literal: const TextStyle(color: Color(0xff56b6c2)),
  string: const TextStyle(color: Color(0xff98c379)),
  regexp: const TextStyle(color: Color(0xff98c379)),
  addition: const TextStyle(color: Color(0xff98c379)),
  attribute: const TextStyle(color: Color(0xff98c379)),
  metaString: const TextStyle(color: Color(0xff98c379)),
  builtIn: const TextStyle(color: Color(0xffe6c07b)),
  attr: const TextStyle(color: Color(0xffd19a66)),
  variable: const TextStyle(color: Color(0xffd19a66)),
  templateVariable: const TextStyle(color: Color(0xffd19a66)),
  type: const TextStyle(color: Color(0xffd19a66)),
  selectorClass: const TextStyle(color: Color(0xffd19a66)),
  selectorAttr: const TextStyle(color: Color(0xffd19a66)),
  selectorPseudo: const TextStyle(color: Color(0xffd19a66)),
  number: const TextStyle(color: Color(0xffd19a66)),
  symbol: const TextStyle(color: Color(0xff61afef)),
  bullet: const TextStyle(color: Color(0xff61afef)),
  link: const TextStyle(color: Color(0xff61afef)),
  meta: const TextStyle(color: Color(0xff61afef)),
  selectorId: const TextStyle(color: Color(0xff61afef)),
  title: const TextStyle(color: Color(0xff61afef)),
  comment: const TextStyle(color: Color(0xff5c6370), fontStyle: FontStyle.italic),
  quote: const TextStyle(color: Color(0xff5c6370), fontStyle: FontStyle.italic),
);

class CodeSyntaxThemeExtension extends _MapThemeData<String, TextStyle> {
  const CodeSyntaxThemeExtension._(super.base);

  factory CodeSyntaxThemeExtension.fromMap({
    required TextStyle comment,
    required TextStyle quote,
    required TextStyle doctag,
    required TextStyle keyword,
    required TextStyle formula,
    required TextStyle section,
    required TextStyle name,
    required TextStyle selectorTag,
    required TextStyle deletion,
    required TextStyle subst,
    required TextStyle literal,
    required TextStyle string,
    required TextStyle regexp,
    required TextStyle addition,
    required TextStyle attribute,
    required TextStyle metaString,
    required TextStyle builtIn,
    required TextStyle attr,
    required TextStyle variable,
    required TextStyle templateVariable,
    required TextStyle type,
    required TextStyle selectorClass,
    required TextStyle selectorAttr,
    required TextStyle selectorPseudo,
    required TextStyle number,
    required TextStyle symbol,
    required TextStyle bullet,
    required TextStyle link,
    required TextStyle meta,
    required TextStyle selectorId,
    required TextStyle title,
    TextStyle? emphasis,
    TextStyle? strong,
  }) {
    return CodeSyntaxThemeExtension._({
      'comment': comment,
      'quote': quote,
      'doctag': doctag,
      'keyword': keyword,
      'formula': formula,
      'section': section,
      'name': name,
      'selector-tag': selectorTag,
      'deletion': deletion,
      'subst': subst,
      'literal': literal,
      'string': string,
      'regexp': regexp,
      'addition': addition,
      'attribute': attribute,
      'meta-string': metaString,
      'built_in': builtIn,
      'attr': attr,
      'variable': variable,
      'template-variable': templateVariable,
      'type': type,
      'selector-class': selectorClass,
      'selector-attr': selectorAttr,
      'selector-pseudo': selectorPseudo,
      'number': number,
      'symbol': symbol,
      'bullet': bullet,
      'link': link,
      'meta': meta,
      'selector-id': selectorId,
      'title': title,
      'emphasis': emphasis ?? TextStyle(fontStyle: FontStyle.italic),
      'strong': strong ?? TextStyle(fontWeight: FontWeight.bold),
    });
  }

  factory CodeSyntaxThemeExtension.from(Brightness brightness) {
    return brightness.isLight ? atomOneLightTheme : atomOneDarkTheme;
  }

  @override
  CodeSyntaxThemeExtension copyWith({Map<String, TextStyle>? values}) {
    return CodeSyntaxThemeExtension._(this..addAll(values ?? const {}));
  }

  @override
  CodeSyntaxThemeExtension lerp(CodeSyntaxThemeExtension? other, double t) {
    if (other == null) {
      return this;
    }



    final Map<String, TextStyle> result = {};
    for (final key in {...keys, ...other.keys}) {
      final TextStyle? a = lookup(key);
      final TextStyle? b = other.lookup(key);
      result[key] = TextStyle.lerp(a, b, t) ?? a!;
    }
    return CodeSyntaxThemeExtension._(result);
  }

  @override
  Object get type {
    return CodeSyntaxThemeExtension;
  }
}

abstract class _MapThemeData<K, V> extends DelegatingMap<K, V>
    with UnmodifiableMapMixin<K, V>
    implements ThemeExtension<_MapThemeData<K, V>> {
  const _MapThemeData(super.base);
}
