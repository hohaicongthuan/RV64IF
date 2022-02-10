// This module returns the min/max number of two inputted numbers

module FP_MinMax(in_numA, in_numB, out_data, in_ctrl_minmax);
    parameter DATA_WIDTH = 32;

    input   in_ctrl_minmax;
    input   [DATA_WIDTH - 1:0] in_numA, in_numB;

    output reg  [DATA_WIDTH - 1:0] out_data;

    always @ (*) begin
        if (in_ctrl_minmax) begin
            // Find maximum
            if (in_numA[31] != in_numB[31]) begin// Two numbers have different signs
                out_data = (!in_numA[30:23]) ? in_numA : in_numB;
            end else begin // Two numbers have the same signs -> compare exponents
                if (in_numA[30:23] != in_numB[30:23]) begin // Two numbers have different exponents
                    out_data = (in_numA[30:23] > in_numB[30:23]) ? in_numA : in_numB;
                end else begin // Two numbers have the same exponents -> compare mantissae
                    out_data = (in_numA[22:0] > in_numB[22:0]) ? in_numA : in_numB;
                end
            end
        end else begin
            // Find minimum
            if (in_numA[31] != in_numB[31]) begin// Two numbers have different signs
                out_data = (in_numA[30:23]) ? in_numA : in_numB;
            end else begin // Two numbers have the same signs -> compare exponents
                if (in_numA[30:23] != in_numB[30:23]) begin // Two numbers have different exponents
                    out_data = (in_numA[30:23] < in_numB[30:23]) ? in_numA : in_numB;
                end else begin // Two numbers have the same exponents -> compare mantissae
                    out_data = (in_numA[22:0] < in_numB[22:0]) ? in_numA : in_numB;
                end
            end
        end
    end
endmodule