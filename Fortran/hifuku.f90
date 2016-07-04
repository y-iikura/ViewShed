module hifuku
	implicit none
	integer, parameter :: imax=1000,jmax=1000
	real, parameter :: dx=10.0,dy=10.0,pie=3.1415927
	integer,dimension(imax,jmax) :: VAL,VISIT
	real,dimension(imax,jmax) :: DEM

contains
    subroutine over_view(is,js,ie0,je0,ie1,je1)
	integer is,js,ie0,je0,ie1,je1,iend,jend
	integer x,y,xs,xe,ys,ye
	integer inc,check
	real xx,yy
	real zs,ze0,ze1,za,zb
	real a,b,c

	zs=DEM(is,js) ; ze0=DEM(ie0,je0) ; ze1=DEM(ie1,je1)
	a=((zs-ze0)*(js-je1)-(zs-ze1)*(js-je0))/((is-ie0)*(js-je1)-(is-ie1)*(js-je0))
	b=((zs-ze0)*(is-ie1)-(zs-ze1)*(is-ie0))/((js-je0)*(is-ie1)-(js-je1)*(is-ie0))
	c=zs-a*is-b*js
	if (je0 .eq. je1) then
		if (js .lt. je0) then
			inc=1 ; jend=jmax
		else
			inc=-1 ; jend=1
		endif
		do y=je0+inc,jend,inc
			yy=real(y) 
			if (ie0.lt.ie1) then 
				xs=is+(ie0-is)*(yy-js)/(je0-js)+1.0
				xe=is+(ie1-is)*(yy-js)/(je1-js)
			else
				xe=is+(ie0-is)*(yy-js)/(je0-js)
				xs=is+(ie1-is)*(yy-js)/(je1-js)+1.0
			endif
			if(xs.gt.imax) exit
			if(xe.lt.1) exit
			if(xe.gt.imax) xe=imax
			if(xs.lt.1) xs=1
			check=1
			do x=xs,xe
				za=DEM(x,y)
				zb=a*x+b*y+c
				if (zb .ge. za) then
					VAL(x,y)=0 ; check=0
				endif
			enddo
			if(check.eq.1) exit
		enddo
	endif
	if (ie0 .eq. ie1) then
		if (is .lt. ie0) then
			inc=1 ; iend=imax
		else
			inc=-1 ; iend=1
		endif
		do x=ie0+inc,iend,inc
			xx=real(x) 
			if(je0.lt.je1) then
				ys=js+(je0-js)*(xx-is)/(ie0-is)+1.0
				ye=js+(je1-js)*(xx-is)/(ie1-is)
			else
				ye=js+(je0-js)*(xx-is)/(ie0-is)
				ys=js+(je1-js)*(xx-is)/(ie1-is)+1.0
			endif
			if(ys.gt.jmax) exit
			if(ye.lt.1) exit
			if(ye.gt.jmax) ye=jmax
			if(ys.lt.1) ys=1
			check=1
			do y=ys,ye
				za=DEM(x,y)
				zb=a*x+b*y+c
				if (zb .ge. za) then
					VAL(x,y)=0 ; check=0
				endif
			enddo
			if(check.eq.1) exit
		enddo
	endif
	return
    end subroutine over_view

    subroutine view(is,js)
	integer is,js
	integer xe,ye,xe0,ye0
	integer dir,count

	VISIT=0 ; VAL=1
	VISIT(is,js)=1
	xe=is+1 ; ye=is
	xe0=is+1 ; ye0=js ; VISIT(xe0,ye0)=1
	dir=1 ; count=2
	do while(count.le.((imax-4)*(jmax-4)-1))
	    xe=xe0 ; ye=ye0
	    select case(dir) 
	      case(0)
	        xe=xe0+1 
	      case(1)
	        ye=ye0+1
	      case(2) 
	        xe=xe0-1
	      case(3)
	        ye=ye0-1
            end select
	    if (VISIT(xe,ye).eq.1) then
		xe=xe0 ; ye=ye0
		dir=mod(dir+3,4)
	    	select case(dir) 
	   	   case(0)
	   	     xe=xe0+1 
	 	   case(1)
	 	     ye=ye0+1
	 	   case(2) 
	   	     xe=xe0-1
	   	   case(3)
	   	     ye=ye0-1
            	end select
	    endif
	    if ((xe.gt.2).and.(xe.lt.(imax-1)).and.(ye.gt.2).and.(ye.lt.(jmax-1))) then
		if ((VAL(xe0,ye0).eq.1).or.(VAL(xe,ye).eq.1)) call over_view(is,js,xe0,ye0,xe,ye)
	    	VISIT(xe,ye)=1
	    	count=count+1
	    endif
	    xe0=xe ; ye0=ye
	    dir=mod(dir+1,4)
	end do
    end subroutine view
end module hifuku

	

