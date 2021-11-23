var lib = require("./src/index");

async function main(){
    var gh = new lib.GithubClient("");
    var data = await gh.getUserRepos("azkauserrobot");
    console.log(data);   
}

main();