function need_num = floor_two(number)

    num = floor(number);
    str = num2str(num);
    len = length(str);
    
    if num == 0
        err = number;
        digits(2 + len - 1);                  %此处为需要的小数位+整数位
        need_num = num + vpa(err, 2+len);     %按要求保留的小数，但获得是符号性
        need_num = double(need_num);
    else
        err = number - num;                   %获取小数位
        digits(2 + len);                      %此处为需要的小数位+整数位
        need_num = num + vpa(err, 2+len);     %按要求保留的小数，但获得是符号性
        need_num = double(need_num);
    end
end