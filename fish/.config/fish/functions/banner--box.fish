function banner--box
set banner__hr (banner--hr -t $argv -d '─')
set banner__text (banner--text $argv)
echo "╭─$banner__hr─╮"
for line in $banner__text
echo "│ $line │"
end
echo "╰─$banner__hr─╯"
end
