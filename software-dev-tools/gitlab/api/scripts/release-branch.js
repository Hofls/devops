let releaseName = 'release-1.0.3';
let projects = ['1322', '2374', '2873', '4231', '8271']
let token = "asd2-ldfjs83SjlwqSONSZldne";

for (let project of projects) {
    await createBranch(project, releaseName, 'develop')
    console.log(`Project ${project} done!`)
}

async function createBranch(projectId, newBranch, oldBranch) {
    let url = `https://example.com/api/v4/projects/${projectId}/repository/branches?branch=${newBranch}&ref=${oldBranch}`;
    let response = await fetch(url, {
        "method": "POST",
        "headers": {
            "PRIVATE-TOKEN": token
        }
    });
    if (!response.ok) {
        throw "Unable to create a new branch"
    }
}