#| Problem 5 (Generic operators).
There’s a collection of programs called netpbm that is used to convert images from one
format to another (for example, to convert gif files to jpeg files). The collection consists of
around 160 converters. Each converter is a program that knows how to convert a file in one
specific format to one other format. So, for example, there’s a converter called tifftopnm
that converts images in tiff format to images in pnm format.
The documentation for netpbm claims that the programs can be used to convert to and
from any of 80 image formats. How is this possible with only 160 converters?
Your answer must be no more than 30 words! |#


;As long as the converters are in a chain/loop/linked list we convert it until we reach
;desired format. ex: tifftopnm to pnmtojpeg jpegtogif giftotiff
;We use a table to direct the data to the correct format. 
; PseudoCode Ex: (put 'convertToTiff (lambda (x) (runConvertUntil giftotiff x))