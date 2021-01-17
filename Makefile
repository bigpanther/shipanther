run:
	flutter run --flavor dev --no-sound-null-safety
run-prod:
	flutter run --flavor prod -t lib/main_prod.dart
extract-arb:
	flutter pub run intl_translation:extract_to_arb --output-dir=i18n/ lib/l10n/shipanther_localization.dart
	@echo "Don't forget to add @@locale on new locale file is when adding a new locale"
generate-from-arb:
	rm -f i18n/intl_messages.arb
	flutter pub run intl_translation:generate_from_arb --output-dir=lib/l10n/locales --no-use-deferred-loading lib/l10n/shipanther_localization.dart i18n/intl_*.arb
release-prod-android:
	flutter build appbundle --flavor prod -t lib/main_prod.dart
release-prod-ios:
	flutter build ios --flavor prod -t lib/main_prod.dart --release
release-prod: clean release-prod-android release-prod-ios
release-dev-android:
	flutter build appbundle --flavor dev --no-sound-null-safety
release-dev-ios:
	flutter build ios --flavor dev --release --no-sound-null-safety
release-dev: clean release-dev-android release-dev-ios
.PHONY: clean
clean:
	flutter clean
lint:
	flutter analyze
.PHONY: test
test:
	flutter test --no-sound-null-safety -v
