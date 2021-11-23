const { Octokit } = require("@octokit/core");
// or: import { Octokit } from "@octokit/core";

async function main() {

    // Create a personal access token at https://github.com/settings/tokens/new?scopes=repo
    const octokit = new Octokit({ auth: `` });

    const response = await octokit.request("", {
        "username": "azkauserrobot"
    });

    if (response && response.status == 200 && response.data) {
        console.log(JSON.stringify(response.data, null, 2));
    }

}

main();