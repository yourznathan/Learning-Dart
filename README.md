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
│   ├── bin/cli.dart         # Entry point: hands arguments to CommandRunner
│   ├── lib/cli.dart
│   ├── test/cli_test.dart
│   └── pubspec.yaml         # Depends on http + the local command_runner package
│
└── command_runner/          # A reusable package for parsing and running commands
    ├── lib/
    │   ├── command_runner.dart          # Public API (barrel file)
    │   └── src/command_runner_base.dart # CommandRunner implementation
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
| Static analysis with `dart analyze` and the `lints` package | `analysis_options.yaml` |

---

## 🚀 Getting started

**Prerequisites:** [Dart SDK](https://dart.dev/get-dart) 3.13 or later.

```bash
git clone https://github.com/yourznathan/Learning-Dart.git
cd Learning-Dart/dartpedia/cli
dart pub get
dart run bin/cli.dart version
```

Right now the CLI passes its arguments to `CommandRunner`, which echoes them
back:

```
$ dart run bin/cli.dart search dart
CommandRunner received arguments: [search, dart]
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
- [ ] Define `Command`, `Argument` and `Option` classes in `command_runner`
- [ ] Re-implement `help`, `version` and `search` as commands
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
- [Creating packages](https://dart.dev/tools/pub/create-packages)
