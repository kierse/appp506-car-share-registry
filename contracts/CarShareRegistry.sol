contract CarShareRegistry {
    enum CarState {
        AVAILABLE, UNAVAILABLE, RENTED, IN_DISPUTE, IS_DAMAGED
    }
    
    struct Car {
        string vin;
        address owner;
        address renter;
        uint8 costPerHour;
        uint8 lat;
        uint8 long;
        CarState state;
    }
    
    struct CarFeedback {
        uint256 timestamp;
        string vin;
        address renter;
        uint8 cleanliness; // 1- 10, 1 = terrible, 10 = excellent
        string[] images;   // list of urls pointing to images documenting any/all 
                           // problems with car
    }
    
    struct InProgressTransaction {
        string vin;
        uint8 costPerHour;
        uint8 rentalLengthInHours;
        uint8 totalCost;
    }
    
    struct CompletedTransaction {
        string vin;
        address: renter;
        uint8 totalCost;
    }
    
    // vin => Car
    mapping(string => Car) private cars;
    
    // vin => rental_total
    mapping(string => InProgessTransaction) private pendingTransactions;

    // open CarFeedback reports
    // vin => CarFeedback[]
    mapping(string => CarFeedback[]) openFeedback;

    // register new car
    function registerCar(string vin, uint8 costPerHour, CarState state) public {
        // Use msg.sender and given arguments to create a new Car struct.
        // Add new car to cars mapping
    }
    
    function bookCar(string vin, uint8 rentalLengthInHours) public payable (string) {
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
         *  7) Create new Transaction instance and add to pendingTransactions
         *  8) return vin, lat, long
         * 
         **/
    }
    
    function providePreTripFeedback(
        string vin, uint8 cleanliness, string[] images, bool disputeRental
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
         *  5) Set Car.state = IN_DISPUTE if disputeRental is true
         * 
         **/
    }
    
    function unlockCar(string vin, address renter) public (bool) {
        /**
         * This method is called by the Car
         * 
         *  1) Retrieve the Car struct using the indicated vin
         *   1a) Return false if the vin does NOT map to a Car struct
         *  2) Verify that the indicated renter has rented the Car
         *   2a) Return false if the renter has not rented the Car
         *  3) return true
         * 
         **/
    }
    
    function returnCar(string vin, uint8 lat, uint8 long,  string[] images) public (bool) {
        // app get gas level and gps from car (bluetooth)
        // app checks current gps vs expected and shows error or makes call to end trip
        // 
        // transfer money from contract to owner
        // update Car struct
        /**
         * We have a few things to do here:
         * 
         *  1) Retrieve the Car struct using the indicated vin
         *   1a) Throw exception if vin does NOT map to a Car struct
         *  2) Verify that Car is rented
         *   2a) Throw exception if Car's state != CarState.RENTED
         *  3) Verify that Car is rented to message sender
         *   3a) Throw exception if msg.sender != Car.renter
         *  x) Transfer funds from contract to owner
         *   xa) Throw exception if transfer fails
         * 
         **/
    }
    
    /**
     * Details irrelevant for chosen use cases
    
     * contract owner
    address owner;
    
     * constructor
    function CarShareRegistry() { owner = msg.sender; }
    
    function cancelRental(string vin) { ... }
    **/
}
