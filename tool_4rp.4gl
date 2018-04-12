################################################################################
# tool_4rp.4gl  - Takes passed in 4rp file and extracts localization strings.
# Strings are displayed to screen so output can be redirected to a file.      
# Format matches localization layout for other Genero extracts. (""="").  
#
# Usage: fglrun tool_4rp.42r file.4rp > file.str
#
# NOTE: Only strings that are flagged to be localized in the 4rp file are
# extracted.  The localization flag must be set. 
#
# This code was developed using the features available in Genero BDL 2.40. so it
# is usable for versions 2.40 and above.  New features in newer versions of BDL
# could be refactored into this program to make it better (array sorting/XML) 
# but would not work on earlier versions of BDL.  Tool was needed for 
# localization of 2.40 4rp files.  It was also used on 3.00 4rp files. 
# 
# The code was developed to localize a bunch of 4rp files versus doing manually.
# Only issue found was the use of "&" in strings.  The localized string is 
# saved as "&amp;".  These strings needed to be manually converted to remove 
# the "amp;" in the string.
#
# Code is free and can be shared, changed and impoved to meet your needs.  
#
# Keith R. Yousey  
################################################################################

################################################################################
MAIN
################################################################################
DEFINE
    lv_string          STRING,
    lv_text            STRING,
    lv_ch              base.Channel,
    lv_buf             base.StringBuffer,
    lv_found           SMALLINT,
    lv_ix              INTEGER,
    la_array           DYNAMIC ARRAY OF STRING
#
    LET lv_ch = base.Channel.create()
#
    # Open 4rp file 
    CALL lv_ch.openFile(ARG_VAL(1), "r")
#
    WHILE TRUE
        # Read line from file and put into string.
        LET lv_string   = lv_ch.readLine()
#
        # If end of file is reached we are done.
        IF lv_ch.isEof() THEN
            EXIT WHILE
        END IF
#
        LET lv_buf = base.StringBuffer.create()
        CALL lv_buf.append(lv_string)
#
        # Text needs to be localized 
        IF lv_buf.getIndexof('localizeText="true"', 1) THEN
            LET lv_text = lv_buf.subString(lv_buf.getIndexOf(" text=", 1) + 6,
                                           lv_buf.getIndexOf('" ', 
                                           lv_buf.getIndexOf(" text=", 1) + 7))
#
            LET lv_found = FALSE
#
            # Check and skip duplicates
            FOR lv_ix = 1 TO la_array.getLength()
                IF la_array[lv_ix] = lv_text THEN
                    LET lv_found = TRUE
                    EXIT FOR 
                END IF 
            END FOR 
#
            # Not a duplicate so output and save in array for duplicate checking
            IF lv_found = FALSE THEN 
                DISPLAY lv_text CLIPPED, "=", lv_text CLIPPED
                LET la_array[la_array.getLength()+1] = lv_text
            END IF 
        END IF 
    END WHILE
#
    CALL lv_ch.close()
END MAIN
