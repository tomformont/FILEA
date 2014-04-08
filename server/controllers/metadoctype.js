americano = require('americano');

module.exports = Client = americano.getModel('client', {
    'origin': String,
    'loyaltyCardStatus': String,
    'intermarcheShopId': String,
    'entryDate': Date,
    'wayOutDate': Date,
    'connected': Boolean,
    'optIn': Boolean,
    'optInEmail': Boolean,
    'optInPhone': Boolean,
    'lastUpdate': Date,
    'agentCivilities': String,
    'agentLastname': String,
    'agentFirstName': String
});
