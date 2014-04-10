/*
* Put here the requests to the DataSystem.
*/

americano = require('americano');

module.exports = {
    receiptdetail: {
        all: function(doc) {
		emit(doc.timestamp, doc);
	}
    }
};


/*module.exports = {
    metadoctype: {
        all: americano.defaultRequests.all
    }
};*/
