.PHONY: antcc samples

antcc: clean
	@ echo "building antcc"
	@ dune build
	@ cp ./_build/default/src/antcc ./

clean:
	@ echo "removing _build folder"
	@ dune clean
	@ echo "removing ./antcc"
	@ rm -rf ./antcc

samples: antcc
	@ echo "compiling samples"
	./make_samples.sh