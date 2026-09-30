enum OptionType { flag, option }

abstract class CliElement {
  // Getters without bodies define required properties that every subclass must implement.
  String get name;
  String? get help;
  // In the case of flags, the default value is a bool.
  // In other options and commands, the default value is a String.
  // NB: flags are just Option objects that don't take arguments.
  Object? get defaultValue;
  String? get valueHelp;

  String get usage;
}

class Option extends CliElement {
  // Constructor - Instantiates new Option objects (Eg: name and type)
  Option(
    this.name, {
    required this.type,
    this.help,
    this.abbr,
    this.defaultValue,
    this.valueHelp,
  });

  // Fields
  @override
  final String name;

  final OptionType type;

  @override
  final String? help; // Nullable types (String?)

  final String? abbr;

  @override
  final String? defaultValue;
  @override
  final String? valueHelp;

  // Getter
  @override
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