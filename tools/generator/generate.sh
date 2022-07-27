#!/bin/bash
if ! [ -d "$(dirname $(readlink -f $0))/node_modules" ]
then
    echo "Error: not installed. Make sure to run 'rush install' before using 'rush create'."
    exit 1
fi

project_type=$1
project_name=$2

target_path=$RUSH_INVOKED_FOLDER

case $project_type in
    app)
        target_path=$MONOREPO_ROOT/apps;;
    component)
        target_path=$MONOREPO_ROOT/components;;
    extension)
        target_path=$MONOREPO_ROOT/extensions;;
    library)
        target_path=$MONOREPO_ROOT/libraries;;
    service)
        target_path=$MONOREPO_ROOT/services;;
    tool)
        target_path=$MONOREPO_ROOT/tools;;
    template)
        target_path=$MONOREPO_ROOT/templates;;
    meta)
        target_path=$MONOREPO_ROOT/meta;;
    *)
        echo "Error: unrecognized project type '${project_type}'. See ${MONOREPO_ROOT}/templates/README.md for available options.";
        exit 1;;
esac

cd $target_path

"${MONOREPO_ROOT}/$(dirname $0)/node_modules/.bin/hygen" "$project_type" "new" "$project_name"
