%% Import data from text file
% Script for importing data from the following text file:
%
%    filename: C:\Users\cecil_000\Documents\GitHub\ThermalModel\Experiment\Telemetry_EPS_17072020.csv
%
% Auto-generated by MATLAB on 21-Jul-2020 14:28:45

%% Setup the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 90);

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["Bus_3_INA_Status", "panelOut_Xp_current", "B4_status", "panelOut_Ym_voltage", "B3_voltage", "Battery_INA_current", "Size", "B1_voltage", "MPPT_Xm_voltage", "Unregulated_INA_Status", "MPPT_Ym_INA_Status", "MPPT_Ym_current", "cellOut_Ym_INA_Status", "MPPT_Yp_voltage", "Unregulated_INA_voltage", "cellOut_Xm_INA_Status", "B3_state", "timestamp_", "cellOut_Yp_temperature", "MCUTemp", "cellOut_Yp_voltage", "cellOut_Xm_voltage", "Unregulated_INA_current", "cellOut_Ym_temperature", "panelOut_Ym_current", "cellOut_Ym_current", "MPPT_Xm_current", "Battery_INA_voltage", "B3_current", "cellOut_Xm_TMP_Status", "cellOut_Ym_TMP_Status", "B1_current", "panelOut_Xm_INA_Status", "MPPT_Yp_INA_Status", "Internal_INA_current", "cellOut_Xm_current", "panelOut_Ym_INA_Status", "MPPT_Xp_INA_Status", "B2_status", "B4_state", "panelOut_Xm_current", "Battery_INA_Status", "cellOut_Ym_voltage", "Destination", "cellOut_Xp_current", "B2_voltage", "Battery_GG_temp", "B4_voltage", "B1_state", "Battery_GG_Status", "Internal_INA_Status", "Source", "Internal_INA_voltage", "MPPT_Yp_current", "panelOut_Xm_voltage", "Battery_GG_voltage", "MPPT_Xp_voltage", "BootCounter", "cellOut_Xm_temperature", "panelOut_Yp_voltage", "Bus_1_INA_Status", "cellOut_Xp_voltage", "panelOut_Xp_voltage", "B2_current", "cellOut_Xp_TMP_Status", "Uptime", "raw_", "Request", "panelOut_Xp_INA_Status", "Service", "cellOut_Yp_current", "SoftwareBootCounter", "received_", "cellOut_Xp_temperature", "Bus_4_INA_Status", "B2_state", "Bus_2_INA_Status", "cellOut_Xp_INA_Status", "cellOut_Yp_INA_Status", "panelOut_Yp_current", "MPPT_Xm_INA_Status", "MPPT_Xp_current", "panelOut_Yp_INA_Status", "Battery_TMP20_temp", "B4_current", "Battery_GG_capacity", "B3_status", "B1_status", "MPPT_Ym_voltage", "cellOut_Yp_TMP_Status"];
opts.VariableTypes = ["categorical", "double", "categorical", "double", "double", "double", "double", "double", "double", "categorical", "categorical", "double", "categorical", "double", "double", "categorical", "categorical", "datetime", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "categorical", "categorical", "double", "categorical", "categorical", "double", "double", "categorical", "categorical", "categorical", "categorical", "double", "categorical", "double", "categorical", "double", "double", "double", "double", "categorical", "categorical", "categorical", "categorical", "double", "double", "double", "double", "double", "double", "double", "double", "categorical", "double", "double", "double", "categorical", "double", "string", "categorical", "categorical", "categorical", "double", "double", "categorical", "double", "categorical", "categorical", "categorical", "categorical", "categorical", "double", "categorical", "double", "categorical", "double", "double", "double", "categorical", "categorical", "double", "categorical"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, "raw_", "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Bus_3_INA_Status", "B4_status", "Unregulated_INA_Status", "MPPT_Ym_INA_Status", "cellOut_Ym_INA_Status", "cellOut_Xm_INA_Status", "B3_state", "cellOut_Xm_TMP_Status", "cellOut_Ym_TMP_Status", "panelOut_Xm_INA_Status", "MPPT_Yp_INA_Status", "panelOut_Ym_INA_Status", "MPPT_Xp_INA_Status", "B2_status", "B4_state", "Battery_INA_Status", "Destination", "B1_state", "Battery_GG_Status", "Internal_INA_Status", "Source", "Bus_1_INA_Status", "cellOut_Xp_TMP_Status", "raw_", "Request", "panelOut_Xp_INA_Status", "Service", "received_", "Bus_4_INA_Status", "B2_state", "Bus_2_INA_Status", "cellOut_Xp_INA_Status", "cellOut_Yp_INA_Status", "MPPT_Xm_INA_Status", "panelOut_Yp_INA_Status", "B3_status", "B1_status", "cellOut_Yp_TMP_Status"], "EmptyFieldRule", "auto");
opts = setvaropts(opts, "timestamp_", "InputFormat", "yyyy-MM-dd HH:mm:ss.SSS");

% Import the data
TelemetryEPS17072020 = readtable("C:\Users\cecil_000\Documents\GitHub\ThermalModel\Experiment\Telemetry_EPS_17072020.csv", opts);


%% Clear temporary variables
clear opts