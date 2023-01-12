//SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

contract Dvoting {
    address private s_owner;
    uint256 private immutable i_votingPeriod;
    //uint24 private  s_latestId = 1;

    struct candidate {
        uint24 votesCount;
        string name;
    }

    candidate[] private s_candidates; //TODO: make it immutable later

    struct voter {
        // uint24 voterId;
        bool registered;
        bool voted;
    }

    //voter[] public s_voters;
    mapping(address => voter) s_voters;

    //TODO: remove the comments when deploying in localhost
    constructor(
        uint256 _votingDays /*,candidate[] memory _candidates*/
    ) {
        s_owner = msg.sender;
        i_votingPeriod = block.timestamp + (_votingDays * 1 days);

        //s_candidates=_candidates;

        //TODO:remove the following lines, its for testing
        s_candidates.push(candidate(0, "Aws Rayyan"));
        s_candidates.push(candidate(0, "Mahmood Atari"));
        s_candidates.push(candidate(0, "Aws Al Masri"));       
    }

    //Modifiers
    modifier onlyOwner() {
        require(
            msg.sender == s_owner,
            "Only The Owner Is Allowed To Perform This Operation"
        );
        _;
    }

    modifier withinVotingPeriod() {
        require(
            block.timestamp <= i_votingPeriod,
            "Voting Period Has Been Exceeded"
        );
        _;
    }

    modifier allowedToVote() {
        // require(s_voters[msg.sender].voterId != 0,"You Are Not Allowed To Vote");
        require(s_voters[msg.sender].registered, "You Are Not Allowed To Vote");

        require(!s_voters[msg.sender].voted, "You Already Voted");
        _;
    }


    //Owners functions

    function permitToVote(address _voter) public onlyOwner withinVotingPeriod {
        //require(s_voters[_voter].voterId == 0,"User Already Added");
        require(!s_voters[_voter].registered, "User Already Added");

        s_voters[_voter].registered = true;
        //s_latestId ++;
    }

    function removePermission(address _voter) public onlyOwner withinVotingPeriod {     
        require(s_voters[_voter].registered, "User Has Not Been Added");
        s_voters[_voter].registered = false;
        //s_latestId ++;
    }


     function transferOwnership(address _newOwner)public onlyOwner {
         s_owner = _newOwner;
     }


    //public functions
    function vote(uint256 _candidateId)
        public
        allowedToVote
        withinVotingPeriod
    {
        s_candidates[_candidateId].votesCount++;
        s_voters[msg.sender].voted = true;
    }

    /*Pure And View Functions*/

    function getVotingPeriod() external view returns (uint256) {
        return i_votingPeriod;
    }

    function getCandidates() external view returns (candidate[] memory) {
        return s_candidates;
    }

    function getCandidate(uint256 _candidateId)
        external
        view
        returns (candidate memory)
    {
        return s_candidates[_candidateId];
    }

    function getVoter(address _voterAddress)
        external
        view
        returns (voter memory)
    {
        return s_voters[_voterAddress];
    }

    function getWinnerCandidate() external view returns (string memory) {
        uint256 winnerID = 0;

        for (uint256 i = 1; i < s_candidates.length; ++i) {
            if (
                s_candidates[i].votesCount > s_candidates[winnerID].votesCount
            ) {
                winnerID = i;
            }
        }

        return s_candidates[winnerID].name;
    }
}
