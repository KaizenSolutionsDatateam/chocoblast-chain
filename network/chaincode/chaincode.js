const shim = require('fabric-shim');
const util = require('util');

class ChocoblastCC {
    Init(stub) {
        console.info('Chaincode instantiation is successful');
        return shim.success();
    }

    Invoke(stub) {
        console.info('Transaction ID: ' + stub.getTxID());
        console.info(util.format('Args: %j', stub.getArgs()));

        let ret = stub.getFunctionAndParameters();
        console.info('Calling function: ' + ret.fcn);

        return shim.success();
    }
}

shim.start(new ChocoblastCC());
