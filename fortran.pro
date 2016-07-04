;cd /Users/iikura/Desktop/ViewShed
;PATH=$PATH:/Applications/exelis/idl85/bin:~/bin
;idl fortran.pro -args kiban50_450F.tif 435 383

num=3
param=command_line_args(count=num)
fname=param[0]

print,fname
dem=read_tiff(fname,geotiff=ginfo)
pos=strpos(fname,'.')
fname2=strmid(fname,0,pos)+'.futm'
print,fname2

if (file_test(fname2) eq 0) then begin
  openw,2,fname2,/f77_unformatted
  writeu,2,dem
  close,2
;endif

dem2=fltarr(1000,1000)
openr,1,fname2,/f77_unformatted
readu,1,dem2
close,1
window,0,xsize=500,ysize=500
!order=1
tvscl,congrid(dem2,500,500),order=1
B=''
read,B,Prompt='Continue(yes=1) : '
if B ne '1' then exit

ix0=param[1]
iy0=param[2]
command='Fortran/hifuku '+fname2+' '+ix0+' '+iy0
print,command
spawn,command

view=fltarr(1000,1000)
openr,1,'hifuku.img',/f77_unformatted
readu,1,view
close,1
tvscl,congrid(view,500,500),order=1

B=''
read,B,Prompt='End(anykey) : '

exit

