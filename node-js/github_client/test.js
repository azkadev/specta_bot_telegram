var lib = require("./src/index");

async function main() {
    var gh = new lib.GithubClient("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");
    var data = await gh.getFollowers("Tahlreth", {
        "page": 1
    });
    var berhasil = 0;
    var gagal = 0;
    var total = data.length;
    
    for (let index = 0; index < data.length; index++) {
        const element = data[index];
        try {
            await gh.followAccountUser(element.login);
            console.log("berhasil "+berhasil);
            berhasil++;
        } catch (e) {
            console.log("gagal "+gagal);
            gagal++;
        }
    }
    console.log(`berhasil ${berhasil}, gagal ${gagal}, ${total}`);
}

main();