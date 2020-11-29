X_BUILD_MODE=dev
if [[ "$CONFIGURATION" =~ prod$ ]]; then
X_BUILD_MODE=prod
fi
echo $X_BUILD_MODE
#cp -r "$PATH_TO_GOOGLE_PLISTS/$X_BUILD_MODE/GoogleService-Info.plist" "${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/GoogleService-Info.plist"
