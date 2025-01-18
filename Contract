// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract KapsulVoting {

    struct Project {
        uint8 id;
        string projectName;
        address[] teamWallets;
        uint8 voteCount;
    }

    mapping(uint8 => Project) projectDetail;
    mapping(string => uint8) projectIDByName;

    mapping(address => uint8) walletGroup;
    mapping(address => bool) isVoted;

    uint8 public projectCount = 0;

    // Yeni proje ekleme
    function addProject(string memory _projectName, address[] memory _teamWallets) public {
        require(projectIDByName[_projectName] == 0, "Project already exists");

        projectCount++;
        Project storage newProject = projectDetail[projectCount];
        newProject.id = projectCount;
        newProject.projectName = _projectName;
        newProject.teamWallets = _teamWallets;
        newProject.voteCount = 0;

        projectIDByName[_projectName] = projectCount;
    }

    // Oy verme
    function vote(uint8 _projectID) public {
        require(projectDetail[_projectID].id != 0, "Project does not exist");
        require(!isVoted[msg.sender], "You have already voted");

        // Kullanıcı kendi grubuna oy veremez
        for (uint8 i = 0; i < projectDetail[_projectID].teamWallets.length; i++) {
            require(
                projectDetail[_projectID].teamWallets[i] != msg.sender,
                "You cannot vote for your own group"
            );
        }

        isVoted[msg.sender] = true;
        projectDetail[_projectID].voteCount++;
    }

    
    function getWalletGroup(address _wallet) public view returns (uint8) {
        return walletGroup[_wallet];
    }

    function getIsVoted(address _wallet) public view returns (bool) {
        return isVoted[_wallet];
    }

    function getProjectIDByName(string memory _projectName) public view returns (uint8) {
        return projectIDByName[_projectName];
    }

    function getProjectDetail(uint8 _projectID) public view returns (Project memory) {
        return projectDetail[_projectID];
    }
}
