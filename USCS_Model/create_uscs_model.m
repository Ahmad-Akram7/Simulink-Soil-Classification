% This script creates a simple Simulink model for USCS soil classification.
% 
% To use this script, run it from the MATLAB command window.
% It will generate the 'USCS_Soil_Model.slx' file.

% --- Create a new Simulink model ---
modelName = 'USCS_Soil_Model';
if bdIsLoaded(modelName)
    close_system(modelName, 0);
end
new_system(modelName);
open_system(modelName);

% Set a white background color for the model
set_param(modelName, 'ScreenColor', 'white');

% --- 1. INPUTS ---
% Use constant blocks for inputs so they are easy to change.
add_block('simulink/Sources/Constant', [modelName '/PercentPassing200'], 'Value', '60', 'Position', [50, 50, 150, 80]);
add_block('simulink/Sources/Constant', [modelName '/LiquidLimit'], 'Value', '55', 'Position', [50, 110, 150, 140]);
add_block('simulink/Sources/Constant', [modelName '/PlasticLimit'], 'Value', '35', 'Position', [50, 170, 150, 200]);

% --- 2. PI CALCULATION ---
add_block('simulink/Math Operations/Subtract', [modelName '/Calculate_PI'], 'Inputs', '+-', 'Position', [220, 135, 260, 175]);
add_line(modelName, 'LiquidLimit/1', 'Calculate_PI/1');
add_line(modelName, 'PlasticLimit/1', 'Calculate_PI/2');

% --- 3. USCS CLASSIFICATION LOGIC ---
% Logic Blocks
add_block('simulink/Logic and Bit Operations/Compare To Constant', [modelName '/USCS_P200_gt_50'], 'relop', '>', 'const', '50', 'Position', [220, 48, 260, 82]);
add_block('simulink/Logic and Bit Operations/Compare To Constant', [modelName '/USCS_LL_lt_50'], 'relop', '<', 'const', '50', 'Position', [330, 108, 370, 142]);
add_block('simulink/Logic and Bit Operations/Compare To Constant', [modelName '/USCS_PI_gt_7'], 'relop', '>', 'const', '7', 'Position', [330, 178, 370, 212]);
add_block('simulink/Logic and Bit Operations/Compare To Constant', [modelName '/USCS_LL_gt_50'], 'relop', '>', 'const', '50', 'Position', [330, 248, 370, 282]);
add_block('simulink/Logic and Bit Operations/Logical Operator', [modelName '/USCS_is_CL'], 'Operator', 'AND', 'Position', [420, 131, 460, 179]);
add_block('simulink/Logic and Bit Operations/Logical Operator', [modelName '/USCS_is_CH'], 'Operator', 'AND', 'Position', [420, 221, 460, 269]);

% String Constants
add_block('simulink/String/String Constant', [modelName '/USCS_SW'], 'String', '''SW (Coarse)''', 'Position', [510, 20, 580, 40]);
add_block('simulink/String/String Constant', [modelName '/USCS_CL'], 'String', '''CL''', 'Position', [510, 70, 580, 90]);
add_block('simulink/String/String Constant', [modelName '/USCS_CH'], 'String', '''CH''', 'Position', [510, 120, 580, 140]);
add_block('simulink/String/String Constant', [modelName '/USCS_Fine_Other'], 'String', '''Fine (Other)''', 'Position', [510, 170, 580, 190]);

% Switch blocks to decide classification
add_block('simulink/Signal Routing/Switch', [modelName '/USCS_Switch_CH'], 'Position', [630, 135, 670, 175]);
add_block('simulink/Signal Routing/Switch', [modelName '/USCS_Switch_CL'], 'Position', [630, 85, 670, 125]);
add_block('simulink/Signal Routing/Switch', [modelName '/USCS_Switch_FineGrained'], 'Position', [630, 35, 670, 75]);

% Display
add_block('simulink/Sinks/Display', [modelName '/USCS_Display'], 'Position', [750, 45, 850, 75]);

% Connect all the blocks
add_line(modelName, 'PercentPassing200/1', 'USCS_P200_gt_50/1');
add_line(modelName, 'LiquidLimit/1', 'USCS_LL_lt_50/1');
add_line(modelName, 'LiquidLimit/1', 'USCS_LL_gt_50/1');
add_line(modelName, 'Calculate_PI/1', 'USCS_PI_gt_7/1');
add_line(modelName, 'USCS_LL_lt_50/1', 'USCS_is_CL/1');
add_line(modelName, 'USCS_PI_gt_7/1', 'USCS_is_CL/2');
add_line(modelName, 'USCS_LL_gt_50/1', 'USCS_is_CH/1');
add_line(modelName, 'USCS_PI_gt_7/1', 'USCS_is_CH/2');
add_line(modelName, 'USCS_Fine_Other/1', 'USCS_Switch_CH/3');
add_line(modelName, 'USCS_CH/1', 'USCS_Switch_CH/1');
add_line(modelName, 'USCS_is_CH/1', 'USCS_Switch_CH/2');
add_line(modelName, 'USCS_Switch_CH/1', 'USCS_Switch_CL/3');
add_line(modelName, 'USCS_CL/1', 'USCS_Switch_CL/1');
add_line(modelName, 'USCS_is_CL/1', 'USCS_Switch_CL/2');
add_line(modelName, 'USCS_Switch_CL/1', 'USCS_Switch_FineGrained/1');
add_line(modelName, 'USCS_SW/1', 'USCS_Switch_FineGrained/3');
add_line(modelName, 'USCS_P200_gt_50/1', 'USCS_Switch_FineGrained/2');
add_line(modelName, 'USCS_Switch_FineGrained/1', 'USCS_Display/1');

% --- 4. SAVE THE MODEL ---
save_system(modelName);
fprintf('USCS Simulink model ''%s.slx'' created in the ''USCS_Model'' folder.\n', modelName);
