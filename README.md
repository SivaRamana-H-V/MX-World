# MX WORLD — Flutter Logistics App

A production-grade Flutter implementation of the **MX WORLD** global-logistics
marketing site, built from the five provided screen designs (Home/Portfolio,
About, Services, Global Network, Contact).

## Stack

| Concern          | Choice                                    |
| ---------------- | ----------------------------------------- |
| Architecture     | MVC (Model · View · Controller)         |
| State management | Riverpod (`flutter_riverpod`)           |
| Local storage    | Hive (`hive` + `hive_flutter`)        |
| Routing          | `go_router` (declarative, web/deeplink) |
| Typography       | `google_fonts` (Archivo + Inter)        |

The codebase follows the official Flutter
[AI rules](https://github.com/flutter/flutter/blob/main/docs/rules/rules.md):
SOLID composition, small private widget classes (no widget-returning helper
methods), `const` constructors, immutable models, layered separation, and
`Image.network` always wrapped with loading/error builders.

## Project structure

```
lib/
├── main.dart                       # Bootstraps Hive + Riverpod, runs the app
├── core/
│   ├── theme/                      # AppColors, AppTheme, AppPalette extension
│   ├── constants/                  # Spacing scale + responsive breakpoints
│   └── routing/                    # GoRouter table
├── models/                         # Immutable data classes (Model layer)
├── services/                       # ContentRepository + Hive storage (Data layer)
├── controllers/                    # Riverpod providers + InquiryController
└── views/
    ├── screens/                    # One folder per screen (View layer)
    │   ├── home/
    │   ├── about/
    │   ├── services/
    │   ├── global_network/
    │   └── contact/
    └── widgets/common/             # Reusable UI: nav, footer, buttons, stats…
```

### Layer responsibilities

- **Model** (`models/content_models.dart`) — plain immutable value objects with
  Hive-friendly `toMap`/`fromMap` (no generated adapters needed).
- **View** (`views/`) — stateless/Consumer widgets only; no business logic.
- **Controller** (`controllers/`) — `InquiryController` (a Riverpod
  `StateNotifier`) owns form state, validation, draft persistence, and
  submission.
- **Data** (`services/`) — `ContentRepository` supplies static content;
  `InquiryStorageService` wraps the Hive box. Both are injected, so they can be
  swapped for an API/CMS or faked in tests.

## State management flow (Contact form)

1. The form reads `inquiryControllerProvider` via a `ConsumerStatefulWidget`.
2. Each field change calls a controller method, which updates immutable state
   and writes a draft to Hive (survives app restarts).
3. `submit()` validates, persists the `ProjectInquiry` to Hive history, and
   flips `isSubmitted`, swapping the form for a confirmation panel.

## Running

```bash
flutter pub get
flutter run            # mobile / desktop
flutter run -d chrome  # web
```

## Testing

```bash
flutter test
```

Unit tests cover form validation and Hive serialization round-tripping.

## Notes

- Images use licensed Unsplash placeholders matching the logistics theme;
  swap the URLs in `services/content_repository.dart` for production assets.
- Theming supports light and dark via `ThemeData` + a custom `AppPalette`
  `ThemeExtension`; the app defaults to light (`ThemeMode.light`) since the
  designs are predominantly light-surface with dark hero/footer bands handled
  per-section.
- The Global Network screen is reachable from the **About → Global Network**
  CTA (`/network`).
