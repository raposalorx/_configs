#!/bin/bash
# imgcompare.sh {dir:.} {cutoff:0.95}
# The application will recommend actions to take for duplicates.
# imgcompare.sh . 0.98 | vim -
# :%v/^r/d
# :%!bash
# :q!

dir=
cutoff=
files=()
images=()
images_len=0
props=()
aspects=()

# {{{ Get list of files
if [ -z "$1" ]; then
  dir="$PWD"
else
  dir="$1"
fi
if [ -z "$2" ]; then
  cutoff=0.98
else
  cutoff="$2"
fi

#files=$(find "$dir" -type f) # --max-depth=1
# '' is a null delimiter
readarray -d '' files < <(find "$dir" -maxdepth 1 -type f -print0)
# }}}

# {{{ Trim the files list into just a list of valid images.
files_len=${#files[@]}

for ((i = 0; i < files_len; i++)); do
  #  echo "$i - ${files[$i]}"
  if (identify -quiet -ping "${files[$i]}" > /dev/null); then
    images[$images_len]="${files[$i]}"
    ((images_len++))
  fi
done
# }}}

# {{{ Get image properties and generate tmp files
mkdir -p /tmp/imgcompare/"${dir##*/}"
tmpdir=/tmp/imgcompare/"${dir##*/}"

for ((i = 0; i < images_len; i++)); do
  #  echo "$i - ${images[$i]}"
  props[$i]="$(identify -format '%w %h' "${images[$i]}")"
  #  width="$(echo "$props" | awk '{printf("%s",$1);}')"
  #  height="$(echo "$props" | awk '{printf("%s",$2);}')"
  aspects[$i]="$(echo "${props[$i]}" | awk '{printf("%0.2f", int( ($1/$2) * 100 )/100 );}')" # round to the nearest 2 decimals by truncating from an int
  #  echo "${aspects[$i]}"
  # convert "${images[$i]}" "$tmpdir/full/$i.mpc"
  convert "${images[$i]}" -trim +repage -resize '256x256^!' "$tmpdir/$i.mpc"
done
# }}}

# {{{ Compare images
for ((i = 0; i < files_len; i++)); do
  for ((j = i + 1; j < images_len; j++)); do
    if [ $i -ne $j ]; then
      if [ "${aspects[$i]}" == "${aspects[$j]}" ]; then
        #        NCC="$(compare -metric NCC "${images[$i]}" "${images[$j]}" null: 2>&1)"
        NCCsmall="$(compare -metric NCC "$tmpdir/$i.mpc" "$tmpdir/$j.mpc" null: 2>&1)"
        sizei="$(ls -l "${images[$i]}" | awk '{ printf("%i", $5); }')"
        sizej="$(ls -l "${images[$j]}" | awk '{ printf("%i", $5); }')"
        if (($(echo "$NCCsmall >= $cutoff" | bc -l))); then
          NCC="$(compare -metric NCC "${images[$i]}" "${images[$j]}" null: 2>&1)"
          # Use awk because it's better
          awk -v ncc="$NCC" -v cutoff="$cutoff" \
            -v filei="${images[$i]}" -v filej="${images[$j]}" \
            -v sizei="$sizei" -v sizej="$sizej" 'BEGIN{
                  if ( ncc >= cutoff ) {
                    printf("  %f\n  %i - %s\n  %i - %s\n", ncc, sizei, filei, sizej, filej); 
                    if ( sizei == sizej ) {
                      if ( filei ~ /_$/ ) {
                        printf("  Recommended action (file ends in _):\nrm -v \"%s\"\n", filei);
                      }
                      else if (filej ~ /_$/ ) {
                        printf("  Recommended action (file ends in _):\nrm -v \"%s\"\n", filej);
                      }
                      else if (filei ~ /\([0-9]+\)$/ ) {
                        printf("  Recommended action (file ends in (d)):\nrm -v \"%s\"\n", filei);
                      }
                      else if (filej ~ /\([0-9]+\)$/ ) {
                        printf("  Recommended action (file ends in (d)):\nrm -v \"%s\"\n", filej);
                      }
                      else {
                        printf("  Recommended action (files are exactly the same):\nrm -v \"%s\"\n", filej);
                      }
                    }
                    else {
                      printf("  Recommended action (size difference):\nrm -v \"%s\"\n", (sizei < sizej)? filei : filej );
                    }
                  printf("\n");
                }
              }'
        fi
      fi
    fi
  done
done
# }}}

rm "$tmpdir"/*.mpc "$tmpdir"/*.cache

printf '\n\n  To execute recommended actions pipe to vim and execute the commands below\n  %s %s %s | vim -\n  :%%v/^r/d\n  :%%!bash\n  :q!\n\n' "$0" "$dir" "$cutoff"
