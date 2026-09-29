const version = '0.0.1';

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print('Hello, Dart!');
  } else if (arguments.first == 'version') {
    print('Dartpedia CLI version $version');
  }
}

void printUsage() {
  print(
    "The following commands are valid: 'help', 'version', 'search <ARTICLE-TITLE>'"
  );
}