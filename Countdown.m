%% Countdown 


%%
prompt = "How many large ones? \n";
large = input(prompt);


if (large > 6 || large < 0)
    prompt = "Enter a valid number (0-6) \n";
    large = input(prompt);
end

small = 6 - large;


numbers = [ randi(4,1,large) *25 , randi(10,1,small)]


pause(0.5)
goal = randi(900,1) + 100;
string("And the big one is: " + goal)


%numbers = [3,9,2,3,2,3]
%goal = 493
% calc for impossible = 2 449 533
%[solution, solved, calc] = solver2(goal, numbers, [],0, false);

%solution


[solution, solved, calc] = solver2(goal, numbers, [],0, false)

%[solution, solved, calc] = solver2(goal, [100,20,3], [],0, false)

% Solve recursively
function [solution, solved, calc] = solver2(goal, numbers, route, calc, solved)   


    for i = 1:length(numbers) -1
        % observed variable
        a = numbers(i);
        numbers(i) = []; 
        %calc = calc + 1;
        
        
        % Return the solution when , ending the recursion
        if a == goal
            solution = route;
            solved = true
            return
        end
        
        if (a ~= goal &&  length(numbers)-i+1 > 0) 
            
            for j = 1:length(numbers)-i+1
                j = j+i-1;  
                b = numbers(j);

                % Remove used variables from available numbers
                numbers(j) = [];
                if length(numbers) == 0
                    numbers = [];
                end

                if(~solved)
                    [solution, solved, calc] = solver2(goal, [a+b, numbers],[route, string(a + " + " + b + " = " + (a + b))], calc, solved);
                end
                if(~solved && a-b > 0)
                    [solution, solved, calc] = solver2(goal, [a-b, numbers], [route, string(a + " - " + b + " = " + (a - b))], calc, solved);
                end
                if(~solved && b-a > 0)
                    [solution, solved, calc] = solver2(goal, [ b-a, numbers],[route, string(b + " - " + a + " = " + (b - a))], calc, solved);
                end
                if(~solved)
                    [solution, solved, calc] = solver2(goal, [a*b, numbers],[route, string(a + " * " + b + " = " + (a * b))], calc, solved);
                end
                if(~solved && mod(a,b) == 0 && b ~=0)
                    [solution, solved, calc] = solver2(goal, [a/b, numbers],[route, string(a + " / " + b + " = " + (a / b))], calc, solved);
                end
                if(~solved && mod(b,a) == 0 && b ~=0)
                    [solution, solved, calc] = solver2(goal, [b/a, numbers],[route, string(b + " / " + a + " = " + (b / a))], calc, solved);
                end

                numbers = [numbers(1:j-1), b, numbers(j:length(numbers))];
            end
           numbers = [numbers(1:i-1), a, numbers(i:length(numbers))];
          
        end
        
    end
 
     if ~solved
         calc = calc + 1;
         route;
         solution = "no avalible solution";
     end
end

