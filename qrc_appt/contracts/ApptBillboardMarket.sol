pragma solidity ^0.8.3;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract ElliottArnoldTestMarket is ReentrancyGuard {

        using Counters for Counters.Counter;
        // Counters.Counter private _appointmentId;
        Counters.Counter private _appointmentsTaken;
        uint256 private initialArrayLength = 3;
        
        Appointment[] private appointmentList;
        // Appointment[] private nonScheduledAppt;
        Appointment[] private scheduledAppt;
        // Appointment[] private myAppts;

        struct Appointment { uint256 id; string uri;  bool scheduled; address patient; }
        mapping(uint256 => Appointment) public idToAppointmentMapping;
        mapping(address => Appointment) public addressToAppointmentMapping;

        string[]  private appointmentsURI =  [
                "https://ipfs.infura.io/ipfs/QmPnRz8ickrt4CwuhdfyxBDQQJ88QBPQAmxZESgAde4h5M",
                "https://ipfs.infura.io/ipfs/;QmWQWYejvZYooaRCSSmHpDBiG1ddPEbogT5mJ9vf16gMeT",
                "https://ipfs.infura.io/ipfs/QmNaNvXU1RrBbe3XHGPP2KsyQwUfmSBd1cu4ojwe6KXrT9"
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
                addressToAppointmentMapping[patientAddress].patient = patientAddress;

                _appointmentsTaken.increment();               



        }



          function viewMyScheduleAppointment() public  view returns ( Appointment[] memory ) {
                

                
                // Create a count of this 
                //Need to create a new array in the function that will hold users appts using the count of appts scheduled by user
                // return the array 

                uint myApptsCount = 0;

                // Iterate through array of all appts and check for those which match patient (address) attribute

                for (uint256 i = 0; i < initialArrayLength; i++) {
                        if (idToAppointmentMapping[i].patient == msg.sender) {
                                
                                // Create a count of this 
                                myApptsCount ++;
                                

                        }

                }


                Appointment[] memory myAppts = new Appointment[](myApptsCount);



                for (uint256 i = 0; i < initialArrayLength; i++) {
                        if (idToAppointmentMapping[i].patient == msg.sender) {

                                // push method is not avail for in memory arrays only storage 
                                myAppts[i] = idToAppointmentMapping[i];

                        }

                }

                return myAppts;


        }

}