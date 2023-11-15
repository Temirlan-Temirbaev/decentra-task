// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract LessonHomeTask {
    mapping(address => uint256) private votes;

    struct Candidate {
        address candidate_address;
        string candidate_name;
        uint256 votes_count;
    }

    Candidate[] candidates;
    address[] votedAddresses;

    function registrate(string memory name) public returns (string memory) {
        for (uint256 i = 0; i < candidates.length; i++) {
            if (keccak256(bytes(candidates[i].candidate_name)) == keccak256(bytes(name))) {
                revert("Uzhe est' chelick s takim Fio");
            }
        }

        candidates.push(Candidate(msg.sender, name, 0));
        return "Candidate registered successfully";
    }

    function getCandidates() public view returns (Candidate[] memory) {
        return candidates;
    }

    function getNameOfCandidate(address candidate) public view returns (string memory) {
        for (uint256 i = 0; i < candidates.length; i++) {
            if (candidates[i].candidate_address == candidate) {
                return candidates[i].candidate_name;
            }
        }

        revert("TUTA NET CANDIDATA S TAKIM ADDRESSOM");
    }


    function vote(address candidate) public {
        for (uint256 i = 0; i < votedAddresses.length; i++) {
            if (votedAddresses[i] == msg.sender) {
                revert("TI UZHE GOLOSOVAL");
            }
        }

        bool candidateFound = false;

        for (uint256 i = 0; i < candidates.length; i++) {
            if (candidates[i].candidate_address == candidate) {
                candidates[i].votes_count++;
                votedAddresses.push(msg.sender);
                candidateFound = true;
                break;
            }
        }

        if (!candidateFound) {
            revert("TAKOGO CHELIKA NETU");
        }
    }
}
