@ECHO OFF
echo example.bat �ନ��� �����஬�� (powerbw.bmp) �
echo             梥⭮� (powerclr.bmp) ����᪨� 䠩��
echo             �� 䠩�� ��� ������ power5.plt

PLT2BMP.EXE power5.plt /p2 2 /p3 6 /m 1150000 /d 300
del powerbw.bmp
rename power5.bmp powerbw.bmp
PLTCOLOR.EXE power5.plt /m 1150000 /d 300
del powerclr.bmp
rename power5.bmp powerclr.bmp