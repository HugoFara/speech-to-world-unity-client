CURRENT_BRANCH=`git rev-parse --abbrev-ref HEAD`
if $CURRENT_BRANCH != main; then
    echo "Should be on main! Current branch is $CURRENT_BRANCH"
    exit 1
fi 
echo "Switching branch to gh-pages, old was $CURRENT_BRANCH"
git switch gh-pages
git merge main
cp README.md Documentation/index.md
docfx Documentation/docfx.json && \
rm Documentation/index.md
rm -rf Documentation/api
echo "Documentation ready"
git add docs
git commit -m "docs: Regenerating documentation"
git push
git switch $CURRENT_BRANCH
