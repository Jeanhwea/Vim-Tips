tipsDir='vim-tips'
githubUrl='https://github.com/Jeanhwea/Vim-Tips/blob/master/vim-tips/'

# inject header
cat README.header > README.md

# inject table of contents
numTips=0
for fileName in `ls vim-tips`
do 
    ((numTips++))
    chName=`cat $tipsDir/$fileName | head -n 1`
    linkUrl=`echo $githubUrl$fileName`
    printf "%d. [%s](%s)\n" $numTips $chName $linkUrl >> README.md
done

# inject footer
cat README.footer >> README.md

