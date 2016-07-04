program main
!	use hifuku
	use sisen
	implicit none
	real t0,t1,temp
	integer is,js,sumval,k
	character arg*20
!	real ref
!	real,dimension(imax,jmax) :: REF
	if (iargc().ne.3) stop 'Argument number should be 3 !'
	call getarg(1,arg)
!	open(1,file="kiban50_450F.futm",form='unformatted')
	open(1,file=arg,form='unformatted')
	read(1) DEM
	close(1)
	call getarg(2,arg)
	read(arg,*) is
	call getarg(3,arg)
	read(arg,*) js
!	read(*,*) is,js
!	write(*,*) is,js,DEM(is,js),'m'
	call cpu_time(t0)
	call view(is,js)
	sumval=sum(VAL)
	call cpu_time(temp)
	write(*,*) temp-t0,'sec'
	open(2,file="sisen.img",form='unformatted')
	write(2) VAL
	close(2)
end program main



