classdef BuildTaskGroupPlugin < matlab.buildtool.plugins.BuildRunnerPlugin
%

%   Copyright 2024 The MathWorks, Inc.

    methods (Access=protected)

        function runTask(plugin, pluginData)
        if pluginData.TaskResults.Name == "error"
           disp("::error::" + pluginData.TaskResults.Name );
        else
           disp("::info::\u001b[35m" + pluginData.TaskResults.Name );
        end
            runTask@matlab.buildtool.plugins.BuildRunnerPlugin(plugin, pluginData);
            if pluginData.TaskResults.Name ~= "error"
               %disp("::endgroup::");
            end
        end
    end
 end