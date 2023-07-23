module DataConverter_tb();
reg   CLK_30MHZ;
reg   CLK_48MHZ;
reg   RST;
reg   DIN;
reg   MODE;
wire  [7:0] DOUT_A;
wire  [7:0] DOUT_B;
wire  [7:0] DOUT_C;
wire  CLK_OUT;
wire  VALID;

DataConverter i1(
	.CLK_30MHZ(CLK_30MHZ),
    .CLK_48MHZ(CLK_48MHZ),
   	.RST(RST),
	.DIN(DIN),
	.MODE(MODE),
    .DOUT_A(DOUT_A),
    .DOUT_B(DOUT_B),
    .DOUT_C(DOUT_C),
    .CLK_OUT(CLK_OUT)
);
  always #30 CLK_30MHZ = ~CLK_30MHZ;
  always #48 CLK_48MHZ = ~CLK_48MHZ;
    // 模拟串行输入数据
  reg [39:0] test_data = 40'b1111111111101000100110110101011100111001;  // 模拟的测试数据
  integer bit_index = 40;
  always @(posedge CLK_30MHZ) 
  begin
        DIN <= test_data[bit_index - 1];  // 从测试数据中读取位值
        bit_index <= bit_index - 1;  // 移动到下一个位
        if (bit_index == 0)
            bit_index <= 40;  // 重置索引
  end
  initial 
  begin
      CLK_30MHZ = 0;
      RST = 0;
      #10;


      RST = 1;
      MODE = 1;
      #1200;
      $stop;
  end
endmodule 
