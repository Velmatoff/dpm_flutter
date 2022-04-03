get:
	@echo "Geting dependencies"
	@flutter pub get

pigeon: get
	@echo "Running codegen"
	flutter pub run pigeon \
	--input "pigeons/dpm.dart" \
	--dart_out "lib/src/dpm.g.dart" \
	--java_out "android/app/src/main/kotlin/com/example/dpm_flutter/Dpm.java" \
	--java_package "com.example.dpm" \
	--dart_null_safety

