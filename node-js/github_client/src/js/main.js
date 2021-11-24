var { Octokit } = require("@octokit/core");

class GithubClient {
    constructor(SecretPersonalToken) {
        if (!SecretPersonalToken) {
            throw {
                "message": "PLease Fill token"
            };
        }
        this.octokit = new Octokit({ auth: String(SecretPersonalToken) });
    }

    async invokeAsync(objectOriginal = {}, newObject = {}) {
        if (newObject) {
            for (var key in newObject) {
                if (Object.hasOwnProperty.call(newObject, key)) {
                    var loop_data = newObject[key];
                    objectOriginal[key] = loop_data;
                }
            }
        }
        return objectOriginal;
    }

    async getMe() {
        var response = await this.octokit.request("GET /user");
        if (response && response.status == 200 && response.data) {
            return response.data;
        }
    }

    async getUser(username) {
        var response = await this.octokit.request("GET /users/{username}", {
            "username": String(username)
        });
        if (response && response.status == 200 && response.data) {
            return response.data;
        }
    }

    async getFollowers(username, option = {}) {
        var data = await this.invokeAsync({ "username": String(username) }, option);
        var response = await this.octokit.request("GET /users/{username}/followers", data);
        if (response && response.status == 200 && response.data) {
            return response.data;
        }
    }

    async getFollowing(username) {
        var response = await this.octokit.request("GET /users/{username}/following", {
            "username": String(username)
        });
        if (response && response.status == 200 && response.data) {
            return response.data;
        }
    }

    async getFollowingByUser(username, target_user) {
        var response = await this.octokit.request("GET /users/{username}/following/{target_user}", {
            "username": String(username),
            "target_user": String(target_user)
        });
        if (response && response.status == 200 && response.data) {
            return response.data;
        }
    }

    async getRepos(type = "user", option = {}) {
        if (String(type).toLocaleLowerCase() == "user") {
            var response = await this.octokit.request("GET /user/repos", option);
            if (response && response.status == 200 && response.data) {
                return response.data;
            }
        } else if (String(type).toLocaleLowerCase() == "organization") {
            var response = await this.octokit.request("GET /orgs/{org}/repos", option);
            if (response && response.status == 200 && response.data) {
                return response.data;
            }
        } else {

        }
    }

    async getStarred(option = {}) {
        var response = await this.octokit.request("GET /user/starred", option);
        if (response && response.status == 200 && response.data) {
            return response.data;
        }
    }


    async getStarredByUser(owner, repo) {
        var response = await this.octokit.request("GET /user/starred/{owner}/{repo}", {
            "owner": owner,
            "repo": repo
        });
        if (response && response.status == 200 && response.data) {
            return response.data;
        }
    }

    async getUserRepos(username, option = {}) {
        var data = await this.invokeAsync({ "username": String(username) }, option);
        var response = await this.octokit.request("GET /users/{username}/repos", data);
        if (response && response.status == 200 && response.data) {
            return response.data;
        }
    }

    async getOrgRepos(username) {
        var response = await this.octokit.request("GET /orgs/{org}/repos", {
            "org": String(username)
        });
        if (response && response.status == 200 && response.data) {
            return response.data;
        }
    }

    async getStarredByUsername(username, option = {}) {
        var data = await this.invokeAsync({ "username": String(username) }, option);
        var response = await this.octokit.request("GET /users/{username}/starred", data);
        if (response && response.status == 200 && response.data) {
            return response.data;
        }
    }

    async followAccountUser(username = "azkadev") {
        var response = await this.octokit.request("PUT /user/following/{username}", {
            "username": username
        });
        if (response && response.status == 200 && response.data) {
            return response.data;
        }
    }

    async starsRepoUser(username = "azkadev", repo = "") {
        var response = await this.octokit.request("PUT /user/starred/{owner}/{repo}", {
            "owner": username,
            "repo": repo
        });
        if (response && response.status == 200 && response.data) {
            return response.data;
        }
    }

};

module.exports = {
    GithubClient
};