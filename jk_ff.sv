//zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz
// 8. Write assertions to verify the functionality of JK flipflop.
//zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz

module JK_FF(
    input logic j,k,clk,rstn,
    output logic q
);
    always@(posedge clk) begin 
        if(!rstn)
            q <= 0;
        else if(!j && !k) 
            q <= q;
        else if(j && !k)
            q <= 1;
        else if(!j && k)
            q <= 0;
        else 
            q <= ~q; 
    end
endmodule : JK_FF

