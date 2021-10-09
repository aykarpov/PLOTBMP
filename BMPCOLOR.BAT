@ECHO OFF
plotall.exe %1.sch .plt
C:\ORCAD\pltcolor.exe %1.plt /m 2300000 /d 150
