import 'package:auto_hyphenating_text/auto_hyphenating_text.dart';
import 'package:flutter/material.dart';

void main() {
	runApp(const MyApp());
}

class MyApp extends StatelessWidget {
	const MyApp({super.key});

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'Auto Hyphenating Text Demo',
			theme: ThemeData(
				primarySwatch: Colors.blue,
			),
			home: const GermanExample(title: 'Auto Hyphenating Text Demo'),
		);
	}
}

class GermanExample extends StatelessWidget {
	const GermanExample({super.key, required this.title});

	final String title;

	@override
	Widget build(BuildContext context) {
		return DefaultHyphenationController(
			language: DefaultResourceLoaderLanguage.de1996,
		  child: Scaffold(
		  	appBar: AppBar(
		  		title: Text(title),
		  	),
		  	body: Center(
		  		child: AutoHyphenatingText('Ändern Sie die Größe dieses Fensters, um die automatische Silbentrennung in Aktion zu sehen.', style: Theme.of(context).textTheme.titleLarge),
		  	),
		  ),
		);
	}
}

class EnglishExample extends StatelessWidget {
	const EnglishExample({super.key, required this.title});

	final String title;

	@override
	Widget build(BuildContext context) {
		return DefaultHyphenationController(
		  child: Scaffold(
		  	appBar: AppBar(
		  		title: Text(title),
		  	),
		  	body: Center(
		  		child: AutoHyphenatingText('Resize this window to see autohyphenating text in action.', style: Theme.of(context).textTheme.titleLarge),
		  	),
		  ),
		);
	}
}




