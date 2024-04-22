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
             disp("""### Build Summary """ + ">> $GITHUB_STEP_SUMMARY")
             disp("""| Task Name  | Task Status |""" + ">> $GITHUB_STEP_SUMMARY");
             disp("""| ---------- | ----------- |""" + ">> $GITHUB_STEP_SUMMARY");
             disp("""| test       |     PASS    |""" + ">> $GITHUB_STEP_SUMMARY");
        end
    end
 end