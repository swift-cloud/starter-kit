build:
	swift build -c debug --triple wasm32-unknown-wasi

hello: build
	fastly compute serve --skip-build --file ./.build/debug/Hello.wasm

proxy: build
	fastly compute serve --skip-build --file ./.build/debug/Proxy.wasm

tokamak: build
	fastly compute serve --skip-build --file ./.build/debug/Tokamak.wasm
