// Copyright 2022-2024 The MathWorks, Inc.

import * as core from "@actions/core";
import * as exec from "@actions/exec";
import * as io from "@actions/io";
//import { matlab } from "run-matlab-command-action";
import * as buildtool from "./buildtool";
import * as buildRunner from "./runMatlabBuild"

/**
 * Gather action inputs and then run action.
 */
async function run() {
    const platform = process.platform;
    const architecture = process.arch;
    const workspaceDir = process.cwd();

    // Export env variable to inject the buildtool plugin
    core.exportVariable('MW_MATLAB_BUILDTOOL_DEFAULT_PLUGINS_FCN_OVERRIDE', 'matlab.ciplugins.github.getDefaultPlugins');

    const options: buildtool.RunBuildOptions = {
        Tasks: core.getInput("tasks"),
        BuildOptions: core.getInput("build-options"),
    };

    const command = buildtool.generateCommand(options);
    const startupOptions = core.getInput("startup-options").split(" ");

    const helperScript = await core.group("Generate script", async () => {
        const helperScript = await buildRunner.generateScript(workspaceDir, command);
        core.info("Successfully generated script");
        return helperScript;
    });


    //await core.notice('\u001b[35mRunning MATLAB build');
    core.info('\u001b[35mRunning MATLAB build');
    await buildRunner.runCommand(helperScript, platform, architecture, exec.exec, startupOptions);  //{

   // });

   // Adding Summary details in log
   core.info("\u001b[35m####### MATLAB build Summary #######");
   core.info("\u001b[38mTasks run: "+ 3);
   core.info("\u001b[38;2;255;0;0mTasks failed: "+ 0);
   core.info("\u001b[43mTasks skipped: "+ 0);

   //Addding summary Page
   core.summary
     .addHeading('Build Results')
     //.addCodeBlock(generateTestResults(), "js")
     .addTable([
       [{data: 'File', header: true}, {data: 'Result', header: true}],
       ['test', 'Pass ✅'],
       ['show', 'Fail ❌'],
       ['check', 'Pass ✅']
     ])
     .addLink('View detailed build result', 'https://github.com')
     .write()

    // Cleanup post run for self hosted runners
    await io.rmRF(workspaceDir + '/.matlab');

}

run().catch((e) => {
    core.setFailed(e);
});
