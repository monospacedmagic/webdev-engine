"use strict";

function getRushVersion() {
    const rushPreviewVersion = process.env['RUSH_PREVIEW_VERSION'];
    if (rushPreviewVersion !== undefined) {
        return rushPreviewVersion;
    }
    const rushJsonFolder = process.env['MONOREPO_ROOT'];
    const rushJsonPath = path.join(rushJsonFolder, 'rush.json');
    try {
        const rushJsonContents = fs.readFileSync(rushJsonPath, 'utf-8');
        // Use a regular expression to parse out the rushVersion value because rush.json supports comments,
        // but JSON.parse does not and we don't want to pull in more dependencies than we need to in this script.
        const rushJsonMatches = rushJsonContents.match(/\"rushVersion\"\s*\:\s*\"([0-9a-zA-Z.+\-]+)\"/);
        return rushJsonMatches[1];
    }
    catch (e) {
        throw new Error(`Unable to determine the required version of Rush from rush.json (${rushJsonFolder}). ` +
            "The 'rushVersion' field is either not assigned in rush.json or was specified " +
            'using an unexpected syntax.');
    }
}

Object.defineProperty(exports, "rushVersion", { value: getRushVersion() });
