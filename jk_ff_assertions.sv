
module JK_FF_assertions(
    input logic j,
    input logic k,
    input logic clk,
    input logic rstn,
    input logic q
);
    // Global Reset
    property global_reset_check; 
        @(posedge clk)
            !rstn |=> q == 0;
    endproperty : global_reset_check

    // RESET
    property reset_check;
        @(posedge clk)
            disable iff(!rstn)
            (j==0 && k==1) |=> q == 0; // Reset check
    endproperty : reset_check

    // SET 
    property set_check;
        @(posedge clk)
            disable iff(!rstn)
            (j==1 && k==0) |=> q == 1;
    endproperty : set_check

    // NO CHANGE
    property no_change_check;
        @(posedge clk)
            disable iff(!rstn)
            //q == $past(q); // If q == past q -> no change success
            (j==0 && k==0) |=> $stable(q); 
    endproperty : no_change_check

    // TOGGLE
    property toggle_check;
        @(posedge clk)
            disable iff(!rstn)
            (j && k) |=> (q == ~$past(q)); // Toggle check
    endproperty : toggle_check

// Do assert
    G_RESET : assert property (global_reset_check)
                $display("----PASS---- : G_RESET at time = %0t",$time);
            else 
                $display("----FAIL---- : G_RESET at time = %0t",$time);

    RESET : assert property (reset_check)
                $display("----PASS---- : RESET at time = %0t",$time);
            else 
                $display("----FAIL---- : RESET at time = %0t",$time);
    
    SET : assert property (set_check)
                $display("----PASS---- : SET at time = %0t",$time);
            else 
                $display("----FAIL---- : SET at time = %0t",$time);

    NO_CHANGE : assert property (no_change_check)
                $display("----PASS---- : NO_CHANGE at time = %0t",$time);
            else 
                $display("----FAIL---- : NO_CHANGE at time = %0t",$time);

    TOGGLE : assert property (toggle_check)
                $display("----PASS---- : TOGGLE at time = %0t",$time);
            else 
                $display("----FAIL---- : TOGGLE at time = %0t",$time);
endmodule : JK_FF_assertions