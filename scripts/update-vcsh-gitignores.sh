for repo in nano; do
  vcsh write-gitignore $repo
  vcsh $repo add -f .gitignore.d/$repo
  vcsh write-gitignore $repo
  # FIX: added a dot on the next two lines before `gitignore.d`
  vcsh $repo add .gitignore.d/$repo
  vcsh $repo commit -m "Add/update .gitignore.d/$repo"
done
