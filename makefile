all: 
	gcc ./bin/build.c -o ./bin/build

build: all
	./bin/build

clean:
	rm ./bin/build
