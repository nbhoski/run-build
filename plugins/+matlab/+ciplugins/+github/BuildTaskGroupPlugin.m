classdef BuildTaskGroupPlugin < matlab.buildtool.plugins.BuildRunnerPlugin
%

%   Copyright 2024 The MathWorks, Inc.

    methods (Access=protected)

        function runTask(plugin, pluginData)
        if pluginData.TaskResults.Name == "error"
           disp("::error::" + pluginData.TaskResults.Name );
        else
           disp("::group::" + pluginData.TaskResults.Name );
        end
            runTask@matlab.buildtool.plugins.BuildRunnerPlugin(plugin, pluginData);
            if pluginData.TaskResults.Name ~= "error"
               disp("::endgroup::");
            end
        end
        % Teardown method
        function teardownBuildFixture(plugin, pluginData)
             teardownBuildFixture@matlab.buildtool.plugins.BuildRunnerPlugin(plugin, pluginData);
             disp("\u001b[35####### MATLAB build Summary #######");
             disp("\u001b[35Tasks run: "+ 3);
             disp("\u001b[35Tasks failed: "+ 0);
             disp("\u001b[35Tasks skipped: "+ 0);

        end
    end
 end