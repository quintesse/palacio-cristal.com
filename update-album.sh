#!/bin/sh

rsync -azui --size-only --progress -e ssh WebContent/FotoAlbum/Fotos/ assies.info:"~/www/palacio-cristal.com/ROOT/FotoAlbum/Fotos/"
