# cleanup
rm *.txt
rm -fr feature*
sudo rm -r .git
touch .gitignore
echo '.run.*sh*' >> .gitignore
echo 'run.*sh' >> .gitignore

# initial
git init
echo "content" > initial.txt
echo "content" > initial.txt
git add initial.txt
git commit -m "Initial."

git checkout -b branch_a
echo ----------- >> a.txt
echo ----------- >> a.txt
echo ----------- >> a.txt
echo a >> a.txt
echo b >> a.txt
echo c >> a.txt
echo ----------- >> a.txt
echo ----------- >> a.txt
echo ----------- >> a.txt
git add a.txt
git commit -m "Single one."

git checkout master
git checkout -b branch_b
echo ----------- >> a.txt
echo ----------- >> a.txt
echo ----------- >> a.txt
echo a >> a.txt
git add a.txt
git commit -m "First."
echo b >> a.txt
git add a.txt
git commit -m "Second."
echo c >> a.txt
echo ----------- >> a.txt
echo ----------- >> a.txt
echo ----------- >> a.txt
git add a.txt
git commit -m "Third."
