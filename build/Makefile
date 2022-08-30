# uppercase variables can be overwritten by
# ./configure --VAR=VALUE or ./configure VAR=VALUE
# (in the configure option, VAR is *case-insensitive*)

SHELL      = /bin/sh
PERL       = perl
BDFTOPCF   = bdftopcf
BDFMANGLE  = $(PERL) bin/bdfmangle
MKSHALLOW  = $(PERL) bin/mkshallow
PREFIX     = /usr/local
PCFDIR     = $(PREFIX)/share/fonts/X11/misc
BINDIR     = $(PREFIX)/bin
MANDIR     = $(PREFIX)/man

# The variables SIZES and ENCODINGS are set in TARGETS.dat

include TARGETS.dat

# Possible values (space-separated lists):
#
# SIZES = 11 11b 12 12b 13 13b 14 14b 15 15i 15b 16 16i 16b 17 17i 17b 18 18i 18b 22 22b
#
# ENCODINGS = uni i01 i02 i03 i05 i07 i08 i09 i10 i13 i14 i15 i16 m50 m51 m53 m55 m57 k8r k8u k8t am8 gep gea kaz 154 ti0 tcv vis 437 850 102 104 csp sym
#
# uni:  unicode.mgl              Unicode / ISO 10646-1
# i01:  iso8859-1.mgl            ISO 8859-1 (W Eur Latin)
# i02:  iso8859-2.mgl            ISO 8859-2 (E Eur Latin)
# i03:  iso8859-3.mgl            ISO 8859-3 (Maltese, Esperanto)
# i05:  iso8859-5.mgl            ISO 8859-5 (E Eur Cyr)
# i07:  iso8859-7.mgl            ISO 8859-7 (Greek)
# i08:  iso8859-8.mgl            ISO 8859-8 (Hebrew)
# i09:  iso8859-9.mgl            ISO 8859-9 (Turkish)
# i10:  iso8859-10.mgl           ISO 8859-10 (Sami, Inuit)
# i13:  iso8859-13.mgl           ISO 8859-13 (Baltic)
# i14:  iso8859-14.mgl           ISO 8859-14 (Celtic)
# i15:  iso8859-15.mgl           ISO 8859-15 (W Eur Latin + Euro)
# i16:  iso8859-16.mgl           ISO 8859-16 (SE Eur Latin)
# m50:  microsoft-cp1250.mgl     MS Windows CP1250 (E Eur Latin)
# m51:  microsoft-cp1251.mgl     MS Windows CP1251 (E Eur Cyr)
# m53:  microsoft-cp1253.mgl     MS Windows CP1253 (Greek)
# m55:  microsoft-cp1255.mgl     MS Windows CP1255 (Hebrew)
# m57:  microsoft-cp1257.mgl     MS Windows CP1257 (Baltic)
# k8r:  koi8-r.mgl               KOI8-R (Russian)
# k8u:  koi8-u.mgl               KOI8-U (Ukrainian)
# k8t:  koi8-t.mgl               KOI8-T (Tajik)
# am8:  armscii-8.mgl            ArmSCII-8 (Armenian)
# gep:  georgian-ps.mgl          "PS" Encoding (Georgian)
# gea:  georgian-academy.mgl     "Academy" Encoding (Georgian)
# kaz:  kz-1048.mgl              KZ-1048 (Kazakh)
# 154:  paratype-pt154.mgl       Paratype PT154 (Asian Cyr)
# ti0:  tis620-0.mgl             TIS 620-0 (Thai)
# tcv:  tcvn-5712.mgl            TCVN-5712 (Vietnamese)
# vis:  viscii-1.1.mgl           VISCII-1.1 (Vietnamese)
# 102:  bpi_ocil-afrful102.mgl   BPI-102 (Bambara, Ewondo, Fula)
# 104:  bpi_ocil-afrlin104.mgl   BPI-104 (Lingala, Sango, Wolof)
# csp:  csx-plus.mgl             CSX+ (Transliterated Sanskrit)
# 437:  ibm-cp437.mgl            Original IBM PC Encoding
# 850:  ibm-cp850.mgl            DOS Multilingual Encoding
# sym:  adobe-symbol.mgl         Adobe Symbol Font Encoding
#
# The ISO 8859-1 and ISO 8859-9 fonts contain also the additional
# characters of MS Windows CP1252 and MS Windows CP1254 and can be
# used for these codepages as well.

pcfpattern = genpcf/gb-$(s)-$(e).pcf.gz

pcf := $(foreach e, $(ENCODINGS), $(foreach s, $(SIZES), $(pcfpattern)))

bdfpattern = genbdf/gb-$(s)-$(e).bdf

bdf := $(foreach e, $(ENCODINGS), $(foreach s, $(SIZES), $(bdfpattern)))

all : $(pcf)

bdf : $(bdf)

genpcf/%.pcf.gz : genbdf/%.bdf
	$(BDFTOPCF) $< > $(@:.pcf.gz=.pcf)
	gzip -9 -f $(@:.pcf.gz=.pcf)

genbdf/gb-11-uni.bdf : bdf/gb-11.bdf bdf/gb-12.bdf VARIANTS.dat mgl/unicode.mgl
	$(MKSHALLOW) bdf/gb-12.bdf | cat - bdf/gb-11.bdf | $(BDFMANGLE) - VARIANTS.dat mgl/unicode.mgl > $@
genbdf/gb-11b-uni.bdf : bdf/gb-11b.bdf bdf/gb-12b.bdf VARIANTS.dat mgl/unicode.mgl
	$(MKSHALLOW) bdf/gb-12b.bdf | cat - bdf/gb-11b.bdf | $(BDFMANGLE) - VARIANTS.dat mgl/unicode.mgl > $@
genbdf/gb-12-uni.bdf : bdf/gb-12.bdf VARIANTS.dat mgl/unicode.mgl
	$(BDFMANGLE) $< VARIANTS.dat mgl/unicode.mgl > $@
genbdf/gb-12b-uni.bdf : bdf/gb-12b.bdf VARIANTS.dat mgl/unicode.mgl
	$(BDFMANGLE) $< VARIANTS.dat mgl/unicode.mgl > $@
genbdf/gb-13-uni.bdf : bdf/gb-13.bdf bdf/gb-14.bdf VARIANTS.dat mgl/unicode.mgl
	$(MKSHALLOW) bdf/gb-14.bdf | cat - bdf/gb-13.bdf | $(BDFMANGLE) - VARIANTS.dat mgl/unicode.mgl > $@
genbdf/gb-13b-uni.bdf : bdf/gb-13b.bdf bdf/gb-14b.bdf VARIANTS.dat mgl/unicode.mgl
	$(MKSHALLOW) bdf/gb-14b.bdf | cat - bdf/gb-13b.bdf | $(BDFMANGLE) - VARIANTS.dat mgl/unicode.mgl > $@
genbdf/gb-14-uni.bdf : bdf/gb-14.bdf VARIANTS.dat mgl/unicode.mgl
	$(BDFMANGLE) $< VARIANTS.dat mgl/unicode.mgl > $@
genbdf/gb-14b-uni.bdf : bdf/gb-14b.bdf VARIANTS.dat mgl/unicode.mgl
	$(BDFMANGLE) $< VARIANTS.dat mgl/unicode.mgl > $@
genbdf/gb-15-uni.bdf : bdf/gb-15.bdf bdf/gb-16.bdf VARIANTS.dat mgl/unicode.mgl
	$(MKSHALLOW) bdf/gb-16.bdf | cat - bdf/gb-15.bdf | $(BDFMANGLE) - VARIANTS.dat mgl/unicode.mgl > $@
genbdf/gb-15b-uni.bdf : bdf/gb-15b.bdf bdf/gb-16b.bdf VARIANTS.dat mgl/unicode.mgl
	$(MKSHALLOW) bdf/gb-16b.bdf | cat - bdf/gb-15b.bdf | $(BDFMANGLE) - VARIANTS.dat mgl/unicode.mgl > $@
genbdf/gb-15i-uni.bdf : bdf/gb-15i.bdf bdf/gb-16i.bdf VARIANTS.dat mgl/unicode.mgl
	$(MKSHALLOW) bdf/gb-16i.bdf | cat - bdf/gb-15i.bdf | $(BDFMANGLE) - VARIANTS.dat mgl/unicode.mgl > $@
genbdf/gb-16-uni.bdf : bdf/gb-16.bdf VARIANTS.dat mgl/unicode.mgl
	$(BDFMANGLE) $< VARIANTS.dat mgl/unicode.mgl > $@
genbdf/gb-16b-uni.bdf : bdf/gb-16b.bdf VARIANTS.dat mgl/unicode.mgl
	$(BDFMANGLE) $< VARIANTS.dat mgl/unicode.mgl > $@
genbdf/gb-16i-uni.bdf : bdf/gb-16i.bdf VARIANTS.dat mgl/unicode.mgl
	$(BDFMANGLE) $< VARIANTS.dat mgl/unicode.mgl > $@
genbdf/gb-17-uni.bdf : bdf/gb-17.bdf bdf/gb-18.bdf VARIANTS.dat mgl/unicode.mgl
	$(MKSHALLOW) bdf/gb-18.bdf | cat - bdf/gb-17.bdf | $(BDFMANGLE) - VARIANTS.dat mgl/unicode.mgl > $@
genbdf/gb-17b-uni.bdf : bdf/gb-17b.bdf bdf/gb-18b.bdf VARIANTS.dat mgl/unicode.mgl
	$(MKSHALLOW) bdf/gb-18b.bdf | cat - bdf/gb-17b.bdf | $(BDFMANGLE) - VARIANTS.dat mgl/unicode.mgl > $@
genbdf/gb-17i-uni.bdf : bdf/gb-17i.bdf bdf/gb-18i.bdf VARIANTS.dat mgl/unicode.mgl
	$(MKSHALLOW) bdf/gb-18i.bdf | cat - bdf/gb-17i.bdf | $(BDFMANGLE) - VARIANTS.dat mgl/unicode.mgl > $@
genbdf/gb-18-uni.bdf : bdf/gb-18.bdf VARIANTS.dat mgl/unicode.mgl
	$(BDFMANGLE) $< VARIANTS.dat mgl/unicode.mgl > $@
genbdf/gb-18b-uni.bdf : bdf/gb-18b.bdf VARIANTS.dat mgl/unicode.mgl
	$(BDFMANGLE) $< VARIANTS.dat mgl/unicode.mgl > $@
genbdf/gb-18i-uni.bdf : bdf/gb-18i.bdf VARIANTS.dat mgl/unicode.mgl
	$(BDFMANGLE) $< VARIANTS.dat mgl/unicode.mgl > $@
genbdf/gb-22-uni.bdf : bdf/gb-22.bdf VARIANTS.dat mgl/unicode.mgl
	$(BDFMANGLE) $< VARIANTS.dat mgl/unicode.mgl > $@
genbdf/gb-22b-uni.bdf : bdf/gb-22b.bdf VARIANTS.dat mgl/unicode.mgl
	$(BDFMANGLE) $< VARIANTS.dat mgl/unicode.mgl > $@

genbdf/%-i01.bdf : genbdf/%-uni.bdf mgl/iso8859-1.mgl
	$(BDFMANGLE) $< mgl/iso8859-1.mgl > $@
genbdf/%-i02.bdf : genbdf/%-uni.bdf mgl/iso8859-2.mgl
	$(BDFMANGLE) $< mgl/iso8859-2.mgl > $@
genbdf/%-i03.bdf : genbdf/%-uni.bdf mgl/iso8859-3.mgl
	$(BDFMANGLE) $< mgl/iso8859-3.mgl > $@
genbdf/%-i05.bdf : genbdf/%-uni.bdf mgl/iso8859-5.mgl
	$(BDFMANGLE) $< mgl/iso8859-5.mgl > $@
genbdf/%-i07.bdf : genbdf/%-uni.bdf mgl/iso8859-7.mgl
	$(BDFMANGLE) $< mgl/iso8859-7.mgl > $@
genbdf/%-i08.bdf : genbdf/%-uni.bdf mgl/iso8859-8.mgl
	$(BDFMANGLE) $< mgl/iso8859-8.mgl > $@
genbdf/%-i09.bdf : genbdf/%-uni.bdf mgl/iso8859-9.mgl
	$(BDFMANGLE) $< mgl/iso8859-9.mgl > $@
genbdf/%-i10.bdf : genbdf/%-uni.bdf mgl/iso8859-10.mgl
	$(BDFMANGLE) $< mgl/iso8859-10.mgl > $@
genbdf/%-i13.bdf : genbdf/%-uni.bdf mgl/iso8859-13.mgl
	$(BDFMANGLE) $< mgl/iso8859-13.mgl > $@
genbdf/%-i14.bdf : genbdf/%-uni.bdf mgl/iso8859-14.mgl
	$(BDFMANGLE) $< mgl/iso8859-14.mgl > $@
genbdf/%-i15.bdf : genbdf/%-uni.bdf mgl/iso8859-15.mgl
	$(BDFMANGLE) $< mgl/iso8859-15.mgl > $@
genbdf/%-i16.bdf : genbdf/%-uni.bdf mgl/iso8859-16.mgl
	$(BDFMANGLE) $< mgl/iso8859-16.mgl > $@
genbdf/%-m50.bdf : genbdf/%-uni.bdf mgl/microsoft-cp1250.mgl
	$(BDFMANGLE) $< mgl/microsoft-cp1250.mgl > $@
genbdf/%-m51.bdf : genbdf/%-uni.bdf mgl/microsoft-cp1251.mgl
	$(BDFMANGLE) $< mgl/microsoft-cp1251.mgl > $@
genbdf/%-m53.bdf : genbdf/%-uni.bdf mgl/microsoft-cp1253.mgl
	$(BDFMANGLE) $< mgl/microsoft-cp1253.mgl > $@
genbdf/%-m55.bdf : genbdf/%-uni.bdf mgl/microsoft-cp1255.mgl
	$(BDFMANGLE) $< mgl/microsoft-cp1255.mgl > $@
genbdf/%-m57.bdf : genbdf/%-uni.bdf mgl/microsoft-cp1257.mgl
	$(BDFMANGLE) $< mgl/microsoft-cp1257.mgl > $@
genbdf/%-k8r.bdf : genbdf/%-uni.bdf mgl/koi8-r.mgl
	$(BDFMANGLE) $< mgl/koi8-r.mgl > $@
genbdf/%-k8u.bdf : genbdf/%-uni.bdf mgl/koi8-u.mgl
	$(BDFMANGLE) $< mgl/koi8-u.mgl > $@
genbdf/%-k8t.bdf : genbdf/%-uni.bdf mgl/koi8-t.mgl
	$(BDFMANGLE) $< mgl/koi8-t.mgl > $@
genbdf/%-am8.bdf : genbdf/%-uni.bdf mgl/armscii-8.mgl
	$(BDFMANGLE) $< mgl/armscii-8.mgl > $@
genbdf/%-gep.bdf : genbdf/%-uni.bdf mgl/georgian-ps.mgl
	$(BDFMANGLE) $< mgl/georgian-ps.mgl > $@
genbdf/%-gea.bdf : genbdf/%-uni.bdf mgl/georgian-academy.mgl
	$(BDFMANGLE) $< mgl/georgian-academy.mgl > $@
genbdf/%-kaz.bdf : genbdf/%-uni.bdf mgl/kz-1048.mgl
	$(BDFMANGLE) $< mgl/kz-1048.mgl > $@
genbdf/%-154.bdf : genbdf/%-uni.bdf mgl/paratype-pt154.mgl
	$(BDFMANGLE) $< mgl/paratype-pt154.mgl > $@
genbdf/%-ti0.bdf : genbdf/%-uni.bdf mgl/tis620-0.mgl
	$(BDFMANGLE) $< mgl/tis620-0.mgl > $@
genbdf/%-tcv.bdf : genbdf/%-uni.bdf mgl/tcvn-5712.mgl
	$(BDFMANGLE) $< mgl/tcvn-5712.mgl > $@
genbdf/%-vis.bdf : genbdf/%-uni.bdf mgl/viscii-1.1.mgl
	$(BDFMANGLE) $< mgl/viscii-1.1.mgl > $@
genbdf/%-437.bdf : genbdf/%-uni.bdf mgl/ibm-cp437.mgl
	$(BDFMANGLE) $< mgl/ibm-cp437.mgl > $@
genbdf/%-850.bdf : genbdf/%-uni.bdf mgl/ibm-cp850.mgl
	$(BDFMANGLE) $< mgl/ibm-cp850.mgl > $@
genbdf/%-102.bdf : genbdf/%-uni.bdf mgl/bpi_ocil-afrful102.mgl
	$(BDFMANGLE) $< mgl/bpi_ocil-afrful102.mgl > $@
genbdf/%-104.bdf : genbdf/%-uni.bdf mgl/bpi_ocil-afrlin104.mgl
	$(BDFMANGLE) $< mgl/bpi_ocil-afrlin104.mgl > $@
genbdf/%-csp.bdf : genbdf/%-uni.bdf mgl/csx-plus.mgl
	$(BDFMANGLE) $< mgl/csx-plus.mgl > $@
genbdf/%-sym.bdf : genbdf/%-uni.bdf mgl/adobe-symbol.mgl
	$(BDFMANGLE) $< mgl/adobe-symbol.mgl > $@

install : $(pcf)
	install -m0755 -d $(DESTDIR)$(PCFDIR)
	install -m0644 -p $(pcf) $(DESTDIR)$(PCFDIR)
	mkfontscale $(DESTDIR)$(PCFDIR)
	mkfontdir $(DESTDIR)$(PCFDIR)

install-util :
	install -m0755 -d $(DESTDIR)$(BINDIR)
	install -m0755 -d $(DESTDIR)$(MANDIR)/man1
	install -m0755 -p bin/bdfmangle $(DESTDIR)$(BINDIR)
	install -m0644 -p man/man1/bdfmangle.1 $(DESTDIR)$(MANDIR)/man1

clean :
	-rm -f genbdf/*.bdf genpcf/*.pcf.gz

distclean :
	-rm -f genbdf/*.bdf genpcf/*pcf.gz Makefile

.PHONY: all bdf clean distclean install install-util
.DELETE_ON_ERROR:

