let projects = ['1322', '2374', '2873', '4231', '8271']
let backupName = 'test-backup-' + new Date().toISOString().split('T')[0]
let token = "asd2-ldfjs83SjlwqSONSZldne";

for (let project of projects) {
    await createBranch(project, backupName, 'test')
    await deleteBranch(project, 'test')
    await createBranch(project, 'test', 'develop')
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

async function deleteBranch(projectId, branch) {
    let url = `https://example.com/api/v4/projects/${projectId}/repository/branches/${branch}`;
    let response = await fetch(url, {
        "method": "DELETE",
        "headers": {
            "PRIVATE-TOKEN": token
        }
    });
    if (!response.ok) {
        throw "Unable to create delete a branch"
    }
}
