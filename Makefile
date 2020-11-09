.PHONY: gen
gen:
	echo "Comment out the api dep in pubspec.yaml
	rm -rf api/
	flutter pub run build_runner build --delete-conflicting-outputs
	dart format .
