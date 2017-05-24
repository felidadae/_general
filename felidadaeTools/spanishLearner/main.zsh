function tr_ { 
	trans pl:en "$1"
	trans pl:es "$1"
}
function translate_and_read_en2es {
	local sentence_to_translate="${1}"
	trans en:es "$sentence_to_translate"
	trans en:es "$sentence_to_translate" \
		| tail -1 | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g" \
		| perl -pe 's/^\s+//' \
		| xargs -n1 -I_sentence -d '\n' sh -c \
			'echo "[Reading] _sentence" && \
			gtts-cli.py "_sentence" -l es -o zupa.mp3 \
				&& play -q zupa.mp3 && rm zupa.mp3'
}

#Bindings
bindkey -M vicmd -s 'tre' "itrans pl:en ''$KEY_LEFT"
bindkey -M vicmd -s 'ytr' "itrans -p en:es ''$KEY_LEFT"
bindkey -M vicmd -s 'gtr' "igtts-cli.py -l es -o zupa.mp3 ''$KEY_LEFT"
bindkey -M vicmd -s 'ptr' "iplay zupa.mp3$ENTER"
bindkey -M vicmd -s 'atr' "itrans -p es:en ''$KEY_LEFT"
