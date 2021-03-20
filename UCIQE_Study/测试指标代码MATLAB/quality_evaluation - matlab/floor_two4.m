function need_num = floor_two4(number, n)

    num = floor(number);
    str = num2str(num);
    len = length(str);
    
    if num == 0
        err = number;
        digits(n + len - 1);                  %此处为需要的小数位+整数位
        need_num = num + vpa(err, n+len);     %按要求保留的小数，但获得是符号性
        need_num = double(need_num);
    else
        err = number - num;                   %获取小数位
        digits(n + len);                      %此处为需要的小数位+整数位
        need_num = num + vpa(err, n+len);     %按要求保留的小数，但获得是符号性
        need_num = double(need_num);
    end
end