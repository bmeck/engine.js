var executionWatcher = function(threshold, piston_process){
    var self = this;
    self.threshold = threshold;
    self.piston_process = piston_process;
};
executionWatcher.prototype.start = function(){
    var self = this;
    self.timeout = setTimeout(function(){
	self.piston_process.kill();
	self.piston_process.restart();
    },self.threshold);
};
executionWatcher.prototype.clear = function(){
    var self = this;
    clearTimeout(self.timeout);
};
executionWatcher.make = function(config){ 
    return new executionWatcher(config.threshold, 
				config.piston_process);
};

exports.executionWatcher = executionWatcher;