# Vakil (وکیل)

A Persian (Farsi) Android application for searching laws, regulations and
legal information, built with Flutter.

## Current stage

**STEP 1 — Flutter project foundation.**

What exists right now:

- Persian (Farsi) user interface with a global RTL layout direction.
- Material 3 theme with a professional, clean look.
- A home screen with the application title (وکیل), the subtitle
  «جستجوی قوانین و مقررات», a rounded search input (hint: «مثلاً مهندس»)
  and a search button (جستجو).
- Pressing the search button only shows a placeholder message
  («قابلیت جستجو در مرحله بعد فعال می‌شود.»). No real search, no network
  request and no WebView is implemented yet.

## Planned future stages

- WebView integration
- Connection to rc.majlis.ir
- searchAjax endpoint
- JSON parsing
- Search results screen
- Legal document details
- APK build automation

None of the above is implemented in this step.

## Building the APK (GitHub Actions)

This repository does **not** require a local Flutter installation. The
Android platform files and the release APK are produced by GitHub Actions.

1. Create a GitHub repository and push (or upload) the files of this folder
   to it.
2. Open the **Actions** tab → workflow **Build Android APK**. It runs on
   every push and can also be started manually (*Run workflow*).
3. When the run finishes, download the **vakil-release-apk** artifact from
   the run summary page and unzip it to get `app-release.apk`.

The workflow:

- installs the latest stable Flutter SDK (Dart ≥ 3.10) and Temurin JDK 17;
- generates the Android platform files with
  `flutter create --platforms=android --project-name=vakil .`
  (existing source files are kept, only the missing Android platform folder
  is created);
- configures `AndroidManifest.xml`: application label `وکیل` and the
  `INTERNET` permission (needed for future steps, no network request is
  made yet);
- runs `flutter pub get`, `flutter analyze` and `flutter test`;
- runs `flutter build apk --release`;
- uploads `build/app/outputs/flutter-apk/app-release.apk` as the artifact
  `vakil-release-apk`.

## Building locally (optional)

Requires a Flutter SDK (Dart ≥ 3.10) with the Android toolchain. The
Android platform folder must be generated once:

```
flutter create --platforms=android --project-name=vakil .
flutter pub get
flutter analyze
flutter test
flutter build apk --release
```

After that, apply the same manifest changes as the workflow (label `وکیل`,
`INTERNET` permission) if you build locally.

## Project structure

```
lib/
  main.dart            App entry point, Material 3 theme, global RTL setup
  screens/
    home_screen.dart   Home screen (title, subtitle, search form)
  widgets/
    search_box.dart    Rounded Persian search input
  models/              (reserved for future steps)
  services/            (reserved for future steps)
  utils/               (reserved for future steps)
test/
  widget_test.dart     Widget tests for the home screen
.github/workflows/
  build-apk.yml        CI workflow that builds and uploads the release APK
```

## Technical notes

- Package name / application id: `com.example.vakil` (Flutter default).
  It can be changed later by adjusting the `--org` value of
  `flutter create` in the workflow.
- The Android `INTERNET` permission is declared for the future
  rc.majlis.ir integration; the app currently makes no network requests.
- RTL direction is enforced globally through `MaterialApp.builder` with a
  `Directionality` widget, so every future screen inherits the Persian
  right-to-left layout automatically.
- No `dart:html`, no WebView, no backend and no extra packages are used.
