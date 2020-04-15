pragma solidity ^0.6.0;

contract Add_Members{
    
    // this is type of an individual member of the network
    struct Member { 
                uint balance; 
                address payable maddress;
            }
    
    // This is a type for a single proposal.
    struct Proposal {
        string name;   // short name (up to 32 bytes)
        uint256 proposalvalue;
        address proposer; // the member who submitted the proposal
        uint256 startingPeriod; // the period in which voting can start for this proposal
        uint256 yesVotes; // the total number of YES votes for this proposal
        uint256 noVotes; // the total number of NO votes for this proposal
        bool processed; // true only if the proposal has been processed
        bool didPass; // true only if the proposal passed
        bool aborted; // true only if applicant calls "abort" fn before end of voting period
        mapping(address => Vote) votesByMember;
    }
    
    mapping (address => Member) accounts; // Calling Members account details using his address
    
     struct Voter {
                bool voted;  // if true, that person already voted
                uint vote;   // index of the voted proposal
    }

 
    address public chairperson; // Created a chairperson address
    
    
    mapping(address => Voter) public voters; // Calling Voters details using his address
    
    // A dynamically-sized array of `Proposal` structs.
    Proposal[] public proposals;
    
                                            // constructor(string[] memory proposalNames)
                                            // public {
                                                
                                            //     chairperson = msg.sender;
                                        
                                            //     // For each of the provided proposal names,
                                            //     // create a new proposal object and add it
                                            //     // to the end of the array.
                                            //     for (uint i = 0; i < proposalNames.length; i++) {
                                            //         // `Proposal({...})` creates a temporary
                                            //         // Proposal object and `proposals.push(...)`
                                            //         // appends it to the end of `proposals`.
                                            //         proposals.push(Proposal({name: proposalNames[i],voteCount: 0}));
                                            //     }
                                            // }
    constructor()   public {
        
        chairperson = msg.sender;

    }
    
        
    event SubmitProposal(uint256 proposalIndex ,address indexed proposer,  uint256 totalworth);
    event SubmitVote(uint256 indexed proposalIndex, address indexed delegateKey, address indexed memberAddress, uint8 uintVote);
    event ProcessProposal(uint256 indexed proposalIndex, address indexed applicant, address indexed memberAddress, uint256 tokenTribute, uint256 sharesRequested, bool didPass);

    
    function selfAdd(uint256 value) public returns(bool)
    {
        require(value > 10, "Deposit shall be greater than 10 Ether");
         /*
              Function Adds the caller only if he is giving depositing greater than 10 ETH in the network.
              takes Proposal string and proposal worth value as input.
        */
        accounts[msg.sender].balance += value;
        accounts[msg.sender].maddress = msg.sender;
        return true;
    }
    
    /// Give your vote (including votes delegated to you)
    /// to proposal `proposals[proposal].name`.
    function addProposal(string memory _proposalname , uint256  _proposalworth) onlyAcccountHolder public returns(bool)
    {
        uint256 proposalIndex;
        /*
              function Adds Proposals based on the condition of the only if he is a member of the network.
              takes Proposal string and proposal worth value as input.
        */
     proposals.push(Proposal({name: _proposalname,
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
    
    
    // function vote(uint _proposal) public {
    //     Voter storage sender = voters[msg.sender];
    //     require(!sender.voted, "Already voted.");
    //     sender.voted = true;
    //     sender.vote = _proposal;

    //     // If `proposal` is out of the range of the array,
    //     // this will throw automatically and revert all
    //     // changes.
    //     proposals[_proposal].voteCount += 1;
    // }
    
    enum Vote {
        Null, // default value, counted as abstention
        Yes,
        No
    }

    
    // function submitVote(uint256 proposalIndex, uint8 uintVote) public {
    //     address memberAddress = memberAddressByDelegateKey[msg.sender];
    //     Member storage member = members[memberAddress];

    //     require(proposalIndex < proposalQueue.length, "Moloch::submitVote - proposal does not exist");
    //     Proposal storage proposal = proposalQueue[proposalIndex];

    //     require(uintVote < 3, "Moloch::submitVote - uintVote must be less than 3");
    //     Vote vote = Vote(uintVote);

    //     //require(getCurrentPeriod() >= proposal.startingPeriod, "Moloch::submitVote - voting period has not started");
    //     //require(!hasVotingPeriodExpired(proposal.startingPeriod), "Moloch::submitVote - proposal voting period has expired");
    //     require(proposal.votesByMember[memberAddress] == Vote.Null, "Moloch::submitVote - member has already voted on this proposal");
    //     require(vote == Vote.Yes || vote == Vote.No, "Moloch::submitVote - vote must be either Yes or No");
    //     require(!proposal.aborted, "Moloch::submitVote - proposal has been aborted");

    //     // store vote
    //     proposal.votesByMember[memberAddress] = vote;

    //     // count vote
    //     if (vote == Vote.Yes) {
    //         proposal.yesVotes = proposal.yesVotes.add(member.shares);

    //         // set highest index (latest) yes vote - must be processed for member to ragequit
    //         if (proposalIndex > member.highestIndexYesVote) {
    //             member.highestIndexYesVote = proposalIndex;
    //         }

    //         // set maximum of total shares encountered at a yes vote - used to bound dilution for yes voters
    //         if (totalShares > proposal.maxTotalSharesAtYesVote) {
    //             proposal.maxTotalSharesAtYesVote = totalShares;
    //         }

    //     } else if (vote == Vote.No) {
    //         proposal.noVotes = proposal.noVotes.add(member.shares);
    //     }

    //     emit SubmitVote(proposalIndex, msg.sender, memberAddress, uintVote);
    // }
    
    
   
   
   
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

