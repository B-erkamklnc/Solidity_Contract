// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract KapsulVoting {

    uint8 projectIDCount = 1;

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

    function addProject(string memory _projectName, address[] memory _teamWallets) public {
        require(projectIDByName[_projectName] == 0, "Project already exists");

        Project memory _newProject = Project({
            id: projectIDCount,
            projectName: _projectName,
            teamWallets: _teamWallets,
            voteCount: 0
        });

        projectDetail[projectIDCount] = _newProject;
        projectIDByName[_projectName] = projectIDCount;

        addToWalletGroup(projectIDCount, _teamWallets);

        projectIDCount++;

    }

    function addToWalletGroup(uint8 _projectIDCount, address[] memory _teamWallets) internal {
        for (uint8 i = 0; i < _teamWallets.length; i++) 
        {
            require(walletGroup[_teamWallets[i]] == 0, "Wallet already added to a group");
            walletGroup[_teamWallets[i]] = _projectIDCount;
        }
    }

    function vote(uint8 _projectID) public {
        require(_projectID < projectIDCount, "Invalid projed id");
        require(!isVoted[msg.sender], "This wallet already voted");
        require(walletGroup[msg.sender] != _projectID, "You can not vote to your own project");

        Project storage _project = projectDetail[_projectID];

        _project.voteCount++;

        isVoted[msg.sender] = true;
    }

    function updateProject(uint8 _id, string memory _newProjectName, address[] memory _newTeamWallets) public {
        require(walletGroup[msg.sender] == _id, "You can not change another project details");

        Project storage _newProject = projectDetail[_id];

        _newProject.projectName = _newProjectName;
        _newProject.teamWallets = _newTeamWallets;
    }

    function getWalletGroup(address _wallet) public view returns(uint8) {
        return walletGroup[_wallet];
    }

    function getIsVoted(address _wallet) public view returns(bool) {
        return isVoted[_wallet];
    }

    function getProjectIDByName(string memory _projectName) public view returns(uint8) {
        return projectIDByName[_projectName];
    }

    function getProjectDetail(uint8 _projectID) public view returns(Project memory) {
        return projectDetail[_projectID];
    }
}
