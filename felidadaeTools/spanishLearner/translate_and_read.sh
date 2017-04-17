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
