#/bin/sh
cd Fortran
gfortran -c hifuku.f90
gfortran -c viewshed.f90
gfortran -o hifuku hifuku.o viewshed.o
gfortran -c viewshed2.f90
gfortran -c sisen.f90
gfortran -o sisen sisen.o viewshed2.o
