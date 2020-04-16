pragma solidity >=0.4.22 <0.7.0;

import "./Utilities.sol";

contract crowdao is utilities{
    constructor()   public {
        
        chairperson = msg.sender;
        proposalIndex = 0;

    }
    
    function selfAdd(uint256 value) external returns(uint256)
    {
        require(value > 10, "Deposit shall be greater than 10 Ether");
         /*
              Function Adds the caller only if he is giving depositing greater than 10 ETH in the network.
              takes Proposal string and proposal worth value as input.
        */
        accounts[msg.sender].balance += value;
        accounts[msg.sender].maddress = msg.sender;
        return accounts[msg.sender].balance;
    }
        function addProposal(string memory _proposalname , uint256  _proposalworth) onlyAcccountHolder public returns(bool)
    {
        /*
              function Adds Proposals based on the condition of the only if he is a member of the network.
              takes Proposal string and proposal worth value as input.
        */
     proposalIndex +=1;
     proposals.push(Proposal({uid : proposalIndex,
                              name: _proposalname,
                              proposalvalue: _proposalworth,
                              startingPeriod: now,
                              yesVotes:0,
                              noVotes:0,
                              processed:false,
                              didPass:false,
                              aborted:false,
                              proposer:msg.sender
     }));   
     proposalIndex = proposals.length - 1;
     emit SubmitProposal(proposalIndex,msg.sender,_proposalworth);
     return true;
    }
    
    function FetchProposalIndex(string memory _proposalname , uint256  _proposalworth) public returns(uint256){
        uint256 I;
        for (uint256 i=0;i<=proposals.length;i++){
            if (keccak256(proposals[i].name) == keccak256(_proposalname) && proposals[i].proposalvalue  == _proposalworth)
            {
                return I;
            }
		}
    }

    function submitVote(uint256 proposalIndex, uint8 uintVote) public {
    //    Member storage member = members[msg.sender];
         address memberAddress = msg.sender;
    //     require(uintVote < 3, "Moloch::submitVote - uintVote must be less than 3");
        Vote vote = Vote(uintVote);

    //     //require(getCurrentPeriod() >= proposal.startingPeriod, "Moloch::submitVote - voting period has not started");
    //     //require(!hasVotingPeriodExpired(proposal.startingPeriod), "Moloch::submitVote - proposal voting period has expired");
         require(proposals[proposalIndex].votesByMember[memberAddress] == Vote.Null, "Moloch::submitVote - member has already voted on this proposal");
         require(vote == Vote.Yes || vote == Vote.No, "Moloch::submitVote - vote must be either Yes or No");
        // store vote
         proposals[proposalIndex].votesByMember[memberAddress] = vote;

    //    Adding counts to respective Yes or No
         if (vote == Vote.Yes) {
            proposals[proposalIndex].yesVotes  += 1;

         } else if (vote == Vote.No) {
            proposals[proposalIndex].noVotes += 1;
         }
         
         emit SubmitVote(proposalIndex, msg.sender, memberAddress, uintVote);
     }
    
    
   
   
   
    function addBalance(uint amount, address addr) public
    {
        accounts[addr].balance += amount;
    }
    
    function getBalance(address addr) public view returns (uint) {
        return accounts[addr].balance;
    }
    
    modifier CheckBalance{
        require(accounts[msg.sender].balance >= 10, "You cannot perform this actions as you have insufficient balance");
        _;
    }

    modifier onlyAcccountHolder {
        require(accounts[msg.sender].maddress == msg.sender, "You cannot perform this actions as you are not a member");
        _;
    }
    
}