. replaceWithRegexInFile.sh

touch test
echo "..." >> test
echo "..." >> test						
echo "mama...;[++] 555" >> test
echo "tata ... {}" >> test

echo "************"
echo "Before"
echo "************"
cat test
echo "************"

echo ""
echo ""
replaceWithRegexInFile test "^mama\.\.\..*$" "STARA"

echo "************"
echo "Result"
echo "************"
cat test
echo "************"

rm test