.PHONY: run
run:
	flutter run --flavor dev --no-sound-null-safety
run-prod:
	flutter run --flavor prod -t lib/main_prod.dart
.PHONY: l10n
l10n:
	flutter pub run intl_utils:generate
release-prod-android:
	flutter build appbundle --flavor prod -t lib/main_prod.dart
release-prod-ios:
	flutter build ipa --flavor prod -t lib/main_prod.dart --release
release-prod: clean release-prod-android release-prod-ios
release-dev-android:
	flutter build appbundle --flavor dev --no-sound-null-safety --no-shrink
release-dev-ios:
	flutter build ipa --flavor dev --release --no-sound-null-safety
release-dev-web:
	flutter build web --base-href=/ --release --no-sound-null-safety
release-dev: clean release-dev-android release-dev-ios release-dev-web
.PHONY: clean
clean:
	flutter clean
.PHONY: lint
lint:
	flutter analyze
.PHONY: test
test:
	flutter test --no-sound-null-safety -v
