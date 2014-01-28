/*
*
* TODO license
*/

var exec = require('cordova/exec');

var pictaAviary = {
	launchEditor: function (imageData, successCallback, errorCallback) {
		exec(successCallback, errorCallback, 'PictaAviary', 'launchEditor', [imageData]);
	}
}

module.exports = pictaAviary;
