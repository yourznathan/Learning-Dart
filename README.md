# Learning Dart 🎯

![Dart](https://img.shields.io/badge/Dart-3.13-0175C2?logo=dart&logoColor=white)
![Platform](https://img.shields.io/badge/platform-CLI-lightgrey)
![Status](https://img.shields.io/badge/status-in%20progress-yellow)

A hands-on log of my first steps with **Dart**, working through the official
[Dart "Get started" tutorial](https://dart.dev/get-started) by building
**Dartpedia**, a command-line tool that looks up articles on Wikipedia.

I'm learning Dart to prepare for my final-year university project: a
**zero-knowledge password manager** built with **Flutter**. This repo is where
I get comfortable with the language before moving on to Flutter.

---

## 📁 Project structure

```
dartpedia/
├── cli/                     # The Dartpedia command-line app
│   ├── bin/cli.dart         # Entry point: registers commands and runs them
│   ├── lib/cli.dart
│   ├── test/cli_test.dart
│   └── pubspec.yaml         # Depends on http + the local command_runner package
│
└── command_runner/          # A reusable package for parsing and running commands
    ├── lib/
    │   ├── command_runner.dart          # Public API (barrel file)
    │   └── src/
    │       ├── arguments.dart           # CliElement, Command, Option, ArgResults
    │       ├── command_runner_base.dart # CommandRunner: registers & dispatches commands
    │       └── help_command.dart        # HelpCommand, the first concrete Command
    ├── example/
    ├── test/
    └── pubspec.yaml
```

The app is split into two packages. `cli` is the executable, and
`command_runner` is a library it uses through a **local path dependency**:

```yaml
dependencies:
  command_runner:
    path: ../command_runner
```

### How the classes fit together

```
            CliElement  (abstract)
            name · help · defaultValue · valueHelp · usage
               ▲                        ▲
               │ extends                │ extends
     Command  (abstract)              Option
     description · options            type (flag | option) · abbr
     addFlag() · addOption()
     run(ArgResults)  ← each subclass implements this
               ▲
               │ extends
          HelpCommand
```

`CommandRunner` keeps a map of registered `Command`s. When the program runs,
it parses the arguments into an `ArgResults`, looks up the matching command,
and calls its `run()` method. Each subclass supplies its own behaviour with
`@override`.

---

## 🧠 What I've learned so far

| Topic | Where it shows up |
| --- | --- |
| Project scaffolding with `dart create` (console apps and packages) | `cli/`, `command_runner/` |
| `main(List<String> arguments)` and handling command-line arguments | `cli/bin/cli.dart` |
| Control flow: `if` / `else if` command routing, `help` / `version` / `search` commands | Commit history (`debf4a9` → `17d3e8c`) |
| **Null safety**: nullable types (`List<String>?`), null checks, `final` with late assignment | `searchWikipedia()` |
| Reading user input with `stdin.readLineSync()` from `dart:io` | `searchWikipedia()` |
| **Async programming**: `Future`, `async` / `await` | `getWikipediaArticle()`, `CommandRunner.run()` |
| HTTP requests with `package:http` and building URIs with `Uri.https` | Wikipedia REST API call |
| Adding dependencies from pub.dev and `pubspec.yaml` / `pubspec.lock` | `cli/pubspec.yaml` |
| **Packages and libraries**: `lib/src/` privacy, `export` barrel files, path dependencies | `command_runner/` |
| **Classes and constructors**: fields, getters, named and `required` parameters, `this.` initialisers | `Option` in `arguments.dart` |
| **Abstract classes**: bodiless getters and methods that define a contract for subclasses | `CliElement`, `Command` |
| **Inheritance** with `extends`, across a multi-level hierarchy (`CliElement` → `Command` → `HelpCommand`) | `arguments.dart`, `help_command.dart` |
| **`@override`**: implementing inherited getters, fields and methods (`name`, `usage`, `run()`) | `Option`, `Command`, `HelpCommand` |
| **Polymorphism**: `CommandRunner` calls `run()` on any `Command` without knowing its concrete type | `command_runner_base.dart` |
| Enums (`OptionType`), `late` fields, records (`({Option option, Object? input})`) | `arguments.dart` |
| Encapsulation: private `_` members exposed through read-only `UnmodifiableSetView` getters | `Command.options`, `CommandRunner.commands` |
| Cascade notation (`..addCommand()`) and `FutureOr<T>` | `cli/bin/cli.dart`, `Command.run()` |
| Static analysis with `dart analyze` and the `lints` package | `analysis_options.yaml` |

---

## 🚀 Getting started

**Prerequisites:** [Dart SDK](https://dart.dev/get-dart) 3.13 or later.

```bash
git clone https://github.com/yourznathan/Learning-Dart.git
cd Learning-Dart/dartpedia/cli
dart pub get
dart run bin/cli.dart help
```

`help` is the first command rebuilt on top of `command_runner`. It lists every
registered command:

```
$ dart run bin/cli.dart help
Usage: dart bin/cli.dart <command> [commandArg?] [...options?]
 help: Prints usage information to the command line.
```

Run the tests with:

```bash
dart test
```

---

## 🗺️ Roadmap

The first working version handled `help`, `version` and `search` directly in
`main()`, and fetched article summaries from the Wikipedia REST API. I then
moved argument handling into the separate `command_runner` package, so the
next steps are to rebuild those features on top of it:

- [x] Basic CLI with `help`, `version` and `search` commands
- [x] Fetch article summaries from Wikipedia over HTTP
- [x] Extract argument handling into a reusable `command_runner` package
- [x] Define the `CliElement`, `Command` and `Option` class hierarchy and `ArgResults`
- [x] Register commands with `CommandRunner` and implement `HelpCommand`
- [ ] Parse flags and options (e.g. `help --verbose`) into `ArgResults`
- [ ] Re-implement `version` and `search` as commands
- [ ] Parse the Wikipedia JSON response into Dart model classes
- [ ] Error handling with exceptions
- [ ] Unit tests for the command runner
- [ ] ➡️ Move on to **Flutter** and the password manager

---

## 📚 Resources

- [Dart language tour](https://dart.dev/language)
- [Dart "Get started" tutorial](https://dart.dev/get-started)
- [Sound null safety](https://dart.dev/null-safety)
- [Asynchronous programming: futures, async, await](https://dart.dev/libraries/async/async-await)
- [Classes](https://dart.dev/language/classes) and [extending a class](https://dart.dev/language/extend)
- [Creating packages](https://dart.dev/tools/pub/create-packages)
