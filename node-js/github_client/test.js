var lib = require("./src/index");

async function main(){
    var gh = new lib.GithubClient("as");
    var data = await gh.invokeAsync()

    console.log(data);   
}

main();