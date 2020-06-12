module bcd (input logic [9:0] bin,
	    output logic [11:0] decout);
timeunit 1ns;
timeprecision 100ps;

logic [3:0] hun,ten,uni,hun1,ten1,uni1,hun2,ten2,uni2,hun3,ten3,uni3,hun4,ten4,uni4,hun5,ten5,uni5,hun6,ten6,uni6,hun7,ten7,uni7;

always_comb
begin
{hun,ten,uni} = {9'b0,bin[9:7]};
if(uni >= 5)
{hun1,ten1,uni1} = {{{hun[2:0],ten,uni}+12'b000000000011},bin[6]};
else
begin
{hun1,ten1,uni1} = {hun[2:0],ten,uni,bin[6]};
end


if(uni1 >= 5)
begin
	if (ten1 >= 5)
	begin
		if (hun1 >= 5)
		begin
		{hun2,ten2,uni2} = {{{hun1[2:0],ten1,uni1}+12'b001100110011},bin[5]};
		end
		else
		begin
		{hun2,ten2,uni2} = {{{hun1[2:0],ten1,uni1}+12'b000000110011},bin[5]};
		end
	end
	else
	{hun2,ten2,uni2} = {{{hun1[2:0],ten1,uni1}+12'b000000000011},bin[5]};
end

else if (ten1 >= 5)
begin
	if (hun1 >= 5)
	begin
	{hun2,ten2,uni2} = {{{hun1[2:0],ten1,uni1}+12'b001100110000},bin[5]};
	end
	else	
	{hun2,ten2,uni2} = {{{hun1[2:0],ten1,uni1}+12'b000000110000},bin[5]};
end

else if (hun1 >= 5)
{hun2,ten2,uni2} = {{{hun1[2:0],ten1,uni1}+12'b001100000000},bin[5]};
else
{hun2,ten2,uni2} = {hun1[2:0],ten1,uni1,bin[5]};

if(uni2 >= 5)
begin
	if (ten2 >= 5)
	begin
		if (hun2 >= 5)
		begin
		{hun3,ten3,uni3} = {{{hun2[2:0],ten2,uni2}+12'b001100110011},bin[4]};
		end
		else
		begin
		{hun3,ten3,uni3} = {{{hun2[2:0],ten2,uni2}+12'b000000110011},bin[4]};
		end
	end
	else
	{hun3,ten3,uni3} = {{{hun2[2:0],ten2,uni2}+12'b000000000011},bin[4]};
end

else if (ten2 >= 5)
begin
	if (hun2 >= 5)
	begin
	{hun3,ten3,uni3} = {{{hun2[2:0],ten2,uni2}+12'b001100110000},bin[4]};
	end
	else	
	{hun3,ten3,uni3} = {{{hun2[2:0],ten2,uni2}+12'b000000110000},bin[4]};
end

else if (hun2 >= 5)
{hun3,ten3,uni3} = {{{hun2[2:0],ten2,uni2}+12'b001100000000},bin[4]};
else
{hun3,ten3,uni3} = {hun2[2:0],ten2,uni2,bin[4]};

if(uni3 >= 5)
begin
	if (ten3 >= 5)
	begin
		if (hun3 >= 5)
		begin
		{hun4,ten4,uni4} = {{{hun3[2:0],ten3,uni3}+12'b001100110011},bin[3]};
		end
		else
		begin
		{hun4,ten4,uni4} = {{{hun3[2:0],ten3,uni3}+12'b000000110011},bin[3]};
		end
	end
	else
	{hun4,ten4,uni4} = {{{hun3[2:0],ten3,uni3}+12'b000000000011},bin[3]};
end

else if (ten3 >= 5)
begin
	if (hun3 >= 5)
	begin
	{hun4,ten4,uni4} = {{{hun3[2:0],ten3,uni3}+12'b001100110000},bin[3]};
	end
	else	
	{hun4,ten4,uni4} = {{{hun3[2:0],ten3,uni3}+12'b000000110000},bin[3]};
end

else if (hun3 >= 5)
{hun4,ten4,uni4} = {{{hun3[2:0],ten3,uni3}+12'b001100000000},bin[3]};
else
{hun4,ten4,uni4} = {hun3[2:0],ten3,uni3,bin[3]};

if(uni4 >= 5)
begin
	if (ten4 >= 5)
	begin
		if (hun4 >= 5)
		begin
		{hun5,ten5,uni5} = {{{hun4[2:0],ten4,uni4}+12'b001100110011},bin[2]};
		end
		else
		begin
		{hun5,ten5,uni5} = {{{hun4[2:0],ten4,uni4}+12'b000000110011},bin[2]};
		end
	end
	else
	{hun5,ten5,uni5} = {{{hun4[2:0],ten4,uni4}+12'b000000000011},bin[2]};
end

else if (ten4 >= 5)
begin
	if (hun4 >= 5)
	begin
	{hun5,ten5,uni5} = {{{hun4[2:0],ten4,uni4}+12'b001100110000},bin[2]};
	end
	else	
	{hun5,ten5,uni5} = {{{hun4[2:0],ten4,uni4}+12'b000000110000},bin[2]};
end

else if (hun4 >= 5)
{hun5,ten5,uni5} = {{{hun4[2:0],ten4,uni4}+12'b001100000000},bin[2]};
else
{hun5,ten5,uni5} = {hun4[2:0],ten4,uni4,bin[2]};

if(uni5 >= 5)
begin
	if (ten5 >= 5)
	begin
		if (hun5 >= 5)
		begin
		{hun6,ten6,uni6} = {{{hun5[2:0],ten5,uni5}+12'b001100110011},bin[1]};
		end
		else
		begin
		{hun6,ten6,uni6} = {{{hun5[2:0],ten5,uni5}+12'b000000110011},bin[1]};
		end
	end
	else
	{hun6,ten6,uni6} = {{{hun5[2:0],ten5,uni5}+12'b000000000011},bin[1]};
end

else if (ten5 >= 5)
begin
	if (hun5 >= 5)
	begin
	{hun6,ten6,uni6} = {{{hun5[2:0],ten5,uni5}+12'b001100110000},bin[1]};
	end
	else	
	{hun6,ten6,uni6} = {{{hun5[2:0],ten5,uni5}+12'b000000110000},bin[1]};
end

else if (hun5 >= 5)
{hun6,ten6,uni6} = {{{hun5[2:0],ten5,uni5}+12'b001100000000},bin[1]};
else
{hun6,ten6,uni6} = {hun5[2:0],ten5,uni5,bin[1]};

if(uni6 >= 5)
begin
	if (ten6 >= 5)
	begin
		if (hun6 >= 5)
		begin
		{hun7,ten7,uni7} = {{{hun6[2:0],ten6,uni6}+12'b001100110011},bin[0]};
		end
		else
		begin
		{hun7,ten7,uni7} = {{{hun6[2:0],ten6,uni6}+12'b000000110011},bin[0]};
		end
	end
	else
	{hun7,ten7,uni7} = {{{hun6[2:0],ten6,uni6}+12'b000000000011},bin[0]};
end

else if (ten6 >= 5)
begin
	if (hun6 >= 5)
	begin
	{hun7,ten7,uni7} = {{{hun6[2:0],ten6,uni6}+12'b001100110000},bin[0]};
	end
	else	
	{hun7,ten7,uni7} = {{{hun6[2:0],ten6,uni6}+12'b000000110000},bin[0]};
end

else if (hun6 >= 5)
{hun7,ten7,uni7} = {{{hun6[2:0],ten6,uni6}+12'b001100000000},bin[0]};
else
begin
{hun7,ten7,uni7} = {hun6[2:0],ten6,uni6,bin[0]};
end
decout = {hun7,ten7,uni7};
end

endmodule

