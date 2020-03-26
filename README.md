# Flutter News App
Repo to showcase how to build a news app with async_redux

## Motivation
The Motivation for this App is to showcase how to build News App using Flutter and how to implement Statemenagement using async_redux.  

## Installing
As a showcase App the App is neither available in the AppStore nor in the PlayStore and it is not sure if it ever will be.
Nontheless you may install the App using the prebuild-binaries provided to you here on Github or build it yourself.

### Installing using the binaries
Head over to the `Releases` and fetch the binary that fits your device, download and install.

### Building the App yourself

First of I assume you are familiar with flutter and have it installed.
If you don't have it installed yet head over to [flutter.dev](https://flutter.dev/docs/get-started/install).

Make sure you have the at least `flutter` command in your `PATH VARIABLE`.
A quick Google search will show you how to do that for your OS.

#### Get the source code
Get the source code by downloading it as a zip or running `git clone https://github.com/glassp/flutter_news.git`.
In the following `$SourceLocation` is the path you downloaded the sourcecode to.

#### Actually building the app
Open the Terminal and change the directory to `$SourceLocation` make sure `pubspec.yaml` is in that location too.
Type `flutter pub get` to fetch the dependencies.
Then execute `flutter build <buildType>` where `<buildType>` is one of the buildTypes displayed by `flutter build --help`.  
