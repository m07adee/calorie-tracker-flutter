# Contributing

Thanks for your interest in improving Calorie Tracker! 🎉

## Workflow

1. **Fork** the repository and create a branch from `main`:
   ```bash
   git checkout -b feature/short-description
   ```
2. Make your changes (see the guidelines below).
3. Make sure everything passes locally:
   ```bash
   flutter gen-l10n
   flutter analyze
   flutter test
   ```
4. Commit with a clear message and open a **Pull Request** describing what changed and why. Screenshots are appreciated for UI changes.

## Guidelines

- **Architecture:** keep the layers separate — UI in `lib/features/`, state in `lib/providers/`, data access in `lib/data/`, pure logic in `lib/domain/`.
- **No hardcoded text:** every user-facing string goes into **all three** ARB files (`app_en.arb`, `app_ar.arb`, `app_tr.arb`).
- **RTL-friendly layouts:** use `EdgeInsetsDirectional`, `AlignmentDirectional` and `start`/`end` instead of `left`/`right`.
- **Secrets:** never commit `google-services.json`, keystores or API keys.
- **Tests:** add or update widget/unit tests for new behavior when possible.

## Reporting bugs

Open an issue with the steps to reproduce, what you expected, what happened, your device/Android version, and the app language you were using.
