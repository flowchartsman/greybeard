![Greybeard](logo.gif)

Greybeard is a chunky monospaced bitmap programming font for all you pixel-perfect nerds who don't like eyestrain. It's mostly a port of [UW ttyp0](http://people.mpi-inf.mpg.de/~uwe/misc/uw-ttyp0/) with a few tweaks.

It covers most of the Latin and Cyrillic alphabet, Greek, Armenian, Georgian (only Mkhedruli), Hebrew (without cantillation marks), Thai, most of IPA (but no UPA), standard punctuation, common symbols, some mathematics, line graphics and a few dingbats (about 3000 Unicode characters).

It is provided as rendered outline fonts in the following pixel sizes: 11, 12, 13, 14, 15, 16, 17, 18 and 22. Each of these has a bold variant, and italic variants are provided in 15, 16, 17 and 18. Additionally, all fonts with an italic variant have an *experimental* auto-generated bold-italic variant, though mileage with these may vary.

It is named after those mythical sysops, staring at white on blue Borland compilers late into the night. Some say they stare still...

# Samples

![Greybeard Samples](greybeard_sample.gif)

# Installation

Font files can be downloaded from the [releases page](https://github.com/flowchartsman/greybeard/releases)

# Changes from UW ttyp0

- Default to straight apostrophe/graves.
- Default to slashed zero.
- Default to centered tilde.
- Render nbsp as normal space to avoid editor issues.
- Fixed `#` glyph for certain sizes/weights to make it less "pointy".
- Bold-Italic variants.
- Additional height properties to help .ttf generation.

# Building

If you want to build the font yourself for testing or if you want to select stylistic variants, you can use the dockerized build process which uses the [bitmap-font-vector-build](https://hub.docker.com/r/flowchartsman/bitmap-font-vector-build) container I created to collect all of the necessary tools in one place. Just make whatever changes you like and run `./scripts/docker_build.sh`, which will generate .ttf files in `font_out`. You can also specify any make target you like with this script. The ones that probably interest you are:

- `ttfs`
- `woff2s`
- `pcfs`

Note: the `woff2s` target will also generate the .ttf files, since it creates the .woff2 files from them.

Mostly you will probably only want to modify `build/VARIANTS.dat` and rebuild the font.

# Repo Layout
The tree under `/build` is more or less the same layout as UW ttyp0, and is used to build the intermediate .bdf files which then generate both the .ttf and .pcf files. The intermediat .bdf files are in turn created by applying the settings in `build/VARIANTS.dat` to the files in `build/bdf`, which serve as the source of truth for the font.

Manual instructions in `build/INSTALL` are kept around for legacy purposes and are geared towards generating and installing a gzipped pcf font, so they are probably not useful to anyone these days. If you're installing the font in an environment that supports it, you probably know what you're doing.

# Reporting Issues
Most testing is done on MacOS, so there aren't a lot of eyes on Windows and Linux. Please file an issue if you have problems with usage and/or rendering on any platform.
