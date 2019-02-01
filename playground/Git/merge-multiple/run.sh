rm *.txt
rm -fr feature*
sudo rm -r .git
touch .gitignore
echo '.run.sh*' >> .gitignore
echo 'run.sh' >> .gitignore
git init

echo "content-a" > a.txt
echo "content-b" > b.txt

git add .
git commit -m "initial"

git checkout -b sbugaj/feature-1
echo "feature-1" >> a.txt
echo "feature-1" >> b.txt
git add .
git commit -m "Feature-1 [part1]"
echo "feature-1" >> feature-1.txt
mkdir feature-1
echo "feature-1" >> feature-1/a.txt
git add .
git commit -m "Feature-1 [part2]"

git checkout -b sbugaj/feature-2
echo "feature-2" >> a.txt
echo "feature-2" >> b.txt
echo "feature-2" >> feature-2.txt
git add .
git commit -m "Feature-2 [part1]"
echo "feature-2-another" >> a.txt
echo "feature-2-another" >> b.txt
echo "feature-2-another" >> feature-2.txt
git add .
git commit -m "Feature-2 [part2]"

git checkout master
git checkout -b sbugaj/feature-3
echo "feature-3" >> a.txt
echo "feature-3" >> b.txt
echo "feature-3" >> feature-3.txt
git add .
git commit -m "Feature-3 [part1]"
echo "feature-3-another" >> a.txt
echo "feature-3-another" >> b.txt
echo "feature-3-another" >> feature-3.txt
git add .
git commit -m "Feature-3 [part2]"

git checkout master
git checkout -b sbugaj/feature-4
echo "feature-4" >> a.txt
echo "feature-4" >> b.txt
echo "feature-4" >> feature-4.txt
git add .
git commit -m "Feature-4 [part1]"
echo "feature-4-another" >> a.txt
echo "feature-4-another" >> b.txt
echo "feature-4-another" >> feature-4.txt
git add .
git commit -m "Feature-4 [part2]"
exit

# now we will have fun
git checkout sbugaj/feature-1
git reset --soft HEAD~2
git commit -m "Feature-1 [squashed]"

git checkout master
git merge sbugaj/feature-1

git checkout sbugaj/feature-2

git rebase --onto master HEAD~2 sbugaj/feature-2
