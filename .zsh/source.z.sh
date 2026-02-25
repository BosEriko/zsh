# ================================================================================= [Source] ===== #

for folder in initializers modules programming; do
  base=~/.files/$folder
  [[ -d $base ]] || continue

  for dir in $base/*(/); do
    setup "$dir"
  done
done
