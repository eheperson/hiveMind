function [ weight ] = OurTableDesignProblem ( x )

length = x(1);
width = x(2);

weight = 1 * (length + width);

end
 