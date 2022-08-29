use strict;
use warnings;
use 5.010;

my $dirname = 'font_out';
opendir(DIR, $dirname) or die "Could not open $dirname\n";

my $fonts = {};
while (my $filename = readdir(DIR)) {
    if ($filename =~ /(Greybeard-\d+px).*\.ttf/) {
        my $basename = $1;
        if ($filename =~/Greybeard-(\d+)px\.ttf/) {
            $fonts->{$basename}{Medium}="$dirname/$filename";
            $fonts->{$basename}{size}=$1;
        }
        elsif ($filename =~/Greybeard-\d+px-Bold\.ttf/) {
            $fonts->{$basename}{Bold}="$dirname/$filename";
        }
        elsif ($filename =~/Greybeard-\d+px-Italic\.ttf/) {
            $fonts->{$basename}{Italic}="$dirname/$filename";
        }
        elsif ($filename =~/Greybeard-\d+px-BoldItalic\.ttf/) {
            $fonts->{$basename}{BoldItalic}="$dirname/$filename";
        }
    }
}
closedir(DIR);
my @montage;
foreach(sort(keys %$fonts)) {
    my $font = $fonts->{$_};
    my $basename = $_;
    my @stack;
    my $title_file = "$dirname/${basename}_title.gif";
    push @stack, $title_file;
    # generate title
    `magick -font $dirname/Greybeard-22px-Bold.ttf -pointsize 22 -background white -fill black label:$basename $title_file`;
    `magick $title_file -background white -extent 0x\%[fx:h+22] $title_file`;
    # generate samples
    foreach my $weight ("Medium", "Italic", "Bold", "BoldItalic") {
        if (exists $font->{$weight}) {
            my $sample_file = "$dirname/${basename}-${weight}_sample.gif";
            push @stack, $sample_file;
            `magick -font $font->{$weight} -pointsize $font->{size} -background white -fill black label:\@sampletext.txt $sample_file`;
        }
    }

    #generate full sample
    my $stack_file = "$dirname/${basename}_stack.gif";
    push @montage, $stack_file;
    `convert -append @stack $stack_file`;
}

#generate the final montage
my $montage_file = "$dirname/greybeard_sample.gif";
`montage @montage -background white -gravity north -tile 5x -geometry +5+10 $montage_file`;
`convert $montage_file -bordercolor white -border 1x1 -trim +repage $montage_file`;
`convert -bordercolor white -border 10 $montage_file $montage_file`;
