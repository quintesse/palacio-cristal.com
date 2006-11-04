#!/bin/sh

rsync -azui --size-only --progress -e ssh WebContent/blogs/ assies.info:"~/www/palacio-cristal.com/ROOT/blogs/"
