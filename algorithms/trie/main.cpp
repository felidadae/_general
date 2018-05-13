/*
    to compile:
    g++ -std=c++11 main.cpp -o all; ./all
 */
#include <iostream>
#include <string>
#include <vector>
#include <unordered_map>
#include <memory>

using namespace std;


struct RGenerator{
    string word_;
    unsigned pos_;
    char cpos_;

    RGenerator(string word) {
        word_ = word;
        pos_  = 0;
        cpos_ = 0;
    }
    string next() {
        string copy(word_);

        //pre
        if (cpos_ > 'z' - 'a') { pos_++; cpos_ = 0;}

        if (word_[pos_] == (char) cpos_ + 'a') {cpos_++;}

        copy[pos_] = cpos_ + 'a';

        //post
        if (pos_ >= word_.size()) return "";
        else cpos_++;

        return copy;
    }
};

class Trie {
public:
    /** Initialize your data structure here. */
    Trie() { root = new TrieNode(); }

    void insert_one_letter_diff(string word) {
        RGenerator rgen(word);
        string r;
        while((r = rgen.next()) != "") insert(r);
    }

    /** Inserts a word into the trie. */
    void insert(string word) {
        TrieNode* wlk = root;
        for (const char& c: word) {
            if (wlk->children_.find(c) == wlk->children_.end())
                wlk->children_[c] = new TrieNode();
            wlk = wlk->children_[c];
        }
        wlk->children_['$'] = new TrieNode();
    }

    /** Returns if the word is in the trie. */
    bool search(string word, bool if_prefix=true) {
        string word_p;
        word_p = if_prefix ? word + "$" : word;

        TrieNode* wlk = root;
        for (const char& c: word_p) {
            if (wlk->children_.find(c) == wlk->children_.end())
                return false;
            wlk = (*wlk->children_.find(c)).second;
        }
        return true;
    }

    /** Returns if there is any word in the trie that starts with the given prefix. */
    bool startsWith(string prefix) {
        return search(prefix, false);
    }

private:
    struct TrieNode {
        unordered_map<char, TrieNode*> children_;
    };
    TrieNode* root;
};

class MagicDictionary {
public:
    MagicDictionary() {}

    /** Build a dictionary through a list of words */
    void buildDict(vector<string> dict) {
        if (trie) delete trie;
        trie = new Trie();
        for (const string& word: dict)
            trie->insert_one_letter_diff(word);
    }

    /** Returns if there is any word in the trie that equals to the given word after modifying exactly one character */
    bool search(string word) {
        return trie->search(word);
    }

private:
    Trie* trie;
};
