pragma solidity ^ 0.4.24;

contract AuditFactory {
    address[] public Audits;
    address private operator;


    // TODO: Create Audit Function
    function newAudit(
        string companyName,
        string standard
    )
    public
    payable
    returns (address newAuditAddr)
    {
        newAuditAddr = (new Audit).value(msg.value)(_companyName, _standard, address(this), msg.sender);
        Audits.push(newAuditAddr);
        return newAuditAddr;
    }

    // TODO: Assign Auditor Function (AuditFactory) (randomized, also need to determine how to evaluate auditor)
    // TODO: Make onlyOperator modifier for Assign Auditor Function

}

contract Audit {

    string public companyName;
    string public standard;

    address private auditor;
    address private factoryContract;
    address private company;
    bool public approved;
    bool public completed;
    bool public passed;

    // Audit constructor function
    function Audit(
        string _companyName,
        string _standard,
        address _factoryContract,
        address _company
    )
    public
    payable
    {
        companyName = _companyName;
        standard = _standard;
        factoryContract = _factoryContract;
        company = _company;

        // assign to address that no one has access to.
        auditor = 0x0;

        // results of the audit are false until the audit is completed
        completed = false;
        passed = false;
    }

    modifier onlyCompany() {
        require (msg.sender == company);
        _;
    }

    modifier onlyFactoryContract() {
        require(msg.sender == factoryContract);
    }

    // Fund Audit Function
    function FundAudit() public payable onlyCompany() {

    }

    // Approve Audit Function
    // this needs to be called by the contract operator, ie Factory contract
    // this is due to assigning auditor from auditor pool in the factory contract
    function ApproveAudit(address _auditor) public FactoryContract() {
        auditor = _auditor;
        approved = true;
    }

    // TODO: Auditor Submits Completed Audit Function (full report and result hidden from company until approval)
    

    // TODO: Company Approves Function

    // TODO: Payment and Report is released

}