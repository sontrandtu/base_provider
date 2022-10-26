echo "Hello, This is tool by manhtai831"
echo "Running..."
cd ../
flutter pub get
cd ./domain
flutter pub get
cd ../data
flutter pub get
cd ./dependencies/request-cache-manager
flutter pub get
cd ../../../dependencies
cd extensions
flutter pub get
cd ../firebase_manager
flutter pub get
cd ../image_picker_utils
flutter pub get
cd ../notifications
flutter pub get
cd ../permission_config
flutter pub get
cd ../state
flutter pub get
cd ../storage
flutter pub get
cd ../translator
flutter pub get
cd ../widgets
flutter pub get

echo "Completed. Thank you for using my tools."
