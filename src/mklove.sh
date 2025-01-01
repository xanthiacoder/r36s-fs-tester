date "+Compiled: %Y/%m/%d %H:%M:%S" > version.txt
rm ../FSTester.love
zip -9 -r -x\.git/* ../FSTester.love .