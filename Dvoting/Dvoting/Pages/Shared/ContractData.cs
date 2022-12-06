using Dvoting.Models;
using Nethereum.Contracts;
using System.Xml.Linq;
using System;
using System.Reflection.Metadata;

namespace Dvoting.Pages.Shared
{
    public class ContractData
    {
        public static string URL = "HTTP://localhost:8545";
        public static string ContractAddress = "0xebceb60651802af725836DDE7a8A1EAEAF273377";
        public static string ABI = @"  [
    {
      ""inputs"": [
        {
          ""internalType"": ""uint256"",
          ""name"": ""_votingDays"",
          ""type"": ""uint256""
        }
      ],
      ""stateMutability"": ""nonpayable"",
      ""type"": ""constructor""
    },
    {
      ""inputs"": [
        {
          ""internalType"": ""address"",
          ""name"": ""_voter"",
          ""type"": ""address""
        }
      ],
      ""name"": ""permitToVote"",
      ""outputs"": [],
      ""stateMutability"": ""nonpayable"",
      ""type"": ""function""
    },
    {
      ""inputs"": [
        {
          ""internalType"": ""address"",
          ""name"": ""_voter"",
          ""type"": ""address""
        }
      ],
      ""name"": ""removePermission"",
      ""outputs"": [],
      ""stateMutability"": ""nonpayable"",
      ""type"": ""function""
    },
    {
      ""inputs"": [
        {
          ""internalType"": ""address"",
          ""name"": ""_newOwner"",
          ""type"": ""address""
        }
      ],
      ""name"": ""transferOwnership"",
      ""outputs"": [],
      ""stateMutability"": ""nonpayable"",
      ""type"": ""function""
    },
    {
      ""inputs"": [
        {
          ""internalType"": ""uint256"",
          ""name"": ""_candidateId"",
          ""type"": ""uint256""
        }
      ],
      ""name"": ""vote"",
      ""outputs"": [],
      ""stateMutability"": ""nonpayable"",
      ""type"": ""function""
    },
    {
      ""inputs"": [],
      ""name"": ""getVotingPeriod"",
      ""outputs"": [
        {
          ""internalType"": ""uint256"",
          ""name"": '',
          ""type"": ""uint256""
        }
      ],
      ""stateMutability"": ""view"",
      ""type"": ""function"",
      ""constant"": true
    },
    {
    ""inputs"": [],
      ""name"": ""getCandidates"",
      ""outputs"": [
        {
        ""components"": [
            {
            ""internalType"": ""uint24"",
              ""name"": ""votesCount"",
              ""type"": ""uint24""
            },
            {
            ""internalType"": ""string"",
              ""name"": ""name"",
              ""type"": ""string""
            }
          ],
          ""internalType"": ""struct Dvoting.candidate[] "",
          ""name "": '',
          ""type "": ""tuple[] ""
        }
      ],
      ""stateMutability "": ""view "",
      ""type "": ""function "",
      ""constant "": true
    },
    {
    ""inputs"": [
        {
        ""internalType"": ""uint256"",
          ""name"": ""_candidateId"",
          ""type"": ""uint256""
        }
      ],
      ""name"": ""getCandidate"",
      ""outputs"": [
        {
        ""components"": [
            {
            ""internalType"": ""uint24"",
              ""name"": ""votesCount"",
              ""type"": ""uint24""
            },
            {
            ""internalType"": ""string"",
              ""name"": ""name"",
              ""type"": ""string""
            }
          ],
          ""internalType"": ""struct Dvoting.candidate "",
          ""name "": '',
          ""type "": ""tuple ""
        }
      ],
      ""stateMutability "": ""view "",
      ""type "": ""function "",
      ""constant "": true
    },
    {
    ""inputs"": [
        {
        ""internalType"": ""address"",
          ""name"": ""_voterAddress"",
          ""type"": ""address""
        }
      ],
      ""name"": ""getVoter"",
      ""outputs"": [
        {
        ""components"": [
            {
            ""internalType"": ""bool"",
              ""name"": ""registered"",
              ""type"": ""bool""
            },
            {
            ""internalType"": ""bool"",
              ""name"": ""voted"",
              ""type"": ""bool""
            }
          ],
          ""internalType"": ""struct Dvoting.voter "",
          ""name "": '',
          ""type "": ""tuple ""
        }
      ],
      ""stateMutability "": ""view "",
      ""type "": ""function "",
      ""constant "": true
    },
    {
    ""inputs"": [],
      ""name"": ""getWinnerCandidate"",
      ""outputs"": [
        {
        ""internalType"": ""string"",
          ""name"": '',
          ""type"": ""string""
        }
      ],
      ""stateMutability"": ""view"",
      ""type"": ""function"",
      ""constant"": true
    }
  ]";
    
    }
}
//name object raises an error, make sure that its has apporpriate opening and closing quotes