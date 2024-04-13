function fuzzy-trash
	set fuzzy (fzf)
	echo "Deleting file $fuzzy"
	trash $fuzzy
end
