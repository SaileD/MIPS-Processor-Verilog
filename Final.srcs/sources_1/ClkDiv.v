`timescale 1ns / 1ps
module ClkDiv(Clk, Rst, in, ClkOut);
    input Clk, Rst;
    input [3:0] in;
    output reg ClkOut;
    //to create small Hz clock from 100-MHz on the board

    parameter DivVal0 = 50000000; //1Hz
    parameter DivVal1 = 45000000; //1.1111Hz
    parameter DivVal2 = 40000000; //1.25Hz
    parameter DivVal3 = 35000000; //1.4285Hz
    parameter DivVal4 = 30000000; //1.6666Hz
    parameter DivVal5 = 25000000; //2Hz
    parameter DivVal6 = 20000000; //2.5Hz
    parameter DivVal7 = 15000000; //3.3333Hz
    parameter DivVal8 = 10000000; //5Hz
    parameter DivVal9 = 5000000;  //10Hz
    parameter DivVal10 = 20; //10MHz
    
    
    reg [27:0] DivCnt;
    reg ClkInt;
    
    always @(posedge Clk) begin
        if( Rst == 1 )begin
            DivCnt <= 0;
            ClkOut <= 0;
            ClkInt <= 0;
        end
        else begin
            if( in[3] == 0 && in[2] == 0 && in[1] == 0 && in[0] == 0) begin
                if( DivCnt == DivVal0 ) begin
                    ClkOut <= ~ClkInt;
                    ClkInt <= ~ClkInt;
                    DivCnt <= 0;
                end
                else begin
                    ClkOut <= ClkInt;
                    ClkInt <= ClkInt;
                    DivCnt <= DivCnt + 1;
                end
            end
            
            else if ( in[3] == 0 && in[2] == 0 && in[1] == 0 && in[0] == 1) begin
                if( DivCnt == DivVal1 ) begin
                    ClkOut <= ~ClkInt;
                    ClkInt <= ~ClkInt;
                    DivCnt <= 0;
                end
                else begin
                    ClkOut <= ClkInt;
                    ClkInt <= ClkInt;
                    DivCnt <= DivCnt + 1;
                end
            end
            
            else if ( in[3] == 0 && in[2] == 0 && in[1] == 1 && in[0] == 0) begin
                if( DivCnt == DivVal2 ) begin
                    ClkOut <= ~ClkInt;
                    ClkInt <= ~ClkInt;
                    DivCnt <= 0;
            end
                else begin
                    ClkOut <= ClkInt;
                    ClkInt <= ClkInt;
                    DivCnt <= DivCnt + 1;
                end
            end
            
            else if ( in[3] == 0 && in[2] == 0 && in[1] == 1 && in[0] == 1) begin
                if( DivCnt == DivVal3 ) begin
                    ClkOut <= ~ClkInt;
                    ClkInt <= ~ClkInt;
                    DivCnt <= 0;
                end
                else begin
                    ClkOut <= ClkInt;
                    ClkInt <= ClkInt;
                    DivCnt <= DivCnt + 1;
                end
            end
            
            else if ( in[3] == 0 && in[2] == 1 && in[1] == 0 && in[0] == 0) begin
                if( DivCnt == DivVal4 ) begin
                    ClkOut <= ~ClkInt;
                    ClkInt <= ~ClkInt;
                    DivCnt <= 0;
                end
                else begin
                    ClkOut <= ClkInt;
                    ClkInt <= ClkInt;
                    DivCnt <= DivCnt + 1;
                end
            end
            
            else if ( in[3] == 0 && in[2] == 1 && in[1] == 0 && in[0] == 1) begin
                if( DivCnt == DivVal5 ) begin
                    ClkOut <= ~ClkInt;
                    ClkInt <= ~ClkInt;
                    DivCnt <= 0;
                end
                else begin
                    ClkOut <= ClkInt;
                    ClkInt <= ClkInt;
                    DivCnt <= DivCnt + 1;
                end
            end
            
            else if ( in[3] == 0 && in[2] == 1 && in[1] == 1 && in[0] == 0) begin
                if( DivCnt == DivVal6 ) begin
                    ClkOut <= ~ClkInt;
                    ClkInt <= ~ClkInt;
                    DivCnt <= 0;
                end
                else begin
                    ClkOut <= ClkInt;
                    ClkInt <= ClkInt;
                    DivCnt <= DivCnt + 1;
                end
            end
            
            else if ( in[3] == 0 && in[2] == 1 && in[1] == 1 && in[0] == 1) begin
                if( DivCnt == DivVal7 ) begin
                    ClkOut <= ~ClkInt;
                    ClkInt <= ~ClkInt;
                    DivCnt <= 0;
                end
                else begin
                    ClkOut <= ClkInt;
                    ClkInt <= ClkInt;
                    DivCnt <= DivCnt + 1;
                end
            end
            
            else if ( in[3] == 1 && in[2] == 0 && in[1] == 0 && in[0] == 0) begin
                if( DivCnt == DivVal8 ) begin
                    ClkOut <= ~ClkInt;
                    ClkInt <= ~ClkInt;
                    DivCnt <= 0;
                end
                else begin
                    ClkOut <= ClkInt;
                    ClkInt <= ClkInt;
                    DivCnt <= DivCnt + 1;
                end
            end
            
            else if ( in[3] == 1 && in[2] == 0 && in[1] == 0 && in[0] == 1) begin
                if( DivCnt == DivVal9 ) begin
                    ClkOut <= ~ClkInt;
                    ClkInt <= ~ClkInt;
                    DivCnt <= 0;
                end
                else begin
                    ClkOut <= ClkInt;
                    ClkInt <= ClkInt;
                    DivCnt <= DivCnt + 1;
                end
            end
            
            else if ( in[3] == 1 && in[2] == 0 && in[1] == 1 && in[0] == 0) begin
                if( DivCnt == DivVal10 ) begin
                    ClkOut <= ~ClkInt;
                    ClkInt <= ~ClkInt;
                    DivCnt <= 0;
                end
                else begin
                    ClkOut <= ClkInt;
                    ClkInt <= ClkInt;
                    DivCnt <= DivCnt + 1;
                end
            end
            
        end
    end
endmodule