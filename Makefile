all: lint format

# Adding a help file: https://gist.github.com/prwhite/8168133#gistcomment-1313022
help: ## This help dialog.
	@IFS=$$'\n' ; \
	help_lines=(`fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//'`); \
	for help_line in $${help_lines[@]}; do \
		IFS=$$'#' ; \
		help_split=($$help_line) ; \
		help_command=`echo $${help_split[0]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
		help_info=`echo $${help_split[2]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
		printf "%-30s %s\n" $$help_command $$help_info ; \
	done

build_web:
	@flutter clean
	@npm install
	@npm run build
	@flutter pub get
	@flutter build web --web-renderer html --csp --release

run_unit: ## Runs unit tests
	@echo "╠ Running the tests"
	@flutter test || (echo "Error while running tests"; exit 1)

clean: ## Cleans the environment
	@echo "╠ Cleaning the project..."
	@rm -rf pubspec.lock
	@flutter clean
	@flutter pub get

fix_warnings: ## fix any warnings
	@echo "╠ Attempting to fix warnings..."
	@dart fix --dry-run
	@dart fix --apply
watch: ## Watches the files for changes
	@echo "╠ Watching the project..."
	@flutter pub run build_runner watch --delete-conflicting-outputs


gen: ## Generates the assets
	@echo "╠ Generating the assets..."
	@flutter pub get
	@flutter packages pub run build_runner build --delete-conflicting-outputs

format: ## Formats the code
	@echo "╠ Formatting the code"
	@dart format lib . -l 120
	@flutter pub run import_sorter:main
	@dart format . -l 120

lint: ## Lints the code
	@echo "╠ Verifying code..."
	@dart analyze . || (echo "Error in project"; exit 1)

upgrade: clean ## Upgrades dependencies
	@echo "╠ Upgrading dependencies..."
	@flutter pub upgrade

commit: format lint run_unit
	@echo "╠ Committing..."
	git add .
	git commit

analyze:
	flutter run dart_code_metrics:metrics analyze lib

ditto:
	echo "hello world"

validate_packages:
	@echo "╠ Validating packages..."
	@flutter pub get
	@flutter pub run dependency_validator

arm_mac_hard_clean:
	flutter clean && \
	flutter pub get && \
	cd ios && \
	sudo rm -r Pods/ && \
	rm -r .symlinks/ && \
	rm Podfile.lock && \
	sudo arch -x86_64 gem install ffi && \
	arch -x86_64 pod install && \
	cd ..

file_test:
	@reset
	@flutter test test/middleware_test.dart

nuclear_clean:
	@echo "╠ Nuking pubcache completely, this might take a while...."
	@flutter clean
	@flutter pub cache repair
	@flutter pub get

test_coverage:
	@flutter test --coverage
	@genhtml coverage/lcov.info -o coverage/html
	@open coverage/html/index.html
