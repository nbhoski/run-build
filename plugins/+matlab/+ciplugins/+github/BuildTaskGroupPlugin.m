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
             arguments
                 plugin (1,1) matlab.buildtool.plugins.BuildRunnerPlugin
                 pluginData (1,1) matlab.buildtool.plugins.plugindata.BuildFixturePluginData
             end
             disp("### Build Summary >>")
             disp("| Task Name  | Task Status | >>");
             disp("| ---------- | ----------- | >>");
             disp("| test       |     PASS    | >>");
             nextOperator = plugin.getNextOperator();
             nextOperator.teardownBuildFixture(pluginData);
        end
    end
 end