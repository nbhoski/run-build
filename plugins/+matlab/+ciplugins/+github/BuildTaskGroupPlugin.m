classdef BuildTaskGroupPlugin < matlab.buildtool.plugins.BuildRunnerPlugin
%

%   Copyright 2024 The MathWorks, Inc.

    methods (Access=protected)

        function runTask(plugin, pluginData)
        if pluginData.TaskResults.Name == "error"
           disp("::error::" + "Run MATLAB Build-" + pluginData.TaskResults.Name);
        else
           disp("::group::" + "Run MATLAB Build-" + pluginData.TaskResults.Name);
        end
            runTask@matlab.buildtool.plugins.BuildRunnerPlugin(plugin, pluginData);
            if pluginData.TaskResults.Name ~= "error"
               disp("::endgroup::");
            end
        end
        % Teardown method
        function teardownBuildFixture(plugin, pluginData)
             teardownBuildFixture@matlab.buildtool.plugins.BuildRunnerPlugin(plugin, pluginData);
        end
    end
 end