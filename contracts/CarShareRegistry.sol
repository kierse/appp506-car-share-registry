contract CarShareRegistry {
    enum CarState {
        AVAILABLE, UNAVAILABLE, RENTED, IN_DISPUTE
    }
    
    struct Car {
        string vin;
        string ownerPubKey;
        address owner;
        address renter;
        uint8 costPerHour;
        uint8 lat;
        uint8 long;
        string bluetoothName;
        uint8 bluetoothPin;
        CarState state;
    }

    struct Booking {
        string vin;
        uint8 lat;
        uint8 long;
        string bluetoothName;
        unit8 bluetoothPin;
        string unlockCode;
        string ownerPublicKey;
    }
    
    struct CarFeedback {
        uint256 timestamp;
        string vin;
        address renter;
        uint8 cleanliness; // 1 - 10, 1 = terrible, 10 = excellent
        string[] images;   // list of urls pointing to images documenting any/all 
                           // problems with car
    }
    
    struct Dispute {
        uint256 timestamp;
        string vin;
        address renter;
        string renterContactInfo; // encrypted with owner public key
        bool refundRequested;
        bool carIsDamaged; 
        uint8 cleanliness; // 1 - 10, 1 = terrible, 10 = excellent
        string[] images;   // list of urls pointing to images documenting any/all 
                           // problems with car
    }
    
    struct InProgressTransaction {
        address renter;
        string vin;
        uint8 costPerHour;
        uint8 rentalLengthInHours;
        uint8 totalCost;
        string unlockCode;
        string renterPublicKey;
    }
    
    struct CompletedTransaction {
        string vin;
        address renter;
        uint8 totalCost;
    }
    
    // vin => Car
    mapping(string => Car) private cars;
    
    // vin => rental_total
    mapping(string => InProgessTransaction) private pendingTransactions;

    // unretrieved CarFeedback reports
    // vin => CarFeedback[]
    mapping(string => CarFeedback[]) openFeedback;
    
    // ongoing Dispute reports
    mapping(string => Dispute) ongoingDisputes;

    // register new car
    function registerCar(
        string vin, string ownerPubKey, uint8 costPerHour, string bluetoothName, string bluetoothPin, CarState state
    ) public {
        // Use msg.sender and given arguments to create a new Car struct.
        // Add new car to cars mapping
    }
    
    function bookCar(string vin, uint8 rentalLengthInHours, string renterPublicKey) public payable (Booking) {
        /**
         * We have a few things to do here:
         * 
         *  1) Retrieve the Car struct using the indicated vin
         *   1a) Throw exception if vin does NOT map to a Car struct
         *  2) Verify that Car is available to rent
         *   2a) Throw exception if Car's state != CarState.AVAILABLE
         *  3) Use Car.costPerHour and rentalLengthInHours to determine rental cost
         *  4) Verify that renter has sent the correct rental fee (totalCost)
         *   4a) Throw exception if msg.value < totalCost
         *  5) Set Car.state = RENTED
         *  6) Transfer funds from renter to contract
         *   6a) Throw exception if transfer fails
         *  7) Generate random unlock code
         *  8) Create new InProgressTransaction instance and add to pendingTransactions
         *  9) return Booking(vin, lat, long, bluetoothName, bluetoothPin, unlockCode, ownerPubKey)
         * 
         **/
    }
    
    function provideTripFeedback(
        string vin, uint8 cleanliness, string[] images
    ) public {
        /**
         * We have a few things to do here:
         * 
         *  1) Retrieve the Car struct using the indicated vin
         *   1a) Throw exception if vin does NOT map to a Car struct
         *  2) Verify that renter indicated a valid cleanliness value
         *   2a) Throw exception if 1 > cleanliness > 10
         *  3) Verify that images contain urls
         *   3a) Throw exception if any images don't start with http[s]:// (necessary ???)
         *  4) Create new CarFeedback and add to openFeedback mapping
         * 
         **/
    }
    
    function openDispute(
        string vin, 
        bool refundRequested, 
        bool carIsDamaged, 
        uint8 cleanliness, 
        string[] images
    ) public (bool) {
        /**
         * We have a few things to do here:
         * 
         *  1) Retrieve the Car struct using the indicated vin
         *   1a) Throw exception if vin does NOT map to a Car struct
         *  2) Verify that the indicated renter has rented the Car
         *   2a) Throw exception if the renter has NOT rented the Car
         *  3) Verify that renter indicated a valid cleanliness value
         *   3a) Throw exception if 1 > cleanliness > 10
         *  4) Verify that images contain urls
         *   4a) Throw exception if any images don't start with http[s]:// (necessary ???)
         *  5) Create new Dispute and add to ongoingDisputes mapping
         *  6) Set Car.state = IN_DISPUTE
         * 
         **/
    }
    
    function unlockCar(string vin, address renter, string signedUnlockCode) public (bool) {
        /**
         * This method is called by the Car
         * 
         *  1) Retrieve the Car struct using the indicated vin
         *   1a) Return false if the vin does NOT map to a Car struct
         *  2) Verify that the Car is rented
         *   2a) Throw exception if Car.state != CarState.RENTED
         *  3) Verify that the indicated renter has rented the Car
         *   3a) Return false if the renter has not rented the Car
         *  4) Verify unlockCode was signed with the renters private key
         *  5) return true
         * 
         **/
    }
    
    function returnCar(string vin, uint8 lat, uint8 long,  string[] images) public payable (bool) {
        /**
         * We have a few things to do here:
         * 
         *  1) Retrieve the Car struct using the indicated vin
         *   1a) Throw exception if vin does NOT map to a Car struct
         *  2) Verify that Car is rented
         *   2a) Throw exception if Car's state != CarState.RENTED
         *  3) Verify that Car is rented to message sender
         *   3a) Throw exception if msg.sender != Car.renter
         *  4) Transfer funds from contract to owner
         *   4a) Throw exception if transfer fails
         *  5) return true
         * 
         **/
    }
}
