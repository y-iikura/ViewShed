module sisen
	implicit none
	integer, parameter :: imax=1000,jmax=1000
	real, parameter :: dx=10.0,dy=10.0,pie=3.1415927
	integer,dimension(imax,jmax) :: VAL,VISIT
	real,dimension(imax,jmax) :: DEM
! VISIT :: dummy

contains
    integer function point_view(is,js,ie,je)
	integer is,js,ie,je
	integer x,y,x1,x2,y1,y2
	integer ise,jse
	integer inc
	real xx,yy,dx,dy
	real zs,ze,za,zb,z1,z2

	zs=DEM(is,js)
	ze=DEM(ie,je)
	ise=abs(is-ie) ; jse=abs(js-je)
!	write(*,*) ise,jse
	inc=1 ; point_view=1
	if (max(ise,jse).le.1) then
		point_view=0 ; return
	endif
	if (ise .ge. jse) then
		if (is .ge. ie) then
			inc=-inc
		endif
!		do x=is+inc,ie-inc,inc
		do x=ie-inc,is+inc,-inc
			xx=real(x) 
			yy=js+(je-js)*(xx-is)/(ie-is)
			y1=int(yy) ; y2=y1+1 ; dy=yy-y1
			za=zs+(ze-zs)*(xx-is)/(ie-is)
			z1=DEM(x,y1) ; z2=DEM(x,y2)
			zb=z1+(z2-z1)*dy
			if (zb .gt. za) then 
				point_view=0 ; return
			endif
		enddo
	else
		if (js .ge. je) then
			inc=-inc
		endif
!		do y=js+inc,je-inc,inc
		do y=je-inc,js+inc,-inc
			yy=real(y) 
			xx=is+(ie-is)*(yy-js)/(je-js)
			x1=int(xx) ; x2=x1+1 ; dx=xx-x1
			za=zs+(ze-zs)*(yy-js)/(je-js)
			z1=DEM(x1,y) ; z2=DEM(x2,y)
			zb=z1+(z2-z1)*dx
			if (zb .gt. za) then 
				point_view=0 ; return
			endif
		enddo
	endif
	return
    end function point_view

    subroutine view(is,js)
	integer is,js
	integer ie,je
	VAL=0
	do je=3,jmax-2
	do ie=3,imax-2
		VAL(ie,je)=point_view(is,js,ie,je)
	enddo
	enddo
    end subroutine view

end module sisen
