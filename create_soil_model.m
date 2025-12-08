% This script creates a simple Simulink model for soil classification.
% It's designed to look like it was made by a beginner.
% To use this script, run it from the MATLAB command window.
% It will generate the 'SoilClassificationModel.slx' file in your current directory.

% --- Create a new Simulink model ---
modelName = 'SoilClassificationModel';
if bdIsLoaded(modelName)
    close_system(modelName, 0);
end
new_system(modelName);
open_system(modelName);

% Set a white background color for the model
set_param(modelName, 'ScreenColor', 'white');

% --- 1. INPUTS ---
% A beginner would just use constant blocks and change the values manually.
add_block('simulink/Sources/Constant', [modelName '/PercentPassing200'], 'Value', '60', 'Position', [50, 50, 150, 80]);
add_block('simulink/Sources/Constant', [modelName '/LiquidLimit'], 'Value', '55', 'Position', [50, 110, 150, 140]);
add_block('simulink/Sources/Constant', [modelName '/PlasticLimit'], 'Value', '35', 'Position', [50, 170, 150, 200]);

% --- 2. PI CALCULATION ---
add_block('simulink/Math Operations/Subtract', [modelName '/Calculate_PI'], 'Inputs', '+-', 'Position', [220, 135, 260, 175]);
add_line(modelName, 'LiquidLimit/1', 'Calculate_PI/1');
add_line(modelName, 'PlasticLimit/1', 'Calculate_PI/2');

% --- 3. USCS CLASSIFICATION LOGIC ---
% All blocks are placed directly in the main model. No subsystems.

% USCS Logic Blocks
add_block('simulink/Logic and Bit Operations/Compare To Constant', [modelName '/USCS_P200_gt_50'], 'relop', '>', 'const', '50', 'Position', [220, 48, 260, 82]);
add_block('simulink/Logic and Bit Operations/Compare To Constant', [modelName '/USCS_LL_lt_50'], 'relop', '<', 'const', '50', 'Position', [330, 108, 370, 142]);
add_block('simulink/Logic and Bit Operations/Compare To Constant', [modelName '/USCS_PI_gt_7'], 'relop', '>', 'const', '7', 'Position', [330, 178, 370, 212]);
add_block('simulink/Logic and Bit Operations/Compare To Constant', [modelName '/USCS_LL_gt_50'], 'relop', '>', 'const', '50', 'Position', [330, 248, 370, 282]);
add_block('simulink/Logic and Bit Operations/Logical Operator', [modelName '/USCS_is_CL'], 'Operator', 'AND', 'Position', [420, 131, 460, 179]);
add_block('simulink/Logic and Bit Operations/Logical Operator', [modelName '/USCS_is_CH'], 'Operator', 'AND', 'Position', [420, 221, 460, 269]);

% USCS String Constants
add_block('simulink/String/String Constant', [modelName '/USCS_SW'], 'String', '''SW (Coarse)''', 'Position', [510, 20, 580, 40]);
add_block('simulink/String/String Constant', [modelName '/USCS_CL'], 'String', '''CL''', 'Position', [510, 70, 580, 90]);
add_block('simulink/String/String Constant', [modelName '/USCS_CH'], 'String', '''CH''', 'Position', [510, 120, 580, 140]);
add_block('simulink/String/String Constant', [modelName '/USCS_Fine_Other'], 'String', '''Fine (Other)''', 'Position', [510, 170, 580, 190]);

% USCS Switch blocks to decide classification
add_block('simulink/Signal Routing/Switch', [modelName '/USCS_Switch_CH'], 'Position', [630, 135, 670, 175]);
add_block('simulink/Signal Routing/Switch', [modelName '/USCS_Switch_CL'], 'Position', [630, 85, 670, 125]);
add_block('simulink/Signal Routing/Switch', [modelName '/USCS_Switch_FineGrained'], 'Position', [630, 35, 670, 75]);

% USCS Display
add_block('simulink/Sinks/Display', [modelName '/USCS_Display'], 'Position', [750, 45, 850, 75]);

% Connect USCS Blocks
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


% --- 4. AASHTO CLASSIFICATION LOGIC ---
% All blocks are placed directly in the main model.

% AASHTO Logic Blocks
add_block('simulink/Math Operations/Subtract', [modelName '/AASHTO_LL_minus_30'], 'Inputs', '+-', 'Position', [330, 405, 370, 445]);
add_block('simulink/Sources/Constant', [modelName '/AASHTO_Const30'], 'Value', '30', 'Position', [220, 450, 260, 480]);
add_block('simulink/Logic and Bit Operations/Compare To Constant', [modelName '/AASHTO_P200_gt_35'], 'relop', '>', 'const', '35', 'Position', [330, 348, 370, 382]);
add_block('simulink/Logic and Bit Operations/Relational Operator', [modelName '/AASHTO_PI_gt_LLm30'], 'Operator', '>', 'Position', [420, 431, 460, 479]);
add_block('simulink/Logic and Bit Operations/Logical Operator', [modelName '/AASHTO_is_A76'], 'Operator', 'AND', 'Position', [510, 371, 550, 419]);
add_block('simulink/Logic and Bit Operations/Compare To Constant', [modelName '/AASHTO_P200_lt_35'], 'relop', '<', 'const', '35', 'Position', [330, 518, 370, 552]);
add_block('simulink/Logic and Bit Operations/Compare To Constant', [modelName '/AASHTO_PI_lt_10'], 'relop', '<', 'const', '10', 'Position', [330, 578, 370, 612]);
add_block('simulink/Logic and Bit Operations/Logical Operator', [modelName '/AASHTO_is_A24'], 'Operator', 'AND', 'Position', [420, 541, 460, 589]);

% AASHTO String Constants
add_block('simulink/String/String Constant', [modelName '/AASHTO_A7-6'], 'String', '''A-7-6''', 'Position', [600, 370, 690, 390]);
add_block('simulink/String/String Constant', [modelName '/AASHTO_A2-4'], 'String', '''A-2-4''', 'Position', [600, 420, 690, 440]);
add_block('simulink/String/String Constant', [modelName '/AASHTO_Other'], 'String', '''AASHTO (Other)''', 'Position', [600, 470, 690, 490]);

% AASHTO Switch blocks
add_block('simulink/Signal Routing/Switch', [modelName '/AASHTO_Switch_A24'], 'Position', [740, 435, 780, 475]);
add_block('simulink/Signal Routing/Switch', [modelName '/AASHTO_Switch_A76'], 'Position', [740, 385, 780, 425]);

% AASHTO Display
add_block('simulink/Sinks/Display', [modelName '/AASHTO_Display'], 'Position', [870, 395, 970, 425]);

% Connect AASHTO Blocks
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

% --- 5. SAVE THE MODEL ---
save_system(modelName);
fprintf('Beginner-style Simulink model ''%s.slx'' created successfully.\n', modelName);