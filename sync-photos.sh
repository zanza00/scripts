# /bin/sh
DESTINATION=~/CANONO
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

TMP=`find /Volumes/GoogleDrive/My\ Drive/buildo/PHOTOS/CANONO -newer $LAST_MODIFIED_FILE -type f -exec basename {} \;`

echo "Writing $LAST_RUN_FILE file"
echo "Last sync:\t$NOW \nLast mod date:\t$LAST_MODIFIED_DATE_READABLE" > $DESTINATION/$LAST_RUN_FILE
# modify date to not disturb the next run
touch -t $LAST_MODIFIED_DATE_NO_SPACES $DESTINATION/$LAST_RUN_FILE

echo $TMP