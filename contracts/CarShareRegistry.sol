contract CarShareRegistry {
    enum CarState {
        AVAILABLE, UNAVAILABLE, RENTED, IN_DISPUTE
    }
    
    struct Car {
        string vin;
        address owner;
        address renter;
        uint8 costPerHour;
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
    
    // vin => Car
    mapping(string => Car) private cars;
    
    // vin => rental_total
    mapping(string => uint8) private pendingTransactions;

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
         *  7) Add new entry to pendingTransactions mapping using vin and totalCost
         *  8) return vin 
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
    
    function returnCar(string vin) public { /* TODO */ }
    
    /**
     * Details irrelevant for chosen use cases
    
     * contract owner
    address owner;
    
     * constructor
    function CarShareRegistry() { owner = msg.sender; }
    
    function cancelRental(string vin) { ... }
    **/
}
