# .Env to dart

This is a dart code generator for dot env (.env) files.

## Install

To install the builder, you have to add it 
in yours `builders` section of _pubspec.yaml_ file.
```yaml
name: example
description: A new Flutter project.
version: 0.0.1

environment:
  sdk: ">=2.1.0 <3.0.0"

builders:            # here
  dotenv2dart: any   # here

dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^0.1.2
```

## Usage

Create a `.env` file in your `/lib` folder and add your variables.

like:

```
myMultiplier=4
myAppName=My Awesome App
```

then, in your dart file you can reference the generated code as:

```dart
import 'dot_env.dart' as generated; // This dot_env.dart will be generated inside your .dart_tools folder 

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: generated.MY_APP_NAME,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: generated.MY_APP_NAME),
    );
  }
}
```


## TODO

- [ ] Enhance docs.
- [ ] Give example.
- [ ] Enhace readme.md for `/dotenv_to_dart/` folder
