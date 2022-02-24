pragma solidity ^0.8.3;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract ElliottArnoldTestMarket is ReentrancyGuard {

        using Counters for Counters.Counter;
        Counters.Counter private _appointmentId;
        Counters.Counter private _appointmentsTake;
        struct Appointment { string uri;  bool scheduled; }
        Appointment[] public appointmentList;

        mapping(uint256 => Appointment) public idToAppointmentMapping;

        string[]  private appointmentsURI =  [
                "https://ipfs.infura.io/ipfs/QmPnRz8ickrt4CwuhdfyxBDQQJ88QBPQAmxZESgAde4h5M",
                "https://ipfs.infura.io/ipfs/;QmWQWYejvZYooaRCSSmHpDBiG1ddPEbogT5mJ9vf16gMeT",
                "https://ipfs.infura.io/ipfs/QmNaNvXU1RrBbe3XHGPP2KsyQwUfmSBd1cu4ojwe6KXrT9"
        ];
        
      constructor() {   init();  }

      function init()  private {
               for (uint256 i = 0; i < 3; i++) {
                idToAppointmentMapping[i]  =  
                     Appointment({ uri:  appointmentsURI[i], scheduled: false } );    

                appointmentList.push( idToAppointmentMapping[i] );                                             
      }
}
}