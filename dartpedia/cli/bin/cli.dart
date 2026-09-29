import 'dart:io'; // Is a core library that provides APIs to deal with files, directories, sockets and HTTP clients and servers, and more.
import 'package:http/http.dart' as http; // Is a package that provides a composable, Future-based API for making HTTP requests.

const version = '0.0.1';

void main(List<String> arguments) {
  if (arguments.isEmpty || arguments.first == 'help') {
    printUsage();
  } else if (arguments.first == 'version') {
    print('Dartpedia CLI version $version');
  } else if (arguments.first == 'search') {
    final inputArgs = arguments.length > 1 ? arguments.sublist(1) : null;
    searchWikipedia(inputArgs);
  } else {
    printUsage(); // Catch-all for unrecognized command.
  }
}

void searchWikipedia(List<String>? arguments) async{
  final String articleTitle;
  // If the user didn't pass in arguments, request an article title.
  if (arguments == null || arguments.isEmpty) {
    print('Please provide an article title');
    // Read input without the null colaescing fallback
    final inputFromStdin = stdin.readLineSync();
    if (inputFromStdin == null || inputFromStdin.isEmpty) {
      print('No article title provided. Exiting...');
      return;
    }
    articleTitle = inputFromStdin;
  } else {
    // Otherwise, join the arguments into a single string
    articleTitle = arguments.join(' ');
  }

  print('Looking up articles about "$articleTitle". Please wait...');
  
  // Call the API and await the result
  var articleContent = await getWikipediaArticle(articleTitle);
  print(articleContent); 
}

void printUsage() {
  print(
    "The following commands are valid: 'help', 'version', 'search <ARTICLE-TITLE>'"
  );
}

Future<String> getWikipediaArticle(String articleTitle) async {
  final url = Uri.https(
  'en.wikipedia.org', // Wikipedia API domain
  '/api/rest_v1/page/summary/$articleTitle', // API path/endpoint for fetching a summary of the article
  );
  final response = await http.get(url); // Make the HTTP request

  if (response.statusCode == 200) {
    return response.body; // Return the response body if successful
  }

  // Return an error message if the request failed
  return 'Error: Failed fetch article "$articleTitle". Status code: ${response.statusCode}';
}