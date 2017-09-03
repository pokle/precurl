export PATH := ./node_modules/.bin:$(PATH)

## Dependencies
deps: node_modules bower_components

node_modules: package.json
	yarn

bower_components: bower.json
	bower install

## Production bundle
bundle: output/bundle.js

output/bundle.js: node_modules bower_components
	# pulp build --optimise --main Precurl | uglifyjs > output/bundle.js
	pulp build --modules Precurl --optimise --skip-entry-point --main Precurl --to $@

## Dev time tasks
test: deps
	pulp test

clean:
	rm -rf bower_components node_modules .pulp-cache output generated-docs

.PHONY: bundle test clean deps