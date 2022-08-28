FONTS=Greybeard-11px Greybeard-11px-Bold Greybeard-12px Greybeard-12px-Bold Greybeard-13px Greybeard-13px-Bold Greybeard-14px Greybeard-14px-Bold Greybeard-15px Greybeard-15px-Bold Greybeard-15px-Italic Greybeard-16px Greybeard-16px-Bold Greybeard-16px-Italic Greybeard-17px Greybeard-17px-Bold Greybeard-17px-Italic Greybeard-18px Greybeard-18px-Bold Greybeard-18px-Italic Greybeard-22px Greybeard-22px-Bold Greybeard-15px-BoldItalic Greybeard-16px-BoldItalic Greybeard-17px-BoldItalic Greybeard-18px-BoldItalic

BDF_files=build/genbdf/%.bdf
BI_files=build/genbdf/bi/%.bdf
TTF_files=font_out/%.ttf
WOFF2_files=font_out/%.woff2

$(BDF_files): | bdfdir
	make -C build $(patsubst build/%,%,$@)
	perl fixbdf.pl $@

build/genbdf/bi/gb-15bi.bdf: build/genbdf/gb-15i-uni.bdf
build/genbdf/bi/gb-16bi.bdf: build/genbdf/gb-16i-uni.bdf
build/genbdf/bi/gb-17bi.bdf: build/genbdf/gb-17i-uni.bdf
build/genbdf/bi/gb-18bi.bdf: build/genbdf/gb-18i-uni.bdf
$(BI_files): | bdfdir
	mkdir -p build/genbdf/bi
	mkbold -r -L $< > $@
	perl fixbdf.pl $@

font_out/Greybeard-11px.ttf: build/genbdf/gb-11-uni.bdf
font_out/Greybeard-11px-Bold.ttf: build/genbdf/gb-11b-uni.bdf
font_out/Greybeard-12px.ttf: build/genbdf/gb-12-uni.bdf
font_out/Greybeard-12px-Bold.ttf: build/genbdf/gb-12b-uni.bdf
font_out/Greybeard-13px.ttf: build/genbdf/gb-13-uni.bdf
font_out/Greybeard-13px-Bold.ttf: build/genbdf/gb-13b-uni.bdf
font_out/Greybeard-14px.ttf: build/genbdf/gb-14-uni.bdf
font_out/Greybeard-14px-Bold.ttf: build/genbdf/gb-14b-uni.bdf
font_out/Greybeard-15px.ttf: build/genbdf/gb-15-uni.bdf
font_out/Greybeard-15px-Bold.ttf: build/genbdf/gb-15b-uni.bdf
font_out/Greybeard-15px-Italic.ttf: build/genbdf/gb-15i-uni.bdf
font_out/Greybeard-16px.ttf: build/genbdf/gb-16-uni.bdf
font_out/Greybeard-16px-Bold.ttf: build/genbdf/gb-16b-uni.bdf
font_out/Greybeard-16px-Italic.ttf: build/genbdf/gb-16i-uni.bdf
font_out/Greybeard-17px.ttf: build/genbdf/gb-17-uni.bdf
font_out/Greybeard-17px-Bold.ttf: build/genbdf/gb-17b-uni.bdf
font_out/Greybeard-17px-Italic.ttf: build/genbdf/gb-17i-uni.bdf
font_out/Greybeard-18px.ttf: build/genbdf/gb-18-uni.bdf
font_out/Greybeard-18px-Bold.ttf: build/genbdf/gb-18b-uni.bdf
font_out/Greybeard-18px-Italic.ttf: build/genbdf/gb-18i-uni.bdf
font_out/Greybeard-22px.ttf: build/genbdf/gb-22-uni.bdf
font_out/Greybeard-22px-Bold.ttf: build/genbdf/gb-22b-uni.bdf
font_out/Greybeard-15px-BoldItalic.ttf: build/genbdf/bi/gb-15bi.bdf
font_out/Greybeard-16px-BoldItalic.ttf: build/genbdf/bi/gb-16bi.bdf
font_out/Greybeard-17px-BoldItalic.ttf: build/genbdf/bi/gb-17bi.bdf
font_out/Greybeard-18px-BoldItalic.ttf: build/genbdf/bi/gb-18bi.bdf
$(TTF_files): | outdir
	java -jar /fonttools/BitsNPicas.jar convertbitmap -f ttf -o $@ $<

ttfs:$(patsubst %,$(TTF_files), $(FONTS))

$(patsubst %,$(WOFF2_files), $(FONTS)): %.woff2: %.ttf | outdir
	woff2_compress $<

woff2s:$(patsubst %,$(WOFF2_files), $(FONTS))

release: distclean woff2s sample package clean

outdir:
	mkdir -p font_out

bdfdir:
	mkdir -p build/genbdf/bi

.PHONY: package
package:
	mkdir -p dist/ttf
	mkdir -p dist/woff2
	cp font_out/*.ttf dist/ttf
	cp font_out/*.woff2 dist/woff2

.PHONY: sample | outdir
sample : ttfs
	perl buildsample.pl
	cp font_out/greybeard_sample.gif .

.PHONY: clean
clean:
	rm -rf build/genbdf/*
	rm -rf font_out

.PHONY: distclean
distclean:
	rm -rf build/genbdf/*
	rm -rf font_out
	rm -rf dist
