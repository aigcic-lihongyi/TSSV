
        

        
/* verilator lint_off WIDTH */        
module SRAM_8_32_2rw_bit_undefOnWrite_default 
   (
   input logic  clk,
   input logic  a_re,
   input logic  a_we,
   input logic [7:0] a_data_in,
   output logic [7:0] a_data_out,
   input logic [4:0] a_addr,
   input logic  b_re,
   input logic  b_we,
   input logic [7:0] b_data_in,
   output logic [7:0] b_data_out,
   input logic [4:0] b_addr,
   input logic [7:0] a_wmask,
   input logic [7:0] b_wmask
   );

   logic [7:0] mem [0:31];


    always_ff @(posedge clk) begin
        for(integer i=0; i<8; i=i+1) begin
            if(a_we & a_wmask[i]) begin
                mem[a_addr][i*1 +: 1] <= a_data_in[i*1 +: 1];
            end else if(a_re) begin
                a_data_out <= mem[a_addr];
            end
        end
    end
    
    always_ff @(posedge clk) begin
        for(integer i=0; i<8; i=i+1) begin
            if(b_we & b_wmask[i]) begin
                mem[b_addr][i*1 +: 1] <= b_data_in[i*1 +: 1];
            end else if(b_re) begin
                b_data_out <= mem[b_addr];
            end
        end
    end
    

endmodule
/* verilator lint_on WIDTH */        
