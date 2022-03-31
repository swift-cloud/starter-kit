build:
	swift build -c debug --triple wasm32-unknown-wasi

serve: build
	fastly compute serve --skip-build --file ./.build/debug/starter-kit.wasm
