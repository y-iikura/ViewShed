ViewShed
======================
数値標高モデルから指定された画素（地表面）にから見える視野域を計算します。対話的に画素を指定する事ができます。

使い方
------
ターミナルで以下のようなコマンドを入力します。
<pre>
$ idl check.pro -args dem.tif pixel line 
    (IDLプログラム）
$ idl fortran.pro -args dem.tif pixel line
　　（IDLからFortranプログラムを利用）
$ fortran.py dem.tif pixel line sel
　　（PythonからFortranプログラムを利用）
</pre>

数値標高モデル（画像）のピクセル番号(pixel)とライン番号(line)の初期値を指定します。高速化のため被覆法（後述）を利用しますが、fortran.pyでは被覆法（sel=1)と視線法(sel=2)を選択できます。

初期値に基づいて得られた視野域画像が表示されます。ターミナルに表示されたプロンプトにしたがって、pixelとlineを再設定できます。二つのパラメータを入力しないとプログラムは終了します。

fortran.proとfortran.pyを利用するにはFORTRANフォルダに含まれるファイルのコンパイルなどが必要です。f_compile.shに必要なコマンドが記載されています。


必要なデータ
----------------
GEOTIFF形式の数値方向モデル(dem.tif)が必要です。KibanDemを用いて作成する事ができます。

利用するライブラリ
--------
Python2.7で動作を確認しています。

1. check.proで利用する自作のライブラリはIDLフォルダにあります。
2. fortran.pro(spawn)およびfortran.py(subprocess)で利用するライブラリはFORTRANフォルダにあります。
3. fortran.pyではsys,os,numpy,cv2(opencv),subprocessが必要です。
4. FORTRANコンパイラ(gfortranなど）が必要です。

参考文献など
--------
* 飯倉善和：被覆平面を用いた体系的な不可視領域の決定、GIS-理論と応用、8(2)、pp.39-46、2000


ライセンス
----------
Copyright &copy; 2016 Yoshikazu Iikura  
Distributed under the [MIT License][mit].

[MIT]: http://www.opensource.org/licenses/mit-license.php
