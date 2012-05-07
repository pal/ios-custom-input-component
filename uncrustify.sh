#!/bin/bash

# Remove 'Created by ...' spam
find . -name "*.[hm]" | xargs sed -i '' '/Created/d'

# Run uncrustify using project settings
find . -name "*.[hm]" | xargs uncrustify -c .uncrustify.cfg --no-backup -l OC+
