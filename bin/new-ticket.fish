#!/usr/local/bin/fish


function main
    set NEW_MCC_DIRECTORY "/Users/amartins/development/amartins-mdsol-notes/Blue_Wave"
    set TEMP_MCC "$argv"
    # story in one line with no spaces at the end of the line
    set TEMP_MCC_ONE_LINE (echo $TEMP_MCC | gtr '\n' ' ' | sed 's/ $//')
    set TEMP_MCC_WITH_UNDERSCORES (echo $TEMP_MCC_ONE_LINE | sed 's/MCC-\([0-9]*\) \(.*\)/MCC-\1-\2/' | sed 's/ /_/g' | sed 's/[][]//g')
    set TEMP_MCC_ONLY_NUMBER (echo $TEMP_MCC_ONE_LINE | sed 's/MCC-\([0-9]*\) \(.*\)/MCC-\1/')

    echo "Create  MMC diertory $TEMP_MCC_WITH_UNDERSCORES"
    set NEW_MCC_DIRECTORY_FULL_PATH "$NEW_MCC_DIRECTORY/$TEMP_MCC_WITH_UNDERSCORES"
    mkdir "$NEW_MCC_DIRECTORY_FULL_PATH"
    cd $NEW_MCC_DIRECTORY_FULL_PATH

    set README README.md
    echo "Create $README"
    set NEW_MCC_FILE_FULL_PATH $NEW_MCC_DIRECTORY_FULL_PATH/$README
    touch $NEW_MCC_FILE_FULL_PATH

    echo "Inserting [**"(date -u +"%Y-%m-%d")"**] into $README"
    echo -e "**"(date -u +'%Y-%m-%d')"**\n" >> $NEW_MCC_FILE_FULL_PATH
    echo "Inserting [# $TEMP_MCC_ONE_LINE] into $README"
    echo -e "# $TEMP_MCC_ONE_LINE\n" >> $NEW_MCC_FILE_FULL_PATH

    set JIRA_URL https://jira.mdsol.com/browse
    echo "Inserting [$JIRA_URL/$TEMP_MCC_ONLY_NUMBER] into $README"
    echo -e "$JIRA_URL/$TEMP_MCC_ONLY_NUMBER\n" >> $NEW_MCC_FILE_FULL_PATH

    echo "Create and switch to new session $TEMP_MCC_ONE_LINE"
    tmux new-session -s "$TEMP_MCC_ONE_LINE" -d
    tmux switch-client -t "$TEMP_MCC_ONE_LINE"
end

main "$argv"
