pro	sisen,ix0,iy0
	for ix=point1[0]+1,imax-1 do begin
				if (iy eq 0) then dview[ix,iy]=0
	common pdata
	;ix0=435 & iy0=383
        else sisen,ix0,iy0
	oplot,[ix0],jmax-[iy0],psym=2,color=255

	B=''
	read,B,Prompt='Continue(yes=1) : '
	return,B
end
