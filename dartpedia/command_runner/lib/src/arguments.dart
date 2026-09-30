enum OptionType { flag, option } 

class Option {
  // Constructor - Instantiates new Option objects (Eg: name and type)
  Option(this.name, {
    required this.type,
    this.help,
    this.abbr,
    this.defaultValue,
    this.valueHelp,
  });

  // Fields
  final String name;
  final OptionType type;
  final String? help; // Nullable types (String?)
  final String? abbr;
  final String? defaultValue;
  final String? valueHelp;

  // Getter
  String get usage {
    if (abbr != null) {
      return '-$abbr,--$name: $help';
    }

    return '--$name: $help';
  }
}