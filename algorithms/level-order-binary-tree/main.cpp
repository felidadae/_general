/*
    to compile:
    g++ -std=c++11 main.cpp -o all; ./all
 */
#include <iostream>
#include <algorithm>
#include <string>
#include <vector>
#include <unordered_map>
#include <memory>

using namespace std;
using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};

vector<vector<int>> levelOrder(TreeNode* root) {
    vector<vector<int>> levels;
    vector<TreeNode*> level;
    if (!root) { return levels; }

    level.push_back(root);
    while (level.size()) {
        vector<int> level_int;
        std::for_each(level.begin(), level.end(), [&level_int](const auto& el) {level_int.push_back(el.val);});
        levels.push_back(level_int);

        vector<TreeNode*> level_;
        for(const auto& nodep: level) {
            if (nodep->left)  level_.push_back(nodep->left);   
            if (nodep->right) level_.push_back(nodep->right);   
        }    
    }

    return levels;
}

void flatten(TreeNode* root) {
    if (!root) return;     
    if (root->right) flatten(root->right);
    if (root->left)  flatten(root->left);
    if (root->left) {
        TreeNode* tmp = root->right;
        root->right= root->left;

        TreeNode* wlk = root->left;
        while(root->right) wlk = root->right;
        wlk->right = tmp;
    }
}

int main() {
    return 0;
}
