#!/usr/bin/env python
# -*- coding: utf-8 -*-
#cd /Users/iikura/Desktop/ViewShed
#PATH=$PATH:/Applications/exelis/idl85/bin:~/bin
#fortran.py kiban50_450F.tif 435 383 2

import sys
import os
import numpy as np
import cv2
import subprocess as sub

param=sys.argv
print param
if len(param)!= 5:
  print " * Usage : terrain.py dem.tif ix iy sel"
  print "        sel=1 : hifuku"
  print "            2 : sisen"


fname=param[1]
dem=cv2.imread(fname,-1)
jmax,imax=dem.shape
sel=int(param[4])

#demx=cv2.resize(dem,(500,500))
#cv2.imshow('dem',demx/np.max(demx))
#cv2.waitKey(0)
#cv2.destroyWindow('dem')

fname2=fname[:-4]+'.futm'
print fname2

if os.path.exists(fname2) == False:
  recl = np.zeros(1,dtype=np.uint32)+4000000
  g=open(fname2,'wb')
  g.write(recl.tobytes())
  g.write(dem.tobytes())
  g.write(recl.tobytes())
  g.close()

f = open(fname2,'rb')
recl = np.fromfile(f, dtype='uint32', count=1)
tmp = np.fromfile(f, dtype='float32', count=dem.size) 
recl = np.fromfile(f, dtype='uint32', count=1)
f.close()

dem2 = np.reshape(tmp, dem.shape)

dem2x=cv2.resize(dem2,(500,500))
cv2.imshow('demx',dem2x/np.max(dem2x))
print 'To continue, enter 1 at demx'

k=cv2.waitKey(0)
print k
if k != 49: exit()

cv2.destroyWindow('dem2')

ix0=param[2]
iy0=param[3]
while True:
  if sel == 1 : command='Fortran/hifuku '+fname2+' '+ix0+' '+iy0
  else: command='Fortran/sisen '+fname2+' '+ix0+' '+iy0
  print command
  sub.call(command,shell=True)
  if sel == 1 : f = open('hifuku.img','rb')
  else: f = open('sisen.img','rb')
  recl = np.fromfile(f, dtype='uint32', count=1)
  tmp = np.fromfile(f, dtype='float32', count=dem.size) 
  recl = np.fromfile(f, dtype='uint32', count=1)
  f.close()
  view=tmp.reshape(1000,1000)
  viewx=cv2.resize(view,(500,500))
  cv2.imshow('view',viewx/np.max(viewx))
  print 'To continue, enter 1 at view'
  k=cv2.waitKey(0)
  if k !=49: exit()
  cv2.destroyWindow('view')
  print ' Input ix & iy :'
  temp = raw_input()
  tlist=temp.split()
  if len(tlist) != 2: exit()
  ix0=tlist[0]
  iy0=tlist[1]

exit()



