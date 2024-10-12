#!/var/jb/usr/bin/zsh

DIRS=("nfq" "tpws" "ip2net" "mdig")
TGT="binaries/my"

rm -rf "$TGT"
mkdir -p "$TGT"

for dir in "${DIRS[@]}"; do
    find "$dir" -type f \( -name "*.c" -o -name "*.h" -o -name "*akefile" \) -exec chmod -x {} \;
    make -C "$dir" || exit
    for exe in "$dir/"*; do
        if [ -f "$exe" ] && [ -x "$exe" ]; then
            mv -f "$exe" "$TGT"
            ln -fs "../$TGT/$(basename "$exe")" "$exe"
        fi
    done
done
