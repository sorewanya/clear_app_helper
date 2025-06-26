import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum Comparison {
  equal,
  notEqual,
  greaterThan,
  greaterThanOrEqual,
  lessThan,
  lessThanOrEqual,
  ;

  static String fromComparison(Comparison c) => switch (c) {
        Comparison.equal => "=",
        Comparison.notEqual => "!=",
        Comparison.greaterThan => ">",
        Comparison.greaterThanOrEqual => ">=",
        Comparison.lessThan => "<",
        Comparison.lessThanOrEqual => "<=",
      };

  static Comparison fromString(String string) => switch (string) {
        "=" => Comparison.equal,
        "!=" => Comparison.notEqual,
        ">" => Comparison.greaterThan,
        ">=" => Comparison.greaterThanOrEqual,
        "<" => Comparison.lessThan,
        "<=" => Comparison.lessThanOrEqual,
        _ => Comparison.equal,
      };
}
