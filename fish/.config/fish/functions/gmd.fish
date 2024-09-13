function gmd --description 'Scrap logs for the current git branch into a markdown document'
git md | perl -00 -lpe 's/\n/ /g' | xclip -selection clipboard
end
