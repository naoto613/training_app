echo "[remote \"origin\"]" >| .git/config
echo "url = https://github-actions[bot]:$GITHUB_TOKEN@github.com/$OWNER/$REPO.git" >> .git/config
git config --global user.email "41898282+github-actions[bot]@users.noreply.github.com"
git config --global user.name "github-actions[bot]"