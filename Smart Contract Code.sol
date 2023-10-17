//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.8;

contract Dvoting {
    address private s_owner;
    uint256 private immutable i_votingPeriod;

    struct candidate {
        uint24 votesCount;
        string name;
    }

     candidate[]  private s_candidates;

    struct voter {
        bool registered;
        bool voted;
    }

    mapping(address => voter) s_voters;


    constructor(
        uint256 _votingDays ,string[] memory _candidates
    ) {
        s_owner = msg.sender;
        i_votingPeriod = block.timestamp + (_votingDays * 1 days);

        for(uint i=0;i<_candidates.length;i++){
            s_candidates.push(candidate(0, _candidates[i]));
        }          
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
        require(s_voters[msg.sender].registered, "You Are Not Allowed To Vote");
        require(!s_voters[msg.sender].voted, "You Already Voted");
        _;
    }


    //Owners functions
    function permitToVote(address _voter) public onlyOwner withinVotingPeriod {
        require(!s_voters[_voter].registered, "User Already Added");
        s_voters[_voter].registered = true;
    }

    function removePermission(address _voter) public onlyOwner withinVotingPeriod {     
        require(s_voters[_voter].registered, "User Has Not Been Added");
        s_voters[_voter].registered = false;
    }

     function transferOwnership(address _newOwner)public onlyOwner {
         s_owner = _newOwner;
     }


    //public functions
    function vote(uint256 _candidateId) public allowedToVote withinVotingPeriod
    {
        s_voters[msg.sender].voted = true;
        s_candidates[_candidateId].votesCount++; 
    }

    /*Pure And View Functions*/
    function getVotingPeriod() external view returns (uint256) {
        return i_votingPeriod;
    }

    function getCandidates() external view returns (candidate[] memory) {
        return s_candidates;
    }

    function getCandidate(uint256 _candidateId) external view returns (candidate memory)
    {
        return s_candidates[_candidateId];
    }
   
}
