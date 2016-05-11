tipsDir='vim-tips'
githubUrl='https://github.com/Jeanhwea/Vim-Tips/blob/master/vim-tips/'

# inject header
cat README.header > README.md

# inject table of contents
numTips=0
for fileName in `ls $tipsDir`
do 
    ((numTips++))
    chName=`head -n 1 $tipsDir/$fileName`
    linkUrl=`echo $githubUrl$fileName`
    printf "%d. [%s](%s)\n" $numTips $chName $linkUrl >> README.md
done

# inject footer
cat README.footer >> README.md

