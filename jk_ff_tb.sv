
module jk_ff_tb;
    logic j,k,clk,rstn,q;
    parameter cc = 10;

    JK_FF DUT (
        .j(j),
        .k(k),
        .clk(clk),
        .rstn(rstn),
        .q(q)
    );

    bind JK_FF JK_FF_assertions assert_inst(
        .j(j),
        .k(k),
        .clk(clk),
        .rstn(rstn),
        .q(q)
    );

    initial begin 
        clk = 0;
        j = 0;
        k = 0;
    end

    always #(cc / 2) clk = ~clk;

    initial begin 
        rstn = 0;
        #10;
        rstn = 1;
        for(int i=0; i<4; i++) begin
            @(posedge clk)
            {j,k} = i;
        end
    end

    initial begin 
        $monitor("j=%0d | k=%0d | clk=%0d | rstn=%0d | q=%0d | time=%0t",j,k,clk,rstn,q,$time);
        $dumpfile("JK.vcd");
        $dumpvars(0,j,k,clk,rstn,q);
        #70 $finish;
    end

endmodule : jk_ff_tb