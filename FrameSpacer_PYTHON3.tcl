set cut_paste_input [stack 0]
version 15.0 v1
push $cut_paste_input
Group {
 name FrameSpacer_PM4
 selected true
 xpos -27
 ypos 4
 addUserKnob {20 User l FrameSpacer_PM}
 addUserKnob {26 ""}
 addUserKnob {41 spacer l RUN T FrameSpacer.spacer}
 addUserKnob {26 ""}
 addUserKnob {26 test2 l "" +STARTLINE T "by Peter Mercell 2023"}
}
 Input {
  inputs 0
  name Input1
  xpos 110
  ypos -180
 }
 Group {
  name FrameSpacer
  selected true
  xpos 110
  ypos -122
  addUserKnob {20 User l FrameSpacer}
  addUserKnob {3 space_one l "Space frames"}
  space_one 2
  addUserKnob {26 ""}
  addUserKnob {22 spacer l RUN T "# CODE BY PETER MERCELL 2023 \n\nimport nuke\n\nthis = nuke.thisNode()\n\n# Ensure the script is running within the context of the FrameSpacer group\ngroup_name = 'FrameSpacer'\ncurrent_group = nuke.thisGroup()\nif current_group is None or current_group\['name'].value() != group_name:\n    nuke.message(\"Please run this script from within the '\{\}' group.\".format(group_name))\n\n# Reference Switch_Spacer and TimeOffset_Spacer nodes within the group\nswitch_node = nuke.toNode('\{\}.Switch_Spacer'.format(group_name))\ntime_offset_node = nuke.toNode('\{\}.TimeOffset_Spacer'.format(group_name))\nframe_range_node = nuke.toNode('\{\}.FrameRange_Spacer'.format(group_name))\n\nif switch_node is None or time_offset_node is None:\n    nuke.message(\"Nodes not found in the group.\")\n\n# Clear and set keyframes for the Switch_Spacer node\nframe_range_node\['first_frame'].clearAnimated()\nframe_range_node\['last_frame'].clearAnimated()\nswitch_node\['which'].clearAnimated()\nswitch_node\['which'].setValue(0)\n\n# Clear and set keyframes for the TimeOffset_Spacer node\ntime_offset_node\['time_offset'].clearAnimated()\ntime_offset_node\['time_offset'].setValue(0)\n\n# Get the frame range directly from user input\nstart_frame = int(this.input(0).firstFrame())\nend_frame = int(this.input(0).lastFrame())\n\nif start_frame >= end_frame:\n    nuke.message(\"Please enter a valid frame range.\")\n\n# Ask the user for the number of frames to add as space\nspace_frames = int(nuke.getInput(\"Enter the number of frames to add as space:\", \"5\"))\n\nif space_frames <= 0:\n    nuke.message(\"Please enter a positive number of frames.\")\nelse:\n    # Create a list to store frames with keyframes value of 0\n    zero_keyframes = \[]\n\n    # Set keyframes for the Switch node's 'which' knob\n    for idx, frame in enumerate(range(start_frame, end_frame + 1)):\n        switch_node\['which'].setAnimated()\n\n        # If it's the first frame, set keyframe with a value of 0\n        if idx == 0:\n            switch_node\['which'].setValueAt(0, frame)\n            # Add the frame to the zero_keyframes list\n            zero_keyframes.append(frame)\n        else:\n            # Set keyframes with a value of 0 for frames determined by the formula\n            switch_node\['which'].setValueAt(0, frame + (idx) * space_frames)\n            # Add the frame to the zero_keyframes list\n            zero_keyframes.append(frame + (idx) * space_frames)\n\n    # Set keyframes with a value of 1 before and after each zero keyframe\n    for frame in zero_keyframes:\n        switch_node\['which'].setValueAt(1, frame - 1)\n        switch_node\['which'].setValueAt(1, frame + 1)\n\n    # Add one more frame to the zero_keyframes list (last_frame + space_frames)\n    zero_keyframes.append(zero_keyframes\[-1] + space_frames)\n\n    # Create a new list without the first value from zero_keyframes\n    modified_zero_keyframes = zero_keyframes\[1:]\n\n    # Set 'time_offset' knob as animated\n    time_offset_node\['time_offset'].setAnimated()\n    time_offset_node\['time_offset'].setValue(0)\n\n    # Assign values to 'time_offset' knob using the modified_zero_keyframes list\n    for idx, frame in enumerate(modified_zero_keyframes, start=1):\n        time_offset_node\['time_offset'].setValueAt(space_frames * idx, frame)\n\n    # Set 'first_frame' and 'last_frame' knobs on FrameRange_Spacer node\n    frame_range_node\['first_frame'].setValue(start_frame)\n    frame_range_node\['last_frame'].setValue(zero_keyframes\[-1])\n\n    nuke.message(\"Script executed successfully.\")\n" +STARTLINE}
  addUserKnob {26 ""}
  addUserKnob {26 text l "" -STARTLINE T "by Peter Mercell 2023"}
 }
  Constant {
   inputs 0
   channels rgb
   name Constant_Spacer
   xpos -3
   ypos -209
  }
  Reformat {
   type "to box"
   box_width {{NoOp1.resolution.x}}
   box_height {{NoOp1.resolution.y}}
   box_fixed true
   filter impulse
   black_outside true
   pbb true
   name Reformat1
   xpos -3
   ypos -120
  }
  Input {
   inputs 0
   name Input1
   xpos 124
   ypos -187
  }
  BlackOutside {
   name BlackOutside1
   xpos 124
   ypos -157
  }
  NoOp {
   name NoOp1
   xpos 124
   ypos -121
   addUserKnob {20 User}
   addUserKnob {12 resolution}
   resolution {{input.width} {input.height}}
  }
  TimeOffset {
   time_offset {{curve x1007 5 x1013 10 15 20 x1030 0 x1031 25 x1037 30 35 40 45 50 55 60 65 70 75 80 85 90 95 100 105 110 115 120 125 130 135 140 145 150 155 160 165 170 175 180 185 190 195 200 205 210 215 220 225 230 235 240 245 x1300 250}}
   time ""
   name TimeOffset_Spacer
   xpos 124
   ypos -78
  }
  Switch {
   inputs 2
   which {{curve x1000 1 0 1 x1006 1 x1007 0 1 x1012 1 x1013 0 1 x1018 1 x1019 0 1 x1024 1 x1025 0 1 x1030 1 x1031 0 1 x1036 1 x1037 0 1 x1042 1 x1043 0 1 x1048 1 x1049 0 1 x1054 1 x1055 0 1 x1060 1 x1061 0 1 x1066 1 x1067 0 1 x1072 1 x1073 0 1 x1078 1 x1079 0 1 x1084 1 x1085 0 1 x1090 1 x1091 0 1 x1096 1 x1097 0 1 x1102 1 x1103 0 1 x1108 1 x1109 0 1 x1114 1 x1115 0 1 x1120 1 x1121 0 1 x1126 1 x1127 0 1 x1132 1 x1133 0 1 x1138 1 x1139 0 1 x1144 1 x1145 0 1 x1150 1 x1151 0 1 x1156 1 x1157 0 1 x1162 1 x1163 0 1 x1168 1 x1169 0 1 x1174 1 x1175 0 1 x1180 1 x1181 0 1 x1186 1 x1187 0 1 x1192 1 x1193 0 1 x1198 1 x1199 0 1 x1204 1 x1205 0 1 x1210 1 x1211 0 1 x1216 1 x1217 0 1 x1222 1 x1223 0 1 x1228 1 x1229 0 1 x1234 1 x1235 0 1 x1240 1 x1241 0 1 x1246 1 x1247 0 1 x1252 1 x1253 0 1 x1258 1 x1259 0 1 x1264 1 x1265 0 1 x1270 1 x1271 0 1 x1276 1 x1277 0 1 x1282 1 x1283 0 1 x1288 1 x1289 0 1 x1294 1 x1295 0 1}}
   name Switch_Spacer
   xpos -3
   ypos -78
  }
  Crop {
   box {0 0 {NoOp1.resolution.x} {NoOp1.resolution.y}}
   reformat true
   crop false
   name Crop1
   xpos -4
   ypos -45
  }
  FrameRange {
   first_frame 1001
   last_frame 1300
   time ""
   name FrameRange_Spacer
   label "\[value first_frame]  \[value last_frame]"
   xpos -4
   ypos -4
  }
  TimeClip {
   time ""
   first {{parent.FrameRange_Spacer.knob.first_frame}}
   last {{parent.FrameRange_Spacer.knob.last_frame}}
   origfirst {{parent.FrameRange_Spacer.knob.first_frame}}
   origlast {{parent.FrameRange_Spacer.knob.last_frame}}
   origset true
   mask_metadata true
   name TimeClip1
   xpos -4
   ypos 46
  }
  Output {
   name Output1
   xpos -4
   ypos 99
  }
 end_group
 Output {
  name Output1
  xpos 110
  ypos -40
 }
end_group
