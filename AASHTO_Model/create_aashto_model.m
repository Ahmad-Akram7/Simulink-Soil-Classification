% This script creates a simple Simulink model for AASHTO soil classification.
% 
% To use this script, run it from the MATLAB command window.
% It will generate the 'AASHTO_Soil_Model.slx' file.

% --- Create a new Simulink model ---
modelName = 'AASHTO_Soil_Model';
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

% --- 3. AASHTO CLASSIFICATION LOGIC ---
% Logic Blocks
add_block('simulink/Math Operations/Subtract', [modelName '/AASHTO_LL_minus_30'], 'Inputs', '+-', 'Position', [330, 265, 370, 305]);
add_block('simulink/Sources/Constant', [modelName '/AASHTO_Const30'], 'Value', '30', 'Position', [220, 310, 260, 340]);
add_block('simulink/Logic and Bit Operations/Compare To Constant', [modelName '/AASHTO_P200_gt_35'], 'relop', '>', 'const', '35', 'Position', [330, 48, 370, 82]);
add_block('simulink/Logic and Bit Operations/Relational Operator', [modelName '/AASHTO_PI_gt_LLm30'], 'Operator', '>', 'Position', [420, 291, 460, 339]);
add_block('simulink/Logic and Bit Operations/Logical Operator', [modelName '/AASHTO_is_A76'], 'Operator', 'AND', 'Position', [510, 191, 550, 239]);
add_block('simulink/Logic and Bit Operations/Compare To Constant', [modelName '/AASHTO_P200_lt_35'], 'relop', '<', 'const', '35', 'Position', [330, 378, 370, 412]);
add_block('simulink/Logic and Bit Operations/Compare To Constant', [modelName '/AASHTO_PI_lt_10'], 'relop', '<', 'const', '10', 'Position', [330, 438, 370, 472]);
add_block('simulink/Logic and Bit Operations/Logical Operator', [modelName '/AASHTO_is_A24'], 'Operator', 'AND', 'Position', [420, 401, 460, 449]);

% String Constants
add_block('simulink/String/String Constant', [modelName '/AASHTO_A7-6'], 'String', '''A-7-6''', 'Position', [600, 190, 690, 210]);
add_block('simulink/String/String Constant', [modelName '/AASHTO_A2-4'], 'String', '''A-2-4''', 'Position', [600, 240, 690, 260]);
add_block('simulink/String/String Constant', [modelName '/AASHTO_Other'], 'String', '''AASHTO (Other)''', 'Position', [600, 290, 690, 310]);

% Switch blocks
add_block('simulink/Signal Routing/Switch', [modelName '/AASHTO_Switch_A24'], 'Position', [740, 255, 780, 295]);
add_block('simulink/Signal Routing/Switch', [modelName '/AASHTO_Switch_A76'], 'Position', [740, 205, 780, 245]);

% Display
add_block('simulink/Sinks/Display', [modelName '/AASHTO_Display'], 'Position', [870, 215, 970, 245]);

% Connect all the blocks
add_line(modelName, 'PercentPassing200/1', 'AASHTO_P200_gt_35/1');
add_line(modelName, 'PercentPassing200/1', 'AASHTO_P200_lt_35/1');
add_line(modelName, 'LiquidLimit/1', 'AASHTO_LL_minus_30/1');
add_line(modelName, 'AASHTO_Const30/1', 'AASHTO_LL_minus_30/2');
add_line(modelName, 'Calculate_PI/1', 'AASHTO_PI_gt_LLm30/1');
add_line(modelName, 'AASHTO_LL_minus_30/1', 'AASHTO_PI_gt_LLm30/2');
add_line(modelName, 'Calculate_PI/1', 'AASHTO_PI_lt_10/1');
add_line(modelName, 'AASHTO_P200_gt_35/1', 'AASHTO_is_A76/1');
add_line(modelName, 'AASHTO_PI_gt_LLm30/1', 'AASHTO_is_A76/2');
add_line(modelName, 'AASHTO_P200_lt_35/1', 'AASHTO_is_A24/1');
add_line(modelName, 'AASHTO_PI_lt_10/1', 'AASHTO_is_A24/2');
add_line(modelName, 'AASHTO_Other/1', 'AASHTO_Switch_A24/3');
add_line(modelName, 'AASHTO_A2-4/1', 'AASHTO_Switch_A24/1');
add_line(modelName, 'AASHTO_is_A24/1', 'AASHTO_Switch_A24/2');
add_line(modelName, 'AASHTO_Switch_A24/1', 'AASHTO_Switch_A76/3');
add_line(modelName, 'AASHTO_A7-6/1', 'AASHTO_Switch_A76/1');
add_line(modelName, 'AASHTO_is_A76/1', 'AASHTO_Switch_A76/2');
add_line(modelName, 'AASHTO_Switch_A76/1', 'AASHTO_Display/1');

% --- 4. SAVE THE MODEL ---
save_system(modelName);
fprintf('AASHTO Simulink model ''%s.slx'' created in the ''AASHTO_Model'' folder.\n', modelName);
