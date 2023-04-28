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