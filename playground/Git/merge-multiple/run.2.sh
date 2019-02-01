# cleanup
rm *.txt
rm -fr feature*
sudo rm -r .git
touch .gitignore
echo '.run.*sh*' >> .gitignore
echo 'run.*sh' >> .gitignore

function create_initial {
    # initial
    git init
    echo "content" > initial.txt
    echo "content" > initial.txt
    git add initial.txt
    git commit -m "Initial."
}

function create_feature_branch {
    local index=$1
    local base_branch=$2

    git checkout $base_branch
    git checkout -b sbugaj/feature-$index

    for part_index in 1 2 3; do
        echo "content: $part_index" >> feature-$1.txt
        git add feature-$1.txt
        git commit -m "Add feature $1 [part: $part_index]."
    done
}

# setup
create_initial
for i in 1 2 3; do
    create_feature_branch $i master
done
create_feature_branch 4 sbugaj/feature-3

git checkout -b sbugaj/merge-partial
git merge sbugaj/feature-1 sbugaj/feature-2 sbugaj/feature-3 sbugaj/feature-4

