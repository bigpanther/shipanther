.PHONY: run
run:
	flutter run --flavor dev
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
	flutter build appbundle --flavor dev --no-shrink
release-dev-ios:
	flutter build ipa --flavor dev --release
release-dev-web:
	flutter build web --base-href=/ --release
release-dev: clean release-dev-android release-dev-ios release-dev-web
.PHONY: clean
clean:
	flutter clean
.PHONY: lint
lint:
	flutter analyze
.PHONY: test
test:
	flutter test -v
