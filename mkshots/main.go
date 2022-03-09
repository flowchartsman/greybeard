package main

import (
	"bufio"
	"flag"
	"io/ioutil"
	"log"
	"os"
	"path/filepath"
	"strconv"
	"strings"

	"github.com/fogleman/gg"
	"github.com/golang/freetype/truetype"
	"golang.org/x/image/font"
)

const sampleText = `ABCDEFGHIJKLMNOPQRSTUVWXYZ 12345
abcdefghijklmnopqrstuvwxyz 67890
{}[]()<>$*-+=/#_%^@\&|~?'"` + "`" + `!,.;:
Illegal1i = oO0          
The quick brown fox, (..) Hello,
jumps over lazy dog. /__\ World!`

func main() {
	log.SetFlags(0)
	var (
		bdfdir,
		ttfdir,
		shotdir string
	)
	flag.StringVar(&bdfdir, "bdfdir", "../font-files/bdf", "directory to .bdf files")
	flag.StringVar(&ttfdir, "ttfdir", "../font-files/ttf", "directory to .ttf files")
	flag.StringVar(&shotdir, "shotdir", "screenshots", "directory to screenshots")
	flag.Parse()
	if bdfdir == "" || ttfdir == "" || shotdir == "" {
		log.Fatal("need --bdfdir --ttfdir --shotdir")
	}

	sampleLines := strings.Split(sampleText, "\n")
	sampleLineWidth := len(sampleLines[0])

	type fontListing struct {
		fontPrefix string
		font       font.Face
		fontBold   font.Face
		fontItalic font.Face
		pointsize  float64
		width      int
	}

	fontmap := map[string]*fontListing{}

	fontFiles, err := ioutil.ReadDir(bdfdir)
	if err != nil {
		log.Fatal("couldn't open font directory", err)
	}

	for _, fn := range fontFiles {
		if !strings.HasSuffix(fn.Name(), ".bdf") {
			continue
		}
		ff, err := os.Open(filepath.Join(bdfdir, fn.Name()))
		if err != nil {
			log.Fatalf("couldn't open font file %q: %s", fn.Name(), err)
		}
		scanner := bufio.NewScanner(ff)
		var (
			fontWidth  int
			fontHeight float64
		)

		for scanner.Scan() {
			fields := strings.Fields(scanner.Text())
			if fields[0] == "FONTBOUNDINGBOX" {
				fw, fh := fields[1], fields[2]
				fontWidth, _ = strconv.Atoi(fw)
				fontHeight, _ = strconv.ParseFloat(fh, 64)
				break
			}
		}
		ff.Close()
		fprefix := strings.TrimSuffix(fn.Name(), ".bdf")
		fparts := strings.Split(fprefix, "-")
		var fvariant string
		switch fparts[len(fparts)-1] {
		case "Bold", "Italic":
			fvariant = fparts[len(fparts)-1]
			fparts = fparts[:len(fparts)-1]
		}
		fname := strings.Join(fparts, " ")
		if fontmap[fname] == nil {
			fontmap[fname] = &fontListing{
				fontPrefix: strings.Join(fparts, "-"),
				pointsize:  fontHeight,
				width:      fontWidth,
			}
		}
		switch fvariant {
		case "Bold":
			ttf, err := os.ReadFile(filepath.Join(ttfdir, fprefix+".ttf"))
			if err != nil {
				log.Fatalf("unable to read ttf: %s", err)
			}
			font, err := truetype.Parse(ttf)
			if err != nil {
				log.Fatal(err)
			}
			fontmap[fname].fontBold = truetype.NewFace(font, &truetype.Options{Size: fontHeight})
		case "Italic":
			ttf, err := os.ReadFile(filepath.Join(ttfdir, fprefix+".ttf"))
			if err != nil {
				log.Fatalf("unable to read ttf: %s", err)
			}
			font, err := truetype.Parse(ttf)
			if err != nil {
				log.Fatal(err)
			}
			fontmap[fname].fontItalic = truetype.NewFace(font, &truetype.Options{Size: fontHeight})
		default:
			ttf, err := os.ReadFile(filepath.Join(ttfdir, fprefix+".ttf"))
			if err != nil {
				log.Fatalf("unable to read ttf: %s", err)
			}
			font, err := truetype.Parse(ttf)
			if err != nil {
				log.Fatal(err)
			}
			fontmap[fname].font = truetype.NewFace(font, &truetype.Options{Size: fontHeight})
		}
	}

	for fontName, font := range fontmap {
		sampleWidth := (sampleLineWidth + 1) * font.width
		sampleHeight := len(sampleLines)*2 + 4
		if font.fontItalic != nil {
			sampleHeight += len(sampleLines) + 2
		}
		sampleHeight *= int(font.pointsize)
		dc := gg.NewContext(sampleWidth, sampleHeight)
		dc.SetRGB(1, 1, 1)
		dc.Clear()
		dc.SetRGB(0, 0, 0)
		dc.SetFontFace(font.fontBold)
		y := font.pointsize
		dc.DrawString(fontName, 0, y)
		y += font.pointsize
		dc.SetFontFace(font.font)
		for _, line := range sampleLines {
			y += font.pointsize
			dc.DrawString(line, 0, y)
		}
		y += font.pointsize
		dc.SetFontFace(font.fontBold)
		for _, line := range sampleLines {
			y += font.pointsize
			dc.DrawString(line, 0, y)
		}
		if font.fontItalic != nil {
			y += font.pointsize
			dc.SetFontFace(font.fontItalic)
			for _, line := range sampleLines {
				y += font.pointsize
				dc.DrawString(line, 0, y)
			}
		}
		dc.SavePNG(filepath.Join(shotdir, font.fontPrefix+".png"))
	}
}
