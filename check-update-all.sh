#!/bin/sh

rsync -azuin --progress -e ssh WebContent/ assies.info:"~/www/palacio-cristal.com/ROOT/"
rsync -azuin --progress -e ssh ../.metadata/.plugins/org.eclipse.wst.server.core/tmp0/webapps/palacio-cristal.com/WEB-INF/lib/ assies.info:"~/www/palacio-cristal.com/ROOT/WEB-INF/lib/"
