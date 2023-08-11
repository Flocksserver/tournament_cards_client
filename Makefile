build-wasm:
	cd wasm && wasm-pack build --target web --out-dir ../website/web/wasm

run-website:
	make build-wasm
	cd website && flutter run -d chrome

build-website:
	make build-wasm
	cd website && flutter build web

push-website:
	make build-wasm
	make build-website
	cd website && aws s3 sync build/web/ s3://ttc-match-generator --acl public-read --profile flocksserver