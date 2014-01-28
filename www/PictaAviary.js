function PictaAviary {}

PictaAviary.prototype.launchEditor = function (imageData, successCallback, errorCallback) {
	cordova.exec(successCallback, errorCallback, 'PictaAviary', 'launchEditor', [imageData]);
};
