cwlVersion: v1.0
class: CommandLineTool

baseCommand: /bin/zsh

requirements:
  DockerRequirement:
    dockerPull:
      cmsopendata/cmssw_5_3_32
  InitialWorkDirRequirement:
    listing:
      - $(inputs.code)
      - $(inputs.input_data)

inputs:
  input_data:
    type: Directory
  code:
    type: Directory

stdout: step1mc.log

outputs:
  step1mc.log:
    type: stdout
  Higgs4L1file.root:
    type: File
    outputBinding:
       glob: "outputs/Higgs4L1file.root"

arguments:
  - prefix: -c
    valueFrom: |
      source /opt/cms/cmsset_default.sh ;\
      scramv1 project CMSSW CMSSW_5_3_32 ;\
      cd CMSSW_5_3_32/src ;\
      eval `scramv1 runtime -sh` ;\
      cp -r $(inputs.code.path)/HiggsExample20112012 .; \
      scram b; \
      cd $(inputs.code.path)/HiggsExample20112012/Level3; \
      mkdir -p ../../outputs; \
      cmsRun demoanalyzer_cfg_level3MC.py