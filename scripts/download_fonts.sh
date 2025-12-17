font_dir=/usr/share/fonts/
if [ "$(uname)" == "Darwin" ]; then
    font_dir=$HOME/Library/Fonts/
fi

# Inconsolata
fonts=(
    "Inconsolata-Black.ttf"
    "Inconsolata-Bold.ttf"
    "Inconsolata-ExtraBold.ttf"
    "Inconsolata-ExtraLight.ttf"
    "Inconsolata-Light.ttf"
    "Inconsolata-Medium.ttf"
    "Inconsolata-Regular.ttf"
    "Inconsolata-SemiBold.ttf"
)

for font in ${fonts[@]}; do
    wget https://github.com/googlefonts/Inconsolata/raw/main/fonts/ttf/$font -P $font_dir
done

wget https://github.com/adobe-fonts/source-han-code-jp/releases/download/2.012R/SourceHanCodeJP.ttc -P $font_dir

# Download and extract fonts from zip
zip_url="https://github.com/yuru7/moralerspace/releases/download/v2.0.0/Moralerspace_v2.0.0.zip"
tmp_dir=$(mktemp -d)
wget "$zip_url" -O "$tmp_dir/font.zip"
unzip "$tmp_dir/font.zip" -d "$tmp_dir"
find "$tmp_dir" -name "*.ttf" -exec mv {} "$font_dir" \;
rm -rf "$tmp_dir"
