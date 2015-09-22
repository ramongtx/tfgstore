
// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
Parse.Cloud.define("hello", function(request, response) {
  response.success("Hello world!");
});

Parse.Cloud.define("addLogs", function(request, response) {

  var Log = Parse.Object.extend("Log");

  var events = request.params.events;
  var adid = request.params.id;

  var promises = [];
  for (var i = 0; i < events.length; i++) {
    var newLog = new Log();
    var logObj = events[i];
    newLog.set("adId",adid);
    newLog.set("eventType",logObj.eventType);
    newLog.set("time",new Date(logObj.time*1000));
    if (logObj.details) {
      newLog.set("details",logObj.details);
    }
    if (logObj.appPos) {
      newLog.set("appPos",logObj.appPos);
    }
    if (logObj.appId) {
      newLog.set("appId",logObj.appId);
    }
    promises.push(newLog.save())
  }

  Parse.Promise.when(promises).then(function() {
		response.success("Added logs successfully.");
	}, function(saveError) {
		response.error("Uh oh, something went wrong. "+saveError.code+" : "+saveError.message);
	});
});
