# /bin/sh
DESTINATION=~/CANONO
SOURCE="/Volumes/GoogleDrive/My Drive/buildo/PHOTOS/CANONO"
LAST_RUN_FILE='.last-run'

echo "Begin to sync photos"

if [ ! -f $DESTINATION/$LAST_RUN_FILE ]; then
    echo "ヽ(ﾟДﾟ)ﾉ $LAST_RUN_FILE file not found, writing a new one"
    echo "Last sync:\tNEVER (Ｔ▽Ｔ)" > $DESTINATION/$LAST_RUN_FILE
    touch -t 201901010000 $DESTINATION/$LAST_RUN_FILE
fi


NOW=$(date +%Y_%m_%d-%H:%M:%S)


LAST_MODIFIED_FILE=`find $DESTINATION -type f ! -name '.DS_Store' -print0 | xargs -0 stat -f "%m %N" | sort -rn | head -1 | cut -f2- -d" "`
LAST_MODIFIED_DATE_READABLE=`stat -f "%Sm" -t "%Y_%m_%d-%H:%M:%S" $LAST_MODIFIED_FILE`
LAST_MODIFIED_DATE_NO_SPACES=`stat -f "%Sm" -t "%Y%m%d%H%M" $LAST_MODIFIED_FILE`

echo "Last modified File $LAST_MODIFIED_FILE"
echo "Last modified Date $LAST_MODIFIED_DATE_READABLE"

# This works but preserve the folder structure inside the destination,
# the photos are copied is /CANONO/Volumes/GoogleDrive/My Drive/buildo/PHOTOS/CANONO
# sub optimal but it works  ¯\_(ツ)_/¯
find "$SOURCE" -anewer $LAST_MODIFIED_FILE -type f ! -name '*Icon*' -print0 | rsync -vutp -0 --progress --files-from=- / $DESTINATION

echo "Writing $LAST_RUN_FILE file"
echo "Last sync:\t$NOW \nPrevious mod date:\t$LAST_MODIFIED_DATE_READABLE" > $DESTINATION/$LAST_RUN_FILE
# modify date to not disturb the next run
touch -t $LAST_MODIFIED_DATE_NO_SPACES $DESTINATION/$LAST_RUN_FILE
