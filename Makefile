TTF_pattern=font-files/ttf/%.ttf

$(TTF_pattern): font-files/bdf/%.bdf
	java -jar $(BNP_LOCATION)/BitsNPicas.jar convertbitmap -f ttf -o $@ $<

ttfs: $(patsubst %,$(TTF_pattern), Greybeard-11px-Bold Greybeard-15px-Bold Greybeard-17px Greybeard-11px Greybeard-15px-Italic Greybeard-18px-Bold Greybeard-12px-Bold Greybeard-15px Greybeard-18px-Italic Greybeard-12px Greybeard-16px-Bold Greybeard-18px Greybeard-13px-Bold Greybeard-16px-Italic Greybeard-22px-Bold Greybeard-13px Greybeard-16px Greybeard-22px Greybeard-14px-Bold Greybeard-17px-Bold Greybeard-14px Greybeard-17px-Italic)
