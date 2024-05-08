# wheelmap

Basic description 0f the project will be here...

## Things to do after cloning app

1) Copy .env.example file and rename it to .env and add your api keys

2) Run the following command:

```sh
 fvm flutter pub run flutter_native_splash:create
```

## Replicate share

To replicate the share link functionality of plan, run the following command on the terminal while running the app on the device/simulator

```sh
adb shell 'am start -a android.intent.action.VIEW -c android.intent.category.BROWSABLE -d "http://accessiwheel.com/plan"' com.example.wheelmap
```

## :rocket: Setup

Please follow the instructions on the Flutter [website](https://flutter.dev/docs/get-started/install) for environment setup guideline.

### Clone the Project

After you set up everything you have to clone the project from git. That can be done via your IDE or via a command line:

```sh
git clone https://gitlab.rz.uni-bamberg.de/mobi/teaching/sose2023/digitalhealth/wheelmap.git
```

## :rocket: Run Project in a Terminal

To enable Flutter Version Manager(FVM), Please use

```sh
dart pub global activate fvm
```

To configure IDE with FVM, Please follow this link [here](https://fvm.app/docs/getting_started/configuration)

Details about FVM is written [here](https://fvm.app/docs/getting_started/overview)

To enable production mode, run

```sh
fvm flutter run --dart-define=mode=production
```

Production mode will fire HTTP requests to the backend in the future. Initially, the mock API will be used from local json file.

By default, the app will run with `development` mode enabled. Dev mode means that no requests to the real HTTP backend are fired. Instead, the local file `*.json` is used to populate the screens with necessary data.

```sh
 // this command will run the app automatically in dev mode
fvm flutter run
```

## :bug: Testing

In general, test files should reside inside a test folder located at the root of your Flutter application or package.
Test files should always end with `_test.dart`, this is the convention used by the test runner when searching for tests.

### Run Tests in a Terminal

Running a single test file:

```sh
fvm flutter test test/widget/file_name_test.dart
```

Running all test files inside a folder:

```sh
fvm flutter test test
```

Running all test files inside a subfolder:

```sh
fvm flutter test test/unit/file_name
```
