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

class ArgResults {
  String? command;
  String? commandArg;
  Map<Option, Option?> options = {};

  // Returns true if the flag exists and is true
  bool flag (String name) {
    for (var option in options.keys.where(
      (option) => option.type == OptionType.flag,
    )) {
      if (option.name == name) {
        return options[option] as bool;
      }
    }
    return false;
  }

  bool hasOption(String name) {
    return options.keys.any((option) => option.name == name);
  }

  ({Option option, Object? input}) getOption(String name) {
    var mapEntry = options.entries.firstWhere(
      (entry) => entry.key.name == name || entry.key.abbr == name,
    );

    return (option: mapEntry.key, input: mapEntry.value);
  }
}