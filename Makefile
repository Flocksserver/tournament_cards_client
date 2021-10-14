build-wasm:
	cd wasm && wasm-pack build --target web --out-dir ../website/web/wasm

run-website:
	make build-wasm
	cd website && flutter run -d chrome --no-sound-null-safety

build-website:
	make build-wasm
	cd website && flutter build web --no-sound-null-safety

push-website:
	make build-wasm
	make build-website
	cd website && aws s3 sync build/web/ s3://ttc-match-generator --acl public-read --profile flocksserver