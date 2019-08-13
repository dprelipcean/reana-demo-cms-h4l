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
  DoubleMuParked2012C_10000_Higgs:
    type: File
  Higgs4L1file:
    type: File

stdout: step2.log

outputs:
  step2.log:
    type: stdout
  mass4l_combine_userlvl3.pdf:
    type: File
    outputBinding:
      glob: "outputs/mass4l_combine_userlvl3.pdf"

arguments:
  - prefix: -c
    valueFrom: |
      source /opt/cms/cmsset_default.sh ;\
      scramv1 project CMSSW CMSSW_5_3_32 ;\
      cd CMSSW_5_3_32/src ;\
      eval `scramv1 runtime -sh` ;\
      cp -r $(inputs.code.path)/HiggsExample20112012 .; \
      cd $(inputs.code.path)/HiggsExample20112012/Level3; \
      mkdir -p ../../outputs; \
      cp $(inputs.DoubleMuParked2012C_10000_Higgs.path) ../../outputs; \
      cp $(inputs.Higgs4L1file.path) ../../outputs; \
      root -b -l -q ./M4Lnormdatall_lvl3.cc