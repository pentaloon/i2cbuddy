based on https://iq.opengenus.org/create-shared-library-in-cpp/
steps to create an .so file with g++ and gcc
`g++ -c -o i2cdriver.o i2cdriver.c -fPIC`
`gcc -shared -o i2cdriver.so i2cdriver.o`
