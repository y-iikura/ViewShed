;cd /Volumes/iikura/TEST
;PATH=$PATH:/Applications/exelis/idl85/bin:~/bin
;idl check.pro -args kiban50_450F.tif 435 383
common pdata,dem,imax,jmax,dview.compile 'IDL/view_util.pro'

num=3
param=command_line_args(count=num)
;help,param
reads,param[1],ix0
reads,param[2],iy0
ix0=fix(ix0)
iy0=fix(iy0)
help,ix0,iy0

;fname='kiban50_450F.tif'
fname=param[0]
dem=read_tiff(fname,geotiff=ginfo)
size=size(dem)
imax=size[1] & jmax=size[2]

!order=1window,1,xsize=500,ysize=500plot,[0,1000],[0,1000],/nodata,/noerase,pos=[0,0,1,1],xstyle=5,ystyle=5
tvscl,congrid(dem,500,500)

B=''
read,B,Prompt='Continue(yes=1) : '
if B ne '1' then exit

select=1
flag=iteration(ix0,iy0,select)
while flag eq '1' do begin $
  read,ix0,iy0,Prompt='input ix and iy: ' & $
  flag=iteration(ix0,iy0,select) & $
endwhile
;ix0=435 & iy0=383;dview=bytarr(imax,jmax)+1B;hifuku,ix0,iy0;tvscl,congrid(dview,500,500)
;oplot,[i0],jmax-[j0],psym=2,color=255

;B=''
;read,B,Prompt='End(anykey) : '

exit

