#!/usr/bin/env bash

BASE_DIR='.'
LS_ARGS=""

# numeric test
while (( $# > 0 )); do
    # analyse the first arg from the left
    # case EXPRESSION in
    # PATTERN_1)
    #     STATEMENTS
    #     ;;
    # PATTERN_2)
    #     STATEMENTS
    #     ;;
    # *)
    #     STATEMENTS
    #     ;;
    # esac
    case $1 in
        -a|--all)
            LS_ARGS="$LS_ARGS -A"

            # # only waiting for a directory now
            # if (($# > 1)); then
            #     printf 'error : too much args\n' >&2
            #     exit 1
            # fi

            # if (($# == 1)); then
            #     BASE_DIR=$1
            # fi

            break
            ;;

        -*)
            printf 'error : unknown option : %s\n' "$1" >&2
            exit 1
            ;;

        *)
            BASE_DIR=$1
            ;;
    esac

    # shift args $2 becomes $1
    shift
done

if [[ ! -d $BASE_DIR ]]; then
    printf 'error : not a directory: %s\n' "$BASE_DIR" >&2
    exit 1
fi

FILE_COUNT=$( ls $LS_ARGS $BASE_DIR | wc -l )
echo "$FILE_COUNT files at the root directory"

remove_empty_dirs () {
    if (( $# == 0)); then 
        return
    fi
    local DIR=$1
    
    for f in $( ls $LS_ARGS $DIR); do
        f="$DIR/$f"
        # echo "$f"
        if [[ -d $f ]]; then
            if (( $(ls $LS_ARGS $f | wc -l) == 0 )); then
                echo "removing $f"
                if [[ ! -w $f ]]; then
                    echo "write permission not allowed for this directory"
                fi
                rmdir $f
            else
                # recursive
                remove_empty_dirs $f
            fi
        fi
    done
}

remove_empty_dirs $BASE_DIR

exit 0