#!/usr/bin/env cwl-runner

# Note that if you are working on the analysis development locally, i.e. outside
# of the REANA platform, you can proceed as follows:
#
#   # ToDo: check these local commands
#   $ cd reana-demo-cms-h4l
#   $ mkdir cwl-local-run
#   $ cd cwl-local-run
#   $ cwltool --outdir="results" ../workflow/workflow.cwl ../workflow/input.yaml
#   $ firefox ../results/plot.png

cwlVersion: v1.0
class: Workflow

requirements:
  InitialWorkDirRequirement:
    listing:
      - $(inputs.code)
      - $(inputs.input_data)

inputs:
  input_data:
    type: Directory
  code:
    type: Directory

outputs:
  mass4l_combine_userlvl3.pdf:
    type: File
    outputSource:
      step2/mass4l_combine_userlvl3.pdf

steps:
  step1data:
    run: step1data.cwl
    in:
      code: code
      input_data: input_data
    out: [DoubleMuParked2012C_10000_Higgs.root, step1data.log]
  step1mc:
    run: step1mc.cwl
    in:
      code: code
      input_data: input_data
    out: [Higgs4L1file.root, step1mc.log]
  step2:
    run: step2.cwl
    in:
      code: code
      input_data: input_data
      DoubleMuParked2012C_10000_Higgs: step1data/DoubleMuParked2012C_10000_Higgs.root
      Higgs4L1file: step1mc/Higgs4L1file.root
    out: [mass4l_combine_userlvl3.pdf, step2.log]