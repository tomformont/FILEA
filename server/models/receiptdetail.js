americano = require('americano');

module.exports = ReceiptDetail = americano.getModel('receiptdetail', {
 'origin': String,
 'order': Number,
 'barcode': String,
 'label': String,
 'family': String,
 'familyLabel': String,
 'section': String,
 'sectionLabel': String,
 'amount': Number,
 'price': Number,
 'type': String,
 'typeLabel': String,
 'ticketId': String,
 'intermarcheShopId': String,
 'timestamp': Date,
 'isOnlineBuy': Boolean,

	'quantityUnit': String,
	'quantityAmount': Number,
	'quantityWeight': String,
	'quantityLabel': String,
	'name': String,
	'computedWeight' : Number, // kg (kilogrammes)
	'computedVolume': Number, // L (Litter).




 });

ReceiptDetail._ean13CheckSum = function(rdet) {
if (rdet.barcode && rdet.barcode.length == 12) {
// last checksum digit is needed
// cf : http://fr.wikipedia.org/wiki/Code-barres_EAN#Cl.C3.A9_de_contr.C3.B4le
var even = 0 ;
var odd = 0 ;
 
for (var i=0; i<6; i++) {
odd += parseInt(rdet.barcode[2 * i]);
even += parseInt(rdet.barcode[2 * i + 1]);
}
var checksum = 10 - ( 3 * even + odd ) % 10 ;
 
rdet.barcode = rdet.barcode + checksum.toString() ;
}
};
 
ReceiptDetail._enrichReceiptDetail = function(rdet) {
// Parse quantity
// Match parterns : 3x20cl ; 8x1l ; 70cl ; 6x50 cl ; 180gx3
// 3x : (\d+)x
// 3x or not : (?:(\d+)x|())
//
// units : (cl|g|l|ml|m)
//
// x3 : (?:x(\d+)|())
// g1 : mult
// g2 : quantity
// g3 : unit
// g4 : mult
 
reg = /(?:(\d+)x|)(\d+)(cl|g|l|ml|m|kg)(?:x(\d+)|)/i ;
unitMap = {
"CL": "cL",
"ML": "mL",
"M": "mL",
"L": "L",
"G": "g",
"KG": "kg",
}
grs = reg.exec(rdet.label);
if (grs) {
rdet.quantityUnit = (grs[3] in unitMap) ? unitMap[grs[3]] : grs[3] ;
rdet.quantityAmount = parseInt(grs[1]?grs[1]:grs[4]);
rdet.quantityWeight = parseInt(grs[2]);
rdet.quantityLabel = grs[0];
 
if (rdet.quantityAmount) {
rdet.quantityTotalWeight = rdet.quantityWeight * rdet.quantityAmount;
 
rdet.quantityLabel = rdet.quantityAmount + "x" + rdet.quantityWeight + rdet.quantityUnit;
} else {
rdet.quantityTotalWeight = rdet.quantityWeight;
 
rdet.quantityLabel = rdet.quantityWeight + rdet.quantityUnit;
}
if (rdet.quantityUnit == 'cL') {
rdet.computedWeight = rdet.quantityTotalWeight * 0.01 ;
rdet.computedVolume = rdet.quantityTotalWeight * 0.01 ;
} else if (rdet.quantityUnit == 'mL'
|| rdet.quantityUnit == 'g' ) {
rdet.computedWeight = rdet.quantityTotalWeight * 0.001 ;
rdet.computedVolume = rdet.quantityTotalWeight * 0.001 ;
} else if (rdet.quantityUnit == 'L'
|| rdet.quantityUnit == 'kg' ) {
rdet.computedWeight = rdet.quantityTotalWeight ;
rdet.computedVolume = rdet.quantityTotalWeight ;
}
// remove from label
//rdet.name = rdet.label.substring(grs['index'], grs[0].length);
rdet.name = rdet.label.substring(0, grs['index']);
 
 
} else if (rdet.label == "NR" || rdet.label == "NA" || !rdet.label ) {
rdet.name = rdet.familyLabel;
} else {
rdet.name = rdet.label;
}
// Vegetables !!
if (rdet.section == '34') {
rdet.computedWeight = rdet.price / 3.0 ; // prix moyen 3.0 E/kg.
rdet.computedVolume = rdet.computedWeight ; // Water density.
 
}
 
// Clean name look.
// to lower.
// points -> spaces.
if (rdet.name) {
rdet.name = rdet.name.toLowerCase().replace('.', ' ');
}
//console.log(rdet.label);
//console.log(rdet.name);
//console.log(rdet.quantityLabel);
//console.log('/n');
 
return rdet;
};
 
 
// Automatically called by jugglingdb on requested data.
ReceiptDetail.afterInitialize = function() {
ReceiptDetail._enrichReceiptDetail(this);
ReceiptDetail._ean13CheckSum(this);
 
};



ReceiptDetail.all = function(callback) {
    ReceiptDetail.request(
        "all", 
        {},
        function(err, instances) {
            callback(null, instances);
        }
    );
};

