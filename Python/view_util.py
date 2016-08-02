#!/usr/bin/env python
# -*- coding: utf-8 -*-

import numpy as np

dem=0
dview=0
imax=0
jmax=0

def hifuku(ix0,iy0):
  global dem,dview  ix=ix0 ; iy=iy0 ; kmax=imax-ix  print ix,iy,kmax  ykasix(ix,iy,kmax)
  return dview  dview = np.rot90(dview,1)   dem = np.rot90(dem,1)  ix=jmax-1-iy0 ; iy=ix0 ; kmax=jmax-ix  print ix,iy,kmax  ykasix(ix,iy,kmax)  dview = np.rot90(dview,1)   dem = np.rot90(dem,1)  ix=imax-1-ix0 ; iy=jmax-1-iy0 ; kmax=imax-ix  print ix,iy,kmax  ykasix,ix,iy,kmax  dview = np.rot90(dview,1)   dem = np.rot90(dem,1)  ix=iy0 ; iy=jmax-1-ix0 ; kmax=jmax-ix  print ix,iy,kmax  ykasix(ix,iy,kmax)  dview=np.rot90(dview,1)  dem=np.rot90(dem,1)
  return dviewdef ykasix(ix,iy,kmax):
  global dview  for k in np.arange(1,kmax-1):    kx = ix + k    ps = iy - k
    if ps < 1 : ps = 1
    pe = iy + k - 1    if pe > jmax-2: pe = jmax-2     flag = 0    for ky in np.arange(ps,pe+1):      if dview[ky,kx] == 1:        ykasix2([kx,ky],[kx,ky+1],[ix,iy])        if flag ==1:
          ykasix2([kx,ky-1],[kx,ky],[ix,iy])          flag = 0        else: flag = 1def ykasix2(point1,point2,point0):
  global dview  x0=point0[0] ; y0=point0[1] ; z0=dem[x0,y0] ; x0=float(x0) ; y0=float(y0)  x1=point1[0] ; y1=point1[1] ; z1=dem[x1,y1] ; x1=float(x1) ; y1=float(y1)  x2=point2[0] ; y2=point2[1] ; z2=dem[x2,y2] ; x2=float(x2) ; y2=float(y2)  aaa=np.matrix([[x0,y0,1.0],[x1,y1,1.0],[x2,y2,1.0]])          temp=aaa.I*np.array([[z0],[z1],[z2]])
  bbb=np.array(temp).flatten()  for ix in np.arange(point1[0]+1,imax) :    ys=int(y0+(y1-y0)*(ix-x0)/(x1-x0))-1 
    if ys < 0 : ys = 0    ye=int(np.ceil(y0+(y2-y0)*(ix-x0)/(x2-x0)))+1
    if ye > jmax-1: ye=jmax-1    flag=1    for iy in np.arange(ys,ye+1):      za = dem[iy,ix]      zb = bbb[0]*ix + bbb[1]*iy+ bbb[2]      if za <= zb :
        if (iy > ys) and (iy < ye) : dview[iy,ix]=0
        if (iy == 0) : dview[ix,iy]=0        if (iy == jmax-1) : dview[iy,ix]=0        flag = 0      if flag == 1: returndef sisen(ix0,iy0):  global dem,dview  ix=ix0 ; iy=iy0 ; kmax = imax-ix  print ix,iy,kmax  kasi1(ix,iy,kmax)
  return dview  dview = np.rot90(dview,1)   dem = np.rot90(dem,1)  ix=jmax-1-iy0 ; iy=ix0 ; kmax = jmax-ix  print ix,iy,kmax  kasi1(ix,iy,kmax)  dview = np.rot90(dview,1)   dem = np.rot90(dem,1)  ix=imax-1-ix0 ; iy=jmax-1-iy0 ; kmax = imax-ix  print ix,iy,kmax  kasi1(ix,iy,kmax)  dview = np.rot90(dview,1)   dem = np.rot90(dem,1)  ix=iy0 ; iy=jmax-1-ix0 ; kmax = jmax-ix  print ix,iy,kmax  kasi1(ix,iy,kmax)  dview=np.rot90(dview,1)  dem=np.rot90(dem,1)
  return dviewdef kasi1(ix,iy,kmax):  global dview  for k in np.arange(2,kmax):    #print k    kx = ix + k    ps = iy - k
    if ps < 0 : ps = 0    pe = iy + k -1 
    if pe > jmax-1 : pe = jmax-1    for ky in np.arange(ps,pe+1):       dview[ky,kx] = kasi1x([ix,iy],[kx,ky])def kasi1x(point1,point2):  xs = point1[0] + 1  xe = point2[0] - 1  ys = float(point1[1])  ye = float(point2[1])  zs = dem[point1[1],point1[0]]  ze = dem[point2[1],point2[0]]  for i in np.arange(xs,xe+1):
    xx = float(i)    yy = ys + (ye-ys)*(xx-xs+1)/(xe-xs+2)    y1 = int(yy)    y2 = y1 + 1    za = zs + (ze-zs)*(xx-xs+1)/(xe-xs+2)    dy = yy - y1    z1 = dem[y1,i]    z2 = dem[y2,i]    zb = z1 + (z2-z1)*dy    if zb >= za : return 0     return 1