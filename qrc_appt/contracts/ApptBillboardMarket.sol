pragma solidity ^0.8.3;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract ElliottArnoldTestMarket is ReentrancyGuard {

        using Counters for Counters.Counter;
        Counters.Counter private _appointmentId;
        Counters.Counter private _appointmentsTaken;
        uint256 private initialArrayLength = 3;
        
        Appointment[] private appointmentList;
        Appointment[] private nonScheduledAppt;
        Appointment[] private scheduledAppt;
       

        struct Appointment { uint256 id; string uri;  bool scheduled; address patient; }
        mapping(uint256 => Appointment) public idToAppointmentMapping;
        mapping(address => Appointment) public addressToAppointmentMapping;
        mapping(address => Appointment) public addressTo_Id_AppointmentMapping;

        string[]  private appointmentsURI =  [
        "https://ipfs.infura.io/ipfs/QmXhitEMK2LBbABA7bJH5iKGZTqLbZ2aSZb2fYhPJXg3oM",
        "https://ipfs.infura.io/ipfs/QmY1D2sw7Wd9TGfnWWVFBrkbDu6V89586fdLzWath9bAch",
        "https://ipfs.infura.io/ipfs/Qma6jdX5zJnpxTmioQZaMsddUwHSvR7LVuTPGwQHZjVaJT",
        "https://ipfs.infura.io/ipfs/QmYwBNQ5zWummdYKbKHCo7jcLt37d4pgMuEnxWXEqyAChj",
        "https://ipfs.infura.io/ipfs/QmSuamm9dWgppeTrYSwL4fp26FBGpg6pT6rUcqBgBTL8pQ",
        "https://ipfs.infura.io/ipfs/QmdG8BdW4ueHpAAw4SLbUFE546FxHdsMPTHe3nKyKJYCVJ",
        "https://ipfs.infura.io/ipfs/QmdqNNS7JUkWGBFNw9Q1VohrnbP53cn2nz2Z57Z5SkUBFW",
        "https://ipfs.infura.io/ipfs/QmRjQbXbZWhPdaLZDtm6mn2YBfzYfPyPqggJSjfSAy3Mav",
        "https://ipfs.infura.io/ipfs/QmVZC8ZEjW6vXDKYxcLasSyQGG14foNk2hUxR73dZzV7ip",
        "https://ipfs.infura.io/ipfs/QmduZLprUJYWAXgpxP4R5nmW6xv483SESTHYJPsuDJR5uo",
        "https://ipfs.infura.io/ipfs/QmdUheuTBNMAQ2VWCpka4bixQ5iUVGqzuV1JXqcWo69AWd",
        "https://ipfs.infura.io/ipfs/QmXyUSx5eUHZNvAwWytc1T7ZMKTkP9x9txoWspVdh1Xaas",
        "https://ipfs.infura.io/ipfs/QmWCWBNTNXpsCBh3Wchn7DQQ27LgJdrqTRm6Pbh8aPD6oX",
        "https://ipfs.infura.io/ipfs/QmbGzfQ9ovLtf8UTjvvRjFMcf1jS8KZmmdMiuC3WfFq9bP",
        "https://ipfs.infura.io/ipfs/QmeQ4Aco2E4gCCp6LHdN65hwJe4hJ8Jj6oVqDQPLDL4ZPm",
        "https://ipfs.infura.io/ipfs/QmbtQu44dwdS8nVaZbJXfeNtRPXkFio8NoUKjiaQZc7iEG",
        "https://ipfs.infura.io/ipfs/QmUcYfquj8pDDywsPmv3Qy4jjMoeFHxMJACC2QLz1ZeB1u",
        "https://ipfs.infura.io/ipfs/QmY5ZHErrkRsUGqTvzmkYxA4pqmvvc3UJXYCsV3Yeh9FMa",
        "https://ipfs.infura.io/ipfs/Qmct26EJaMgqUADUZtjXZdziT5TtuALZDAVUe3fqJgkCLP",
        "https://ipfs.infura.io/ipfs/QmSYnF9T9MVMuLH91v1otzYV3N5LZCdCj4MzDQLuiNsy4f",
        "https://ipfs.infura.io/ipfs/QmaSKc7s2dDYg1Pc3EfQ3L8NK4NM1yuTdKxhbqFUqpij1T",
        "https://ipfs.infura.io/ipfs/Qmc9fjkrsWKbfmZqa67m1vywLh6ynMJdZwzdA2r1nSxdfC",
        "https://ipfs.infura.io/ipfs/QmU3oU3MqHHk2WYc4DHxbuCuAHXSDoWEyd9EoVmbcKtjFM",
        "https://ipfs.infura.io/ipfs/QmS74dQ6WhvroDUSem2sad8H7u6rrSLRhy5Di6gvc4e3TQ",
        "https://ipfs.infura.io/ipfs/QmbT4pJqj9W11YCCmN7vnY1eyxgCbpo9LUv8SinDvisv5g",
        "https://ipfs.infura.io/ipfs/QmPm9heGZKEWL7ycpc4F4gYwu89X3nJWhReNKvZCh6dbz6",
        "https://ipfs.infura.io/ipfs/QmNcjhskzQgLdRpBCxzjeNz7npM5FmNnykUqPcaBQrJmWm",
        "https://ipfs.infura.io/ipfs/QmaGeD1EBbb4d51ze8HRJvturYGKPGQxx8aCmWNPa7PsAq",
        "https://ipfs.infura.io/ipfs/Qmb8yPXm1H52rWASTKqnYqsvr2TTJX1AzW4UexfevLcnuH",
        "https://ipfs.infura.io/ipfs/QmU9ScjwBpabFWHcF82QXs4mhq1jpVMc1R7C1B8tsA4iMs",
        "https://ipfs.infura.io/ipfs/QmQjAKp3X97roW68FwMbK5fWXAbF9jTHMHAk3ztg5ZamTe",
        "https://ipfs.infura.io/ipfs/QmUt6i7HS7SMH7fBkk1hhP3bo3HxpAL96w2huTKhs5qRXw",
        "https://ipfs.infura.io/ipfs/QmeaUGCP9esCvQPWMruUxMvL8hRmRWeY4YgweuSEDJQE6Z",
        "https://ipfs.infura.io/ipfs/QmRKiRmd8TZ2KjpPR3MTcxkGiD3YaVW89mN2mac2KazToZ",
        "https://ipfs.infura.io/ipfs/QmTx2tYCHdLzD296hnNnAw38AjnvGm4uo13kSCMMfUpoeX",
        "https://ipfs.infura.io/ipfs/QmY9o8NMsKC1uQxeEZE4JVY3CUCHND8JRtaxidSepeRCMw"
        ];
        
      constructor() {   init();  }

      function init()  private {
               for (uint256 i = 0; i < 3; i++) {
                idToAppointmentMapping[i]  =  
                     Appointment({id: i,  uri:  appointmentsURI[i], scheduled: false, patient: address(0)} );    

                appointmentList.push( Appointment({id: i,  uri:  appointmentsURI[i],
                 scheduled: false, patient: address(0)} ) );                                             
      }
}

      // you will receive a TypeError if the memory keyword is not used behind return type TypeError: Data location must be "memory" or "calldata" for return parameter in function, but none was given.
        function fetchNonScheduledAppointments() public  returns (  Appointment[] memory ) { 
        // TypeError: Data location must be "storage", "memory" or "calldata" for variable, but none was given.

                for (uint256 i = 0; i < initialArrayLength; i++) {
                        if (idToAppointmentMapping[i].scheduled == false) {

                                nonScheduledAppt.push(appointmentList[i]);

                        }

                }

                return nonScheduledAppt;


        }

        function fetchScheduledAppointments() public  returns (  Appointment[] memory ) { 
        // TypeError: Data location must be "storage", "memory" or "calldata" for variable, but none was given.

                for (uint256 i = 0; i < initialArrayLength; i++) {
                        if (idToAppointmentMapping[i].scheduled == true) {

                                nonScheduledAppt.push(appointmentList[i]);

                        }

                }

                return nonScheduledAppt;


        }   


        function scheduleAppointment( uint256 id, address patientAddress) public {

                
                
                idToAppointmentMapping[id].scheduled = true;
                idToAppointmentMapping[id].patient = patientAddress;
                addressTo_Id_AppointmentMapping[patientAddress] = idToAppointmentMapping[id];

                _appointmentsTaken.increment();               


        }



        function unScheduleAppointment( uint256 id) public {

                _appointmentsTaken.decrement();   
                idToAppointmentMapping[id].scheduled = false;
                idToAppointmentMapping[id].patient = address(0);           


        }

          function viewMyScheduleAppointment() public  view returns ( Appointment[] memory ) {                

                uint myApptsCount = 0;

                // Iterate through array of all appts and check for those which match patient (address) attribute

                for (uint256 i = 0; i < initialArrayLength; i++) {
                        if (idToAppointmentMapping[i].patient == msg.sender) {                                
                                // Create a local count of appointments made by the seller 
                                myApptsCount ++;                                

                        }
                }

                //Need to create a new array in the function that will hold users appts using the count of appts scheduled by user
                Appointment[] memory myAppts = new Appointment[](myApptsCount);


                for (uint256 i = 0; i < initialArrayLength; i++) {
                        if (idToAppointmentMapping[i].patient == msg.sender) {

                                // push method is not avail for in memory arrays only storage arrays 
                                myAppts[i] = idToAppointmentMapping[i];

                        }

                }

                return myAppts;


        }

}