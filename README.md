# Running the App (Dev & Prod)

This app has two Firebase environments: dev and prod.

## To run the dev version:
flutter run --flavor dev

## To run the prod (live) version:
flutter run --flavor prod

## What I did to set this up:
Created two Firebase projects: one for dev, one for prod

Added google-services.json for both:

- android/app/src/dev/google-services.json

- android/app/src/prod/google-services.json

Added GoogleService-Info.plist for both:

- ios/Runner/GoogleService-Info-Dev.plist

- ios/Runner/GoogleService-Info-Prod.plist

Set up build flavors and schemes for both Android and iOS

Wrote a build script on iOS to load the correct .plist based on the build


[//]: # (A few resources to get you started if this is your first Flutter project:)

[//]: # ()
[//]: # (- [Lab: Write your first Flutter app]&#40;https://docs.flutter.dev/get-started/codelab&#41;)

[//]: # (- [Cookbook: Useful Flutter samples]&#40;https://docs.flutter.dev/cookbook&#41;)

[//]: # ()
[//]: # (For help getting started with Flutter development, view the)

[//]: # ([online documentation]&#40;https://docs.flutter.dev/&#41;, which offers tutorials,)

[//]: # (samples, guidance on mobile development, and a full API reference.)

