
        

        
/* verilator lint_off WIDTH */        
module round_16_12 
   (
   input wire signed [15:0] data_in_signed,
   input wire [15:0] data_in_unsigned,
   output wire signed [11:0] data_out
   );

   logic signed [11:0] roundUp_signed;
   logic signed [11:0] roundDown_signed;
   logic [11:0] roundUp_unsigned;
   logic [11:0] roundDown_unsigned;
   logic signed [11:0] roundZero;
   logic signed [11:0] roundEven;

    assign roundUp_signed = data_in_signed[15 : 4] + (~data_in_signed[15] & (data_in_signed[3] | &data_in_signed[2 : 0]));
    assign roundDown_signed = data_in_signed[15 : 4] + (data_in_signed[15] & (data_in_signed[3] | &data_in_signed[2 : 0]));
    assign roundUp_unsigned = data_in_unsigned[15 : 4] + (data_in_unsigned[3] | &data_in_unsigned[2 : 0]);
    assign roundDown_unsigned = data_in_unsigned[15 : 4];
    assign roundZero = data_in_signed[15 : 4];
    assign roundEven = data_in_signed[15 : 4] + (data_in_signed[3] & (data_in_signed[4] | &data_in_signed[2 : 0]));


endmodule
/* verilator lint_on WIDTH */        
