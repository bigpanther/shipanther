run:
	flutter run --flavor dev
extract-arb:
	flutter pub run intl_translation:extract_to_arb --output-dir=i18n/ lib/l10n/shipanther_localization.dart
	@echo "Don't forget to add @@locale on new locale file is when adding a new locale"
generate-from-arb:
	rm -f i18n/intl_messages.arb
	flutter pub run intl_translation:generate_from_arb --output-dir=lib/l10n/locales --no-use-deferred-loading lib/l10n/shipanther_localization.dart i18n/intl_*.arb
release: clean
	flutter build appbundle
clean:
	flutter clean
