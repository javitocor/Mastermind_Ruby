#!/usr/bin/env ruby
class Colors
    def red;            "\e[31m#{self}\e[0m" end
    def green;          "\e[32m#{self}\e[0m" end
    def brown;          "\e[33m#{self}\e[0m" end
    def blue;           "\e[34m#{self}\e[0m" end
    def magenta;        "\e[35m#{self}\e[0m" end
    def cyan;           "\e[36m#{self}\e[0m" end

    def bg_black;       "\e[40m#{self}\e[0m" end
    def bg_red;         "\e[41m#{self}\e[0m" end
    def bg_green;       "\e[42m#{self}\e[0m" end
    def bg_brown;       "\e[43m#{self}\e[0m" end
    def bg_blue;        "\e[44m#{self}\e[0m" end
    def bg_magenta;     "\e[45m#{self}\e[0m" end
    def bg_cyan;        "\e[46m#{self}\e[0m" end
    def bg_gray;        "\e[47m#{self}\e[0m" end

    def bold;           "\e[1m#{self}\e[22m" end
    def italic;         "\e[3m#{self}\e[23m" end
    def underline;      "\e[4m#{self}\e[24m" end
    def blink;          "\e[5m#{self}\e[25m" end
    def reverse_color;  "\e[7m#{self}\e[27m" end
  end

class Board
    def panel
        puts '----------'
        puts "|#{$tries[11][0]}|#{$tries[11][1]}|#{$tries[11][2]}|#{$tries[11][3]}|"
        puts '----------'
        puts "|#{$tries[10][0]}|#{$tries[10][1]}|#{$tries[10][2]}|#{$tries[10][3]}|"
        puts '----------'
        puts "|#{$tries[9][0]}|#{$tries[9][1]}|#{$tries[9][2]}|#{$tries[9][3]}|"
        puts '----------'
        puts "|#{$tries[8][0]}|#{$tries[8][1]}|#{$tries[8][2]}|#{$tries[8][3]}|"
        puts '----------'
        puts "|#{$tries[7][0]}|#{$tries[7][1]}|#{$tries[7][2]}|#{$tries[7][3]}|"
        puts '----------'
        puts "|#{$tries[6][0]}|#{$tries[6][1]}|#{$tries[6][2]}|#{$tries[6][3]}|"
        puts '----------'
        puts "|#{$tries[5][0]}|#{$tries[5][1]}|#{$tries[5][2]}|#{$tries[5][3]}|"
        puts '----------'
        puts "|#{$tries[4][0]}|#{$tries[4][1]}|#{$tries[4][2]}|#{$tries[4][3]}|"
        puts '----------'
        puts "|#{$tries[3][0]}|#{$tries[3][1]}|#{$tries[3][2]}|#{$tries[3][3]}|"
        puts '----------'
        puts "|#{$tries[2][0]}|#{$tries[2][1]}|#{$tries[2][2]}|#{$tries[2][3]}|"
        puts '----------'
        puts "|#{$tries[1][0]}|#{$tries[1][1]}|#{$tries[1][2]}|#{$tries[1][3]}|"
        puts '----------'
        puts "|#{$tries[0][0]}|#{$tries[0][1]}|#{$tries[0][2]}|#{$tries[0][3]}|"
        puts '----------'
        p "Here's your current board"
    end

    def panel_reset
        $tries_played = 0
        $colors_played = 0
        $tries = [["a2","a2","a2","a2"],["a2","a2","a2","a2"],["a2","a2","a2","a2"],["a2","a2","a2","a2"],["a2","a2","a2","a2"],["a2","a2","a2","a2"],["a2","a2","a2","a2"],["a2","a2","a2","a2"],["a2","a2","a2","a2"],["a2","a2","a2","a2"],["a2","a2","a2","a2"],["a2","a2","a2","a2"]]
        return $colors_played
    end
end

class Computer
    def randomly
        $randomly = ["red","green","brown","magenta","blue","cyan"]
        $randonly2 = $randomly.sample(4)
        return $randomly
    end
end

class Check 
    def checker_win
        status = false
        status = true if ($randonly2 == $tries[$tries_played]) == true
        return status
    end
    def checker_cases
        $count = 0
        $tries[$tries_played].each {|x| $randonly2.include?(x) ? $count+=1 : $count}        
    end

    def checker_matches
        $count2 = 0
        $tries[$tries_played].zip($randonly2).map { |a, b| a==b ? $count2+=1 : $count2  }        
    end
end
class Choose < Computer
    def selector
        print "Do you want to be the coder? (y/n) : "
        $answer2 = gets.chomp
        if $answer2 == "y" 
            chooser
        else
            $new_random = Computer.new
            $new_random.randomly 
        end 
    end
    def chooser
        $randomly = ["red","green","brown","magenta","blue","cyan"]
        $randonly2 = []
        var = 0
        while var < 4
            print "Choose a color: "
            col = gets.chomp
            if $randomly.include?(col)
                $randonly2.push(col)
                var += 1
            else
                puts "Choose a correct color"
            end
        end
    end
end
class Game < Check
    def initialize(player1)
        @player1 = player1
        puts "Welcome #{@player1}, let's play Mastermind "
        puts "Try to find out the four different colors and its exact position"
        sleep 1
    end

    def restart(answer)
        $answer == 'y' ? start : (p 'see you next time, goodbye!')
    end

    def start
        $new_selector = Choose.new
        $new_selector.selector
        puts "Let's start the game"
        sleep 1
        puts "You can choose between 6 colors"
        sleep 1
        puts "red, green, brown, blue, magenta and cyan"
        sleep 1
        $new_board = Board.new 
        $new_board.panel_reset       
        $new_board.panel     
        turn
        print 'would you like to play another game? (y/n) : '
        $answer = gets.chomp
        restart($answer)
    end
    private 
    def turn
        while $tries_played < 13 
            print "Choose a color: "
            color1 = gets.chomp
            add(color1)
            win
            break if checker_win == true || $tries_played == 12
        end
    end

    def add(color)        
        $possible = true
        $possible = false if $randomly.any?(color) == false || $tries[$tries_played].include?(color)
        puts 'Please enter a valid color' if $possible == false
        if $possible == true
            $tries[$tries_played][$colors_played] = color
            $colors_played += 1 
        end    
    end

    def win
        if $colors_played == 4
            if checker_win == true
                puts "You win #{@player1}"                
            else
                checker_cases
                checker_matches
                puts "You have #{$count} colors and #{$count2} matches"
                puts "Try again!"
                $tries_played+=1
                $colors_played = 0                    
                $new_board.panel   
            end
        end
    end
end
