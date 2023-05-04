.386
IDEAL
MODEL small
STACK 100h

MAX_BMP_WIDTH = 320
MAX_BMP_HEIGHT = 200

SMALL_BMP_HEIGHT = 5 ;40
SMALL_BMP_WIDTH = 5 ;40

; ------------ CODE BY 7PAWNS -------

DATASEG
    ; --------------- GAME RUNNING ---------------------
    time_milliseconds db 0 ; variable used when checking if time has changed
    
    current_level dw 0 ; what current_level I am in
    max_level dw 0 ; ball for each level - max level is the targeted level
    level_text_number db 1
    level_text db '1', '$'
    
    void_pixels_counter dw 0
    
    count_void_pixels_num dw 0
    count_void_pixels_text db '0', '$'
    
    won db 0
    
    
    
    lives db 3
    lives_text db '3', '$'
    lives_text_word db 'LIVES', '$'
    
    time_left_right db 0
    time_left_right_text db '0', '$'
    time_left_middle db 0
    time_left_middle_text db '0', '$'
    time_left_left db 6
    time_left_left_text db '6', '$'
    
    time_left_text_ui db 'TIME LEFT:', '$'
    
    target_area_captured db 'TARGET AREA: 65%', '$'
    
    
    mid_game_message_sign db 4
    almost_there db 'ALMOST THERE!', '$'
    keep_going db 'KEEP GOING', '$'
    getting_started db 'BETTER...', '$'
    get_good db 'GET GOOD', '$'
    
    
    ip_temp dw 0
    
    esc_key db 'PRESS ESC TO EXIT', '$'
    ; -------------------- UI --------------------------
    ui_area_top_x dw 0 ; x value of top UI area
    ui_area_top_y dw 0 ; y value of top UI area
    
    ui_area_bottom_x dw 0 ; x value of bottom UI area
    ui_area_bottom_y dw 175 ; y value of bottom UI area
    
    ui_area_left_x dw 0 ; x value of top UI area (just for organization)
    ui_area_left_y dw 0 ; y value of top UI area (just for organization)
    
    ui_area_right_x dw 305 ; x value of bottom UI area
    ui_area_right_y dw 0 ; y value of bottom UI area
    
    line_width_horizontal dw 25 ; width of each horizontal line
    line_width_vertical dw 15 ; width of each vertical line
    
    color db 19 ; color of the lines
    
    ; -------------------- WALLS -------------------------
    
    horizontal_or_vertical dw ? ; 0 --> horizontal 1 --> vertical
    
    color_top_left_line db 4 ; color of the top and left part of the walls
    color_bottom_right_line db 1 ; color of the bottom and right part of the walls
    
    wall_width dw 10    
            
    wall_velocity dw 01h ; velocity of the bottom part of the wall (in the end it will run 4 times)
    wall_chunk_size dw 03h
    
    waiting_for_input db 1 ; 0 --> waiting for mouse input 1 --> building walls
    
    top_y_collision dw ? ; void wall collision with top wall
    left_x_collision dw ? ; void wall collision with left wall
    
   
    ; ++++++++++++++++++++ VERTICAL ++++++++++++++++++++++

    wall_bottom_start_x dw ?
    wall_bottom_start_y dw ?
    
    wall_bottom_x dw ? ; x value of starting position of the bottom wall
    wall_bottom_y dw ? ; y value of starting position of the bottom wall
    
    wall_top_start_x dw ? ; x value of current position of the bottom wall
    wall_top_start_y dw ? ; y value of current position of the bottom wall
    
    wall_top_x dw ? ; x value of starting position of the top wall
    wall_top_y dw ? ; y value of starting position of the top wall
    
    wall_vertical_bottom_stopped db 0 ; 1 --> the bottom vetical wall stopped building
    wall_vertical_top_stopped db 0; 1 --> the top vertical wall stopped building
    
    ; +++++++++++++++++++ HORIZONTAL ++++++++++++++++++++++++++

    wall_right_start_x dw ? ; x value of right position 
    wall_right_start_y dw ? ; y value of right position 
    
    wall_right_x dw ? ; x value of starting position of the right wall
    wall_right_y dw ? ; y value of starting position of the right wall
    
    wall_left_start_x dw ? ; x value of current position of the left wall
    wall_left_start_y dw ? ; y value of current position of the left wall
    
    wall_left_x dw ? ; x value of starting position of the left wall
    wall_left_y dw ? ; y value of starting position of the left wall
    
    wall_horizontal_right_stopped db 0 ; 1 --> the right vetical wall stopped building
    wall_horizontal_left_stopped db 0; 1 --> the left vertical wall stopped building
    
    ; ++++++++++++++++++++ void +++++++++++++++++++++++++++++
    
    right_is_void db 0
    left_is_void db 0
    top_is_void db 0
    bottom_is_void db 0
    ; --------------------- BALLS --------------------------
 
    
    ballsize dw 06h ; pixels in width and height
    
    color_ball db 15 ; color white
    
    
    balls_x dw 130, 190, 210, 100, 70, 50, 150, 250, 90, 40
    balls_y dw 100, 100, 150, 50, 70, 50, 30, 100, 100, 40
    balls_Xvelocity dw 1, -1, 1, -1, 1, -1, 1, -1, 1 , 1
    balls_Yvelocity dw 1, -1, -1, 1, 1, -1 ,-1 , 1, -1, -1
    
    ; --------------------- BMPS ---------------------------
    loser_end_menu db 'loser_m.bmp',0
    main_menu db 'main_m.bmp', 0
    how_menu db 'how_m.bmp', 0
    cleared db 'cleared.bmp', 0
    won_menu_file db 'won_m.bmp', 0
    
    OneBmpLine  db MAX_BMP_WIDTH dup (0)  ; One Color line read buffer
    ScreenLineMax   db MAX_BMP_WIDTH dup (0)  ; One Color line read buffer

    ;BMP File data
    FileHandle  dw ?
    Header      db 54 dup(0)
    Palette     db 400h dup (0)

    BmpFileErrorMsg     db 'Error At Opening Bmp File .', 0dh, 0ah,'$'
    ErrorFile           db 0
    BB db "BB..",'$'

    BmpLeft dw ?
    BmpTop dw ?
    BmpColSize dw ?
    BmpRowSize dw ?
    
    ; ------------------------ END MENU --------------------------
    
    line_corx dw 100
    line_cory dw 140
    line_color db 15
    
    
    ; --------------------- BUG FIXING ----------------------
    check db 'check', '$' ; for checking if things work
    
    ; ---------------------- MUSIC -------------------------

    note dw 0  
    
    note_collision dw 2394h

    note_wall dw 2109d

    key_press dw 3000d
    
    level_cleared dw  4500d, 3500d, 2500d


CODESEG

start:
    
    mov ax, @data
    mov ds, ax
    
    
    mov ax, 13h
    int 10h  

    
    
    call main_menu_proc
    
    
   update_level:
        
        ; check if won
        inc [max_level]
        cmp [max_level], 10
        jne update_level_next
        call won_menu
        
        update_level_next: ; update and reset variables for next level
        
        mov [waiting_for_input], 1
        
        mov bx, offset level_cleared
        push [word ptr bx]
        call sound
        add bx, 2
        push [word ptr bx]
        call sound
        add bx, 2
        push [word ptr bx]
        call sound
        
        lea dx, [cleared]
        mov [BmpColSize], 320d
        mov [BmpRowSize], 200d
        mov [BmpTop], 0
        mov [BmpLeft], 0
        
        cmp [won], 0
        jne print_level_complete
        
        mov [time_left_right], 0
        mov [time_left_middle], 0
        mov [time_left_left], 6
        
        
        mov [won], 0  
        
        
        call reset_game_area
        jmp start_game
        
        print_level_complete: ; level cleared menu
            mov [won], 0
            
            
            mov [time_left_right], 0
            mov [time_left_middle], 0
            mov [time_left_left], 6
            call Print_final
            mov ah, 02h     ; set cursor position
            mov bh, 00h     ; set page number
            mov dh, 10  ; set row
            mov dl, 1Ah ; set column
            int 10h
            
            mov ah, 09h     ; write string to standard output
            mov al, [level_text_number]
            add al, 30h
            mov [level_text], al
            lea dx, [level_text] ; (load effective adress) just like mov but can calculate and doesn't adress memory
            
            int 21h     ; print the string
            
            inc [level_text_number]
            call Delay
start_game:
    
    
    
    call clear_screen
    
    mov [lives], 3
    
    call reset_game_area
    
    call draw_ui ; draw the game UI
    
    mov ax,0h ; reset mouse
    int 33h
    
   
    
    check_time:

        mov ah, 2Ch ; get the system time
        int 21h  ; ch = hour cl = minute dh = second dl = 1/100 seconds
        
        cmp dl, [time_milliseconds] ; is the current time equal to the previous one?
        je Check_Time ; if the same check again
        mov [time_milliseconds], dl ; update time
        
        call update_time_left ; time left text
        
        mov ah, 01
        int 16h ;read one key from the user
        
        cmp al, 1bh ; press esc for main menu
        je main_menu_label

        call check_if_won ; winning check
        cmp [won], 0
        jne update_level
        
        call update_ui_text_proc
        
        
        draw_multiple_balls: ; loop for moving and drawing all balls in array
        call ball_speed_control
        call draw_ball
        inc [current_level]
        mov ax, [current_level]
        cmp ax, [max_level]
        jng draw_multiple_balls
        
        mov [current_level], 0
         
        
        
        cmp [waiting_for_input], 0 ; are walls done?
        jne wait_for_click
        cmp [horizontal_or_vertical], 01h ; for left click
        je loop_until_collision_or_success_vertical
        cmp [horizontal_or_vertical], 02h ; for right click
        je loop_until_collision_or_success_horizontal
        jmp wait_for_click
        
        
        wait_for_click:
            

            
            mov ax,1h ; show mouse
            int 33h
            
            mov ax,3h ; get mouse state
            int 33h
            
            mov [horizontal_or_vertical], bx
            
            cmp [horizontal_or_vertical], 01h ; for left click
            je left_click
            
            cmp [horizontal_or_vertical], 02h ; right click
            je right_click
            
            jmp check_time
        
        
        
        left_click:
            
            mov ax, 02h ; hide the mouse
            int 33h
            
            shr cx, 1
            mov bh, 0h 
            mov ah,0Dh
            int 10H ; AL = COLOR of pixel
            cmp al, [color] ; comparing to void
            je wait_for_click
            cmp al, [color_ball]
            je wait_for_click
            loop_until_collision_or_success_vertical:
        
                call vertical_wall_speed_control
                call draw_vertical_wall
                
                cmp [wall_vertical_bottom_stopped], 1
                jne check_time
                cmp [wall_vertical_top_stopped], 1
                jne check_time
                
                mov [waiting_for_input], 1
                
                jmp check_time
            
        right_click:
        
            mov ax, 02h ; hide the mouse
            int 33h
            
            shr cx, 1
            mov bh, 0h 
            mov ah,0Dh
            int 10H ; AL = COLOR of pixel
            cmp al, [color] ; comparing to void
            je wait_for_click
            cmp al, [color_ball]
            je wait_for_click
            loop_until_collision_or_success_horizontal:
            
                call horizontal_wall_speed_control
                call draw_horizontal_wall
                
                cmp [wall_horizontal_right_stopped], 1
                jne check_time
                cmp [wall_horizontal_left_stopped], 1
                jne check_time
                
                mov [waiting_for_input], 1
                
                jmp check_time
                
            
        
                
            
    proc update_time_left ; handling the timer
        
        dec [time_left_right]
        cmp [time_left_right], 0
        jnl end_update_time_left
        mov [time_left_right], 9
        dec [time_left_middle]
        cmp [time_left_middle], 0
        jnl end_update_time_left
        mov [time_left_middle], 9
        dec [time_left_left]
        cmp [time_left_left], 0
        jnl end_update_time_left
        call end_menu_loser
        end_update_time_left:
        ret
    endp update_time_left
            
    proc reset_game_area

        mov cx, 16
        mov dx, 26
            
            reset_game_area_loop:
                
                mov ah, 0ch ; set the configuration to writing a pixel
                mov al, 8 ; choose void as color
                mov bh, 00h ; set the page number
                int 10h 
                inc cx
                cmp cx, 305
                jng reset_game_area_loop
                mov cx, 16
                inc dx
                cmp dx, 175
                jng reset_game_area_loop
                ret
                
                
    
    
    endp reset_game_area
    proc draw_game_area ; sets background as gray
            
            MOV AH, 06h    ; Scroll up function
            XOR AL, AL     ; Clear entire screen
            XOR CX, CX     ; Upper left corner CH=row, CL=column
            MOV DX, 184FH  ; lower right corner DH=row, DL=column 
            MOV BH, 8    ; YellowOnBlue
            INT 10H
        ret
    endp draw_game_area
    
    proc draw_ui
        
        
        
        mov cx, [ui_area_top_x] ; set the column
        mov dx, [ui_area_top_y] ; set the row
        
        draw_top_line:
            
            mov ah, 0ch ; set the configuration to writing a pixel
            mov al, [color] ; choose void as color
            mov bh, 00h ; set the page number
            int 10h
            inc cx ; cx = cx + 1
            mov ax, cx 
            sub ax, [ui_area_top_x] ; ax becomes the difference between new position and previous position
            cmp ax, 320
            jng draw_top_line ; jng = jump not greater
            
            mov cx, [ui_area_top_x] ;initialization
            inc dx      ;initialization
            mov ax, dx
            sub ax, [ui_area_top_y]
            cmp ax, [line_width_horizontal] 
            jng draw_top_line ; jng = jump not greater
        
        mov cx, [ui_area_bottom_x] ; set the column
        mov dx, [ui_area_bottom_y] ; set the row
        
        draw_bottom_line:
        
            mov ah, 0ch ; set the configuration to writing a pixel
            mov al, [color] ; choose void as color
            mov bh, 00h ; set the page number
            int 10h
            inc cx ; cx = cx + 1
            mov ax, cx 
            sub ax, [ui_area_bottom_x] ; ax becomes the difference between new position and previous position
            cmp ax, 320
            jng draw_bottom_line ; jng = jump not greater
            
            mov cx, [ui_area_bottom_x] ;initialization
            inc dx      ;initialization
            mov ax, dx
            sub ax, [ui_area_bottom_y]
            cmp ax, [line_width_horizontal] 
            jng draw_bottom_line ; jng = jump not greater
            
        mov cx, [ui_area_left_x] ; set the column
        mov dx, [ui_area_left_y] ; set the row
        
        draw_left_line:
            
            mov ah, 0ch ; set the configuration to writing a pixel
            mov al, [color] ; choose void as color
            mov bh, 00h ; set the page number
            int 10h
            inc cx ; cx = cx + 1
            mov ax, cx 
            sub ax, [ui_area_left_x] ; ax becomes the difference between new position and previous position
            cmp ax, [line_width_vertical]
            jng draw_left_line ; jng = jump not greater
            
            mov cx, [ui_area_left_x] ;initialization
            inc dx      ;initialization
            mov ax, dx
            sub ax, [ui_area_left_y]
            cmp ax, 200
            jng draw_left_line ; jng = jump not greater
            
        mov cx, [ui_area_right_x] ; set the column
        mov dx, [ui_area_right_y] ; set the row
            
        draw_right_line:
        
            mov ah, 0ch ; set the configuration to writing a pixel
            mov al, [color] ; choose void as color
            mov bh, 00h ; set the page number
            int 10h
            inc cx ; cx = cx + 1
            mov ax, cx 
            
            cmp ax, 320
            jng draw_right_line ; jng = jump not greater
            
            mov cx, [ui_area_right_x] ;initialization
            inc dx      ;initialization
            mov ax, dx
            sub ax, [ui_area_right_y]
            cmp ax, 200
            jng draw_right_line ; jng = jump not greater
            
        ret
    endp draw_ui
    
    proc draw_ball
        
        mov ax, 02h ; hide the mouse
        int 33h
    
        mov bx, offset balls_x
        add bx, [current_level]
        add bx, [current_level]
        mov cx, [bx] ; set the column (ball_x)
        mov bx, offset balls_y
        add bx, [current_level]
        add bx, [current_level]
        mov dx, [bx] ; set the row (ball_y)
        draw_ball_horizontal:
            mov ah, 0ch ; set the configuration to writing a pixel
            mov al, [color_ball] ; choose red as color
            mov bh, 00h ; set the page number
            int 10h
            inc cx
            mov ax, cx
            mov bx, offset balls_x
            add bx, [current_level]
            add bx, [current_level]
            sub ax, [bx]
            cmp ax, [ballsize] ; check ball_x
            jng draw_ball_horizontal ; jng = jump not greater
            mov bx, offset balls_x
            add bx, [current_level]
            add bx, [current_level]
            mov cx, [bx] ;initialization
            inc dx      ;initialization
            mov ax, dx
            mov bx, offset balls_y
            add bx, [current_level]
            add bx, [current_level]
            sub ax, [bx]
            cmp ax, [ballsize] ; check ball_y
            jng draw_ball_horizontal ; jng = jump not greater
            
          mov ax,1h ; show mouse
            int 33h
        
        ret
    endp draw_ball
    
    
    proc move_ball ; add clear ball and then it should work (each pixel should be colored by the one above him)


        call clear_ball_procedure
        mov ah,0Dh
        mov bx, offset balls_x
        add bx, [current_level]
        add bx, [current_level]
        mov cx,[bx]
        add cx, [ballsize]
        inc cx
        mov bx, offset balls_y
        add bx, [current_level]
        add bx, [current_level]
        mov dx,[bx]
        mov bh, 0
        int 10H ; AL = COLOR
        
        
        cmp al, [color]
        je collision_on_right_void
        cmp al, [color_bottom_right_line]
        je remove_blue_red_walls_vertical_label_1
        cmp al, [color_top_left_line]
        je remove_blue_red_walls_vertical_label_1

        left_collision_check:
        mov ah,0Dh
        mov bx, offset balls_x
        add bx, [current_level]
        add bx, [current_level]
        mov cx,[bx]
        dec cx
        mov bx, offset balls_y
        add bx, [current_level]
        add bx, [current_level]
        mov dx,[bx]
        mov bh, 0
        int 10H ; AL = COLOR
        
        cmp al, [color]
        je collision_on_left_void
        cmp al, [color_bottom_right_line]
        je remove_blue_red_walls_vertical_label_2
        cmp al, [color_top_left_line]
        je remove_blue_red_walls_vertical_label_2
        
        
        
        
        move_the_ball_horizontal:
        mov bx, offset balls_Xvelocity
        add bx, [current_level]
        add bx, [current_level]
        mov ax, [bx]
        mov bx, offset balls_x
        add bx, [current_level]
        add bx, [current_level]
        add [bx], ax
        
        jmp vertical_ball


        collision_on_right_void:
            
            mov bx, offset balls_Xvelocity
            add bx, [current_level]
            add bx, [current_level]
            neg [word ptr bx]
            jmp move_the_ball_horizontal
        collision_on_left_void:
            
            mov bx, offset balls_Xvelocity
            add bx, [current_level]
            add bx, [current_level]
            neg [word ptr bx]
            jmp move_the_ball_horizontal
            
        remove_blue_red_walls_vertical_label_1:
            
            
            call remove_blue_red_walls_vertical
            mov [waiting_for_input], 1
            jmp left_collision_check
        
        remove_blue_red_walls_vertical_label_2:
            
            call remove_blue_red_walls_vertical
            mov [waiting_for_input], 1
            jmp move_the_ball_horizontal    
        
            
        

        
        vertical_ball:
        
        mov ah,0Dh
        mov bx, offset balls_x
        add bx, [current_level]
        add bx, [current_level]
        mov cx,[bx]
        mov bx, offset balls_y
        add bx, [current_level]
        add bx, [current_level]
        mov dx,[bx]
        add dx, [ballsize]
        inc dx
        mov bh, 0
        int 10H ; AL = COLOR
        
        cmp al, [color]
        je collision_on_bottom_void
        cmp al, [color_bottom_right_line]
        je remove_blue_red_walls_horizontal_label_1
        cmp al, [color_top_left_line]
        je remove_blue_red_walls_horizontal_label_1
        
        
        top_collision_check:
        mov ah,0Dh
        mov bx, offset balls_x
        add bx, [current_level]
        add bx, [current_level]
        mov cx,[bx]
        mov bx, offset balls_y
        add bx, [current_level]
        add bx, [current_level]
        mov dx,[bx]
        dec dx
        mov bh, 0
        int 10H ; AL = COLOR
       
       cmp al, [color]
        je collision_on_top_void
        cmp al, [color_bottom_right_line]
        je remove_blue_red_walls_horizontal_label_2
        cmp al, [color_top_left_line]
        je remove_blue_red_walls_horizontal_label_2
        
    
        
        move_the_ball_vertical:
        mov bx, offset balls_Yvelocity
        add bx, [current_level]
        add bx, [current_level]
        mov ax, [bx]
        mov bx, offset balls_y
        add bx, [current_level]
        add bx, [current_level]
        add [bx], ax
        
        jmp end_ball_movement
        
        
        collision_on_bottom_void:
            
            mov bx, offset balls_Yvelocity
            add bx, [current_level]
            add bx, [current_level]
            neg [word ptr bx]
            jmp move_the_ball_vertical
        collision_on_top_void:
            
            mov bx, offset balls_Yvelocity
            add bx, [current_level]
            add bx, [current_level]
            neg [word ptr bx]
            jmp move_the_ball_vertical
            
        
            remove_blue_red_walls_horizontal_label_1:
            
            call remove_blue_red_walls_horizontal
            mov [waiting_for_input], 1
            jmp top_collision_check
            
            remove_blue_red_walls_horizontal_label_2:
            
            call remove_blue_red_walls_horizontal
            mov [waiting_for_input], 1
            jmp move_the_ball_vertical
        
            
        
            
        
        end_ball_movement:
        mov ax,1h ; show mouse
        int 33h
        ret


    endp move_ball

    
    proc Delay
        mov cx,0FFFFh
        LoopLong:
        push cx
        mov cx, 1000
        LoopShort:
        loop LoopShort
        pop cx
        loop LoopLong
        ret
    endp Delay
    
    proc sound ; another proc just for convenience

        pop [ip_temp]
        ; open speaker
        in al, 61h
        or al, 00000011b
        out 61h, al
        ; send control word to change frequency
        mov al, 0B6h
        out 43h, al
        ; play frequency 131Hz
        pop [note]
        mov ax, [note]
        out 42h, al ; Sending lower byte
        mov al, ah
        out 42h, al ; Sending upper byte
        mov cx,0FFFFh
        LoopLong_sound1:
        push cx
        mov cx, 50
        LoopShort_sound1:
        loop LoopShort_sound1
        pop cx
        loop LoopLong_sound1
        
        
        ; close the speaker
        in al, 61h
        and al, 11111100b
        out 61h, al
        
        push [ip_temp]
        ret
        
    endp sound
    
    
    
    proc clear_ball_procedure
        
        mov ax, 02h ; hide the mouse
        int 33h
         mov bx, offset balls_x
         add bx, [current_level]
         add bx, [current_level]
         mov cx, [bx] ; set the column (ball_x)
          mov bx, offset balls_y
         add bx, [current_level]
         add bx, [current_level]
         mov dx, [bx] ; set the row (ball_y)
         clear_ball:
            mov ah, 0ch ; set the configuration to writing a pixel
            mov al, 8 ; choose red as color
            mov bh, 00h ; set the page number
            int 10h
            inc cx
            mov ax, cx
             mov bx, offset balls_x
            add bx, [current_level]
            add bx, [current_level]
            sub ax, [bx]
            cmp ax, [ballsize] ; check ball_x
            jng clear_ball ; jng = jump not greater
            mov bx, offset balls_x
            add bx, [current_level]
            add bx, [current_level]
            mov cx, [bx] ;initialization
            inc dx      ;initialization
            mov ax, dx
            mov bx, offset balls_y
            add bx, [current_level]
            add bx, [current_level]
            sub ax, [bx]
            cmp ax, [ballsize] ; check ball_y
            jng clear_ball ; jng = jump not greater
        
         
        ret
    endp clear_ball_procedure
    
    proc ball_speed_control ; speed control (number of calls)
    
        call move_ball
        call move_ball
        call move_ball
        ret
    endp ball_speed_control
    proc vertical_wall_speed_control ; because while we move the vertical wall we don't want to skip pixels we will duplicate the move_vertical_wall function to create speed
        
        call move_vertical_wall
        call move_vertical_wall
        call move_vertical_wall
        call move_vertical_wall
        call move_vertical_wall
        ret
    endp vertical_wall_speed_control
    
    proc horizontal_wall_speed_control ; because while we move the horizontal wall we don't want to skip pixels we will duplicate the move_horizontal_wall function to create speed
        
        call move_horizontal_wall
        call move_horizontal_wall
        call move_horizontal_wall
        call move_horizontal_wall
        call move_horizontal_wall
        ret
        
    endp horizontal_wall_speed_control
    
    proc move_horizontal_wall
        
        cmp [waiting_for_input], 0
        je move_right_wall_down
        ; --------------- INITIALIZATION ----------
        mov [wall_right_start_x] ,cx          
        mov [wall_right_start_y], dx
        
        mov [wall_right_x], cx
        mov [wall_right_y], dx
        
        mov [wall_left_start_x], cx
        mov [wall_left_start_y], dx
        
        mov [wall_left_x], cx
        mov [wall_left_y], dx
        
        mov [wall_horizontal_right_stopped], 0
        mov [wall_horizontal_left_stopped], 0
        
        mov [waiting_for_input], 0
        
        
        
        move_right_wall_down:

            inc [wall_right_x]
            mov cx, [wall_right_x]
            mov dx, [wall_right_y]
            mov bh, 0h 
            mov ah,0Dh
            int 10H ; AL = COLOR of pixel
            cmp al, [color] ; comparing to void
            je fix_right_wall_position
            jmp move_left_wall_up
            
            fix_right_wall_position:
                
                dec [wall_right_x]
                mov [wall_horizontal_right_stopped], 1
                jmp move_left_wall_up
        
        move_left_wall_up:
            
            dec [wall_left_x]
            mov cx, [wall_left_x]
            mov dx, [wall_left_y]
            mov bh, 0h 
            mov ah,0Dh
            int 10H ; AL = COLOR of pixel
            cmp al, [color] ; comparing to void
            je fix_left_wall_position
            jmp end_wall_movement_horizontal
            
            fix_left_wall_position:
                
                inc [wall_left_x]
                mov [wall_horizontal_left_stopped], 1
                jmp end_wall_movement_horizontal
                
        
        end_wall_movement_horizontal:
            
            
        ret
    endp
    
    proc move_vertical_wall ; moves by wall_velocity*5
    
        cmp [waiting_for_input], 0
        je move_bottom_wall_down
        ;---------------- INITIALIZATION -----------
        mov [wall_bottom_start_x], cx
        mov [wall_bottom_start_y], dx
        
        mov [wall_bottom_x], cx
        mov [wall_bottom_y], dx
        
        mov [wall_top_start_x], cx
        mov [wall_top_start_y], dx
        
        mov [wall_top_x], cx
        mov [wall_top_y], dx
        
        mov [wall_vertical_bottom_stopped], 0
        mov [wall_vertical_top_stopped], 0
        
        mov [waiting_for_input], 0
        
        move_bottom_wall_down:

            inc [wall_bottom_y]
            mov cx, [wall_bottom_x]
            mov dx, [wall_bottom_y]
            mov bh, 0h 
            mov ah,0Dh
            int 10H ; AL = COLOR of pixel
            cmp al, [color] ; comparing to void
            je fix_bottom_wall_position
            jmp move_top_wall_up
            
            fix_bottom_wall_position:
                
                dec [wall_bottom_y]
                mov [wall_vertical_bottom_stopped], 1
                jmp move_top_wall_up
                
                
        move_top_wall_up:
            
            dec [wall_top_y]
            mov cx, [wall_top_x]
            mov dx, [wall_top_y]
            mov bh, 0h 
            mov ah,0Dh
            int 10H ; AL = COLOR of pixel
            cmp al, [color] ; comparing to void
            je fix_top_wall_position
            jmp end_wall_movement_vertical
            
            fix_top_wall_position:
                
                inc [wall_top_y]
                mov [wall_vertical_top_stopped], 1
                jmp end_wall_movement_vertical
                
        
        end_wall_movement_vertical:
            
            
            ret
    endp move_vertical_wall
    
    proc draw_horizontal_wall
            
            push [note_wall]
            call sound
            
            mov cx, [wall_left_start_x]
            mov dx, [wall_left_start_y]
            mov [right_is_void], 0
            mov [left_is_void], 0

            draw_left_wall:
                
                mov ah, 0ch ; set the configuration to writing a pixel
                mov al, [color_top_left_line] ; choose red as color
                mov bh, 00h ; set the page number
                int 10h
                dec cx ; cx = cx - 1
                
                cmp cx, [wall_left_x]
                jnl draw_left_wall ; jng = jump not greater
                
                mov cx, [wall_left_start_x] ;initialization
                inc dx      ;initialization
                
    
                mov ax, dx
                sub ax, [wall_left_start_y]
                cmp ax, [wall_chunk_size] ; check ball_y
                
    
    
                jng draw_left_wall ; jng = jump not greater
                
                cmp [wall_horizontal_left_stopped], 0
                jne draw_void_walls_left
                
            
            continue_drawing_horizontal: ; to return if void pixels are needed
            
            mov cx, [wall_right_start_x]
            mov dx, [wall_right_start_y]
            
            draw_right_wall:
                
                mov ah, 0ch ; set the configuration to writing a pixel
                mov al, [color_bottom_right_line] ; choose red as color
                mov bh, 00h ; set the page number
                int 10h
                inc cx ; cx = cx + 1
                
                cmp cx, [wall_right_x]
                jng draw_right_wall ; jng = jump not greater
                
                mov cx, [wall_right_start_x] ;initialization
                inc dx      ;initialization
                
    
                mov ax, dx
                sub ax, [wall_right_start_y]
                cmp ax, [wall_chunk_size] ; check ball_y
                

    
                jng draw_right_wall ; jng = jump not greater
                
                cmp [wall_horizontal_right_stopped], 0
                jne draw_void_walls_right
                
                
                
                jmp end_wall_drawing_horizontal
            
            draw_void_walls_right:
                mov cx, [wall_right_start_x]
                mov dx, [wall_right_start_y]
                
                draw_void_walls_right_loop:
                    mov ah, 0ch ; set the configuration to writing a pixel
                    mov al, [color] ; choose void as color
                    mov bh, 00h ; set the page number
                    int 10h
                    inc cx ; cx = cx + 1
                    
                    cmp cx, [wall_right_x]
                    jng draw_void_walls_right_loop ; jng = jump not greater
                    
                    mov cx, [wall_right_start_x] ;initialization
                    inc dx      ;initialization
                    
             
                    
                    mov ax, dx
                    sub ax, [wall_right_start_y]
                    cmp ax, [wall_chunk_size] ; check ball_y
                    
        
        
                    jng draw_void_walls_right_loop ; jng = jump not greater
                    mov [right_is_void], 1
                    jmp end_wall_drawing_horizontal
                
            draw_void_walls_left:
                
                mov cx, [wall_left_start_x]
                mov dx, [wall_left_start_y]
                
                draw_void_walls_left_loop:
                    
                    mov ah, 0ch ; set the configuration to writing a pixel
                    mov al, [color] ; choose red as color
                    mov bh, 00h ; set the page number
                    int 10h
                    dec cx ; cx = cx + 1
                    
                    cmp cx, [wall_left_x]
                    jnl draw_void_walls_left_loop ; jng = jump not greater
                    
                    mov [left_x_collision], cx
                    inc [left_x_collision]
                    mov cx, [wall_left_start_x] ;initialization
                    inc dx      ;initialization
                    
           
                    
                    mov ax, dx
                    sub ax, [wall_left_start_y]
                    cmp ax, [wall_chunk_size] ; check ball_y
                    
       
        
                    jng draw_void_walls_left_loop ; jng = jump not greater
                    
                    
                    mov [left_is_void], 1
                    jmp continue_drawing_horizontal
                    
            

        end_wall_drawing_horizontal:
        
            cmp [left_is_void], 0
            je absolute_end_horizontal
            cmp [right_is_void], 0
            je absolute_end_horizontal
            call draw_void_area_horizontal
                    
            absolute_end_horizontal:    
                    
                ret
    endp draw_horizontal_wall
    
    
    proc draw_vertical_wall
        
            push [note_wall]
            call sound
            
            mov cx, [wall_top_start_x]
            mov dx, [wall_top_start_y]
            
            mov [top_is_void], 0
            mov [bottom_is_void], 0
            
            draw_top_wall:
               
                
                mov ah, 0ch ; set the configuration to writing a pixel
                mov al, [color_top_left_line] ; choose red as color
                mov bh, 00h ; set the page number
                int 10h
                inc cx ; cx = cx + 1
                mov ax, cx 
                sub ax, [wall_top_x]
                cmp ax, [wall_chunk_size]
                jng draw_top_wall ; jng = jump not greater
                
                mov cx, [wall_top_start_x] ;initialization
                dec dx      ;initialization
                
   
            
                cmp dx, [wall_top_y] ; check ball_y
                
    
    
                jnl draw_top_wall ; jng = jump not greater
                
                cmp [wall_vertical_top_stopped], 0
                jne draw_void_walls_top
            
            continue_drawing_vertical: ; to return if void pixels are needed
            
            mov cx, [wall_bottom_start_x]
            mov dx, [wall_bottom_start_y]
            
            draw_bottom_wall:
               
                
                mov ah, 0ch ; set the configuration to writing a pixel
                mov al, [color_bottom_right_line] ; choose red as color
                mov bh, 00h ; set the page number
                int 10h
                inc cx ; cx = cx + 1
                mov ax, cx 
                sub ax, [wall_bottom_x]
                cmp ax, [wall_chunk_size]
                jng draw_bottom_wall ; jng = jump not greater
                
                mov cx, [wall_bottom_start_x] ;initialization
                inc dx      ;initialization
                
              
                
                cmp dx, [wall_bottom_y] ; check ball_y
                
                jng draw_bottom_wall ; jng = jump not greater
                
                cmp [wall_vertical_bottom_stopped], 0
                jne draw_void_walls_bottom
                
                
                jmp end_wall_drawing_vertical
            
            draw_void_walls_bottom:
            
                mov cx, [wall_bottom_start_x]
                mov dx, [wall_bottom_start_y]
                
                draw_void_walls_bottom_loop:
                    mov ah, 0ch ; set the configuration to writing a pixel
                    mov al, [color] ; choose void as color
                    mov bh, 00h ; set the page number
                    int 10h
                    inc cx ; cx = cx + 1
                    mov ax, cx 
                    sub ax, [wall_bottom_x]
                    cmp ax, [wall_chunk_size]
                    jng draw_void_walls_bottom_loop ; jng = jump not greater
                    
                    mov cx, [wall_bottom_start_x] ;initialization
                    inc dx      ;initialization
                    
                 
                    
                    cmp dx, [wall_bottom_y] ; check ball_y
                    
    
        
                    jng draw_void_walls_bottom_loop ; jng = jump not greater
                    mov [bottom_is_void], 1
                    jmp end_wall_drawing_vertical
                
                
            draw_void_walls_top:
                
                mov cx, [wall_top_start_x]
                mov dx, [wall_top_start_y]
                
                draw_void_walls_top_loop:
                    
                    mov ah, 0ch ; set the configuration to writing a pixel
                    mov al, [color] ; choose red as color
                    mov bh, 00h ; set the page number
                    int 10h
                    inc cx ; cx = cx + 1
                    mov ax, cx 
                    sub ax, [wall_top_x]
                    cmp ax, [wall_chunk_size]
                    jng draw_void_walls_top_loop ; jng = jump not greater
                    
                    mov cx, [wall_top_start_x] ;initialization
                    dec dx      ;initialization
                    
          
                
                    cmp dx, [wall_top_y] ; check ball_y
        
                    jnl draw_void_walls_top_loop ; jng = jump not greater
                    mov [top_y_collision], dx
                    inc [top_y_collision]
                    
                    mov [top_is_void], 1
                    jmp continue_drawing_vertical

    end_wall_drawing_vertical:  
            
        
            cmp [top_is_void], 0
            je absolute_end_vertical
            cmp [bottom_is_void], 0
            je absolute_end_vertical
            call draw_void_area_vertical
            
           
            absolute_end_vertical:  
                    
                ret     
            ret
    endp draw_vertical_wall
        
    
    proc draw_void_area_vertical
    
    mov cx, [wall_top_start_x]
    mov dx, [top_y_collision]
        
        check_for_balls_left: ; can use simplification 
            dec cx
            mov ah,0Dh
            int 10H ; AL = COLOR
            cmp al, [color_ball]
            je check_for_balls_right_initialization
            cmp al, [color]
            jne check_for_balls_left
            mov cx, [wall_top_start_x]
            dec cx
            inc dx
            mov ah,0Dh
            int 10H ; AL = COLOR
            cmp al, [color]
            jne check_for_balls_left
            jmp fill_area_left_void_initialization
            
        
        check_for_balls_right_initialization:
            mov cx, [wall_top_start_x]
            mov dx, [top_y_collision]
            add cx, [wall_chunk_size]
        check_for_balls_right: ; can use simplification
            inc cx
            mov ah,0Dh
            int 10H ; AL = COLOR
            cmp al, [color_ball]
            je end_draw_void_areas_vertical
            cmp al, [color]
            jne check_for_balls_right
            mov cx, [wall_top_start_x]
            add cx, [wall_chunk_size]
            inc cx
            inc dx
            mov ah,0Dh
            int 10H ; AL = COLOR
            cmp al, [color]
            jne check_for_balls_right
            jmp fill_area_right_void_initialization
            
        fill_area_left_void_initialization:
            mov cx, [wall_top_start_x]
            mov dx, [top_y_collision]
            
            fill_area_left_void:
                
                mov ah, 0Ch
                mov al, [color]
                int 10h
                dec cx
                mov ah, 0Dh
                int 10h
                cmp al, [color]
                jne fill_area_left_void
                mov cx, [wall_top_start_x]
                dec cx
                inc dx
                int 10h
                cmp al, [color]
                jne fill_area_left_void
                jmp end_draw_void_areas_vertical
                
            
            
        fill_area_right_void_initialization:
            mov cx, [wall_top_start_x]
            add cx, [wall_chunk_size]
            mov dx, [top_y_collision]
            fill_area_right_void:
                mov ah, 0Ch
                mov al, [color]
                int 10h
                inc cx
                mov ah, 0Dh
                int 10h
                cmp al, [color]
                jne fill_area_right_void
                mov cx, [wall_top_start_x]
                add cx, [wall_chunk_size]
                inc cx
                inc dx
                int 10h
                cmp al, [color]
                jne fill_area_right_void
                jmp end_draw_void_areas_vertical
            
            
    
    
    end_draw_void_areas_vertical:   
    ret
    
    endp draw_void_area_vertical
    
    proc draw_void_area_horizontal
        
        mov cx, [left_x_collision]
        mov dx, [wall_left_start_y]
        
        check_for_balls_top: ; can use simplification 
            dec dx
            mov ah,0Dh
            int 10H ; AL = COLOR
            cmp al, [color_ball]
            je check_for_balls_bottom_initialization
            cmp al, [color]
            jne check_for_balls_top
            mov dx, [wall_left_start_y]
            inc cx
            dec dx
            mov ah,0Dh
            int 10H ; AL = COLOR
            cmp al, [color]
            jne check_for_balls_top
            jmp fill_area_top_void_initialization
            
        check_for_balls_bottom_initialization:
            mov cx, [left_x_collision]
            mov dx, [wall_left_start_y]
            add dx, [wall_chunk_size]
        check_for_balls_bottom: ; can use simplification
            inc dx
            mov ah,0Dh
            int 10H ; AL = COLOR
            cmp al, [color_ball]
            je end_draw_void_areas_horizontal
            cmp al, [color]
            jne check_for_balls_bottom
            mov dx, [wall_left_start_y]
            add dx, [wall_chunk_size]
            inc cx
            inc dx
            mov ah,0Dh
            int 10H ; AL = COLOR
            cmp al, [color]
            jne check_for_balls_bottom
            jmp fill_area_bottom_void_initialization
            
        fill_area_top_void_initialization:
            mov cx, [left_x_collision]
            mov dx, [wall_left_start_y]
            
            fill_area_top_void:
                
                mov ah, 0Ch
                mov al, [color]
                int 10h
                dec dx
                mov ah, 0Dh
                int 10h
                cmp al, [color]
                jne fill_area_top_void
                mov dx, [wall_left_start_y]
                inc cx
                dec dx
                int 10h
                cmp al, [color]
                jne fill_area_top_void
                jmp end_draw_void_areas_horizontal
                
        fill_area_bottom_void_initialization:
            mov cx, [left_x_collision]
            mov dx, [wall_left_start_y]
            add dx, [wall_chunk_size]
            fill_area_bottom_void:
                mov ah, 0Ch
                mov al, [color]
                mov bh, 0
                int 10h
                inc dx
                mov ah, 0Dh
                mov bh, 0
                int 10h
                cmp al, [color]
                jne fill_area_bottom_void
                mov dx, [wall_left_start_y]
                add dx, [wall_chunk_size]
                inc cx
                inc dx
                mov bh, 0
                int 10h
                cmp al, [color]
                jne fill_area_bottom_void
                jmp end_draw_void_areas_horizontal
                
        
        
        end_draw_void_areas_horizontal:
        ret
    endp draw_void_area_horizontal
    

    proc remove_blue_red_walls_vertical
        
        push [note_collision]
        call sound
        
        call deduct_lives
        
        mov cx, [wall_top_x]
        
        mov dx, [wall_top_y]
        
        
        remove_blue_red_walls_vertical_loop:
            mov al, 8
            mov ah, 0ch
            mov bh, 0
            int 10h
            inc cx
            mov ax, cx
            sub ax, [wall_top_x]
            cmp ax, [wall_chunk_size]
            jng remove_blue_red_walls_vertical_loop
            mov cx, [wall_top_x]
            inc dx
            cmp dx, [wall_bottom_y]
            jng remove_blue_red_walls_vertical_loop
            
        ret
    endp remove_blue_red_walls_vertical
    
    proc remove_blue_red_walls_horizontal
        
        push [note_collision]
        call sound
        
        call deduct_lives
        
        mov cx, [wall_left_x]
        
        mov dx, [wall_left_y]
        
        
        remove_blue_red_walls_horizontal_loop:
            mov al, 8
            mov ah, 0ch
            mov bh, 0
            int 10h
            inc dx
            mov ax, dx
            sub ax, [wall_left_y]
            cmp ax, [wall_chunk_size]
            jng remove_blue_red_walls_horizontal_loop
            mov dx, [wall_left_y]
            inc cx
            cmp cx, [wall_right_x]
            jng remove_blue_red_walls_horizontal_loop
            
        
        ret
    endp remove_blue_red_walls_horizontal
    
    proc check_if_won
        mov [void_pixels_counter], 0
        mov cx, [line_width_vertical]
        mov dx, [line_width_horizontal]
        inc dx
        
        count_void_pixels:
            inc cx
            cmp cx, 305
            jl check_for_void_pixel
            
            mov cx, [line_width_vertical]
            inc dx
            cmp dx, 175
            jl count_void_pixels
            cmp [void_pixels_counter], 21750 ; 50%
            jg message_almost_there
            cmp [void_pixels_counter], 13050 ; 50%
            jg message_keep_going
            cmp [void_pixels_counter], 4350 ; 10%
            jg message_getting_started
            jmp message_get_good
            
            message_almost_there:
                
                mov [mid_game_message_sign], 1
                ret
            message_keep_going:
                mov [mid_game_message_sign], 2
                ret
            message_getting_started:
                mov [mid_game_message_sign], 3
                ret
            message_get_good:
                mov [mid_game_message_sign], 4
                ret
                
        check_for_void_pixel:
            mov ah, 0dh
            mov bh, 0
            int 10h
            cmp al, [color]
            jne count_void_pixels
            jmp update_counter
            
            update_counter: ; change ax to constant
                inc [void_pixels_counter]
                cmp [void_pixels_counter], 28275
                jl count_void_pixels
                mov [won], 1
                jmp count_void_pixels
                
        
        ret
    endp check_if_won
    
    
    
    proc update_ui_text_proc

        ; MID GAME MESSAGE
        
        mov ah, 02h     ; set cursor position
        mov bh, 00h     ; set page number
        mov dh, 02h     ; set row
        mov dl, 0Fh     ; set column
        int 10h
        
        mov ah, 09h     ; write string to standard output
        
        cmp [mid_game_message_sign], 1
        je print_almost_there
        
        cmp [mid_game_message_sign], 2
        je print_keep_going
        
        cmp [mid_game_message_sign], 3
        je print_getting_started
        
        cmp [mid_game_message_sign], 4
        je print_get_good
        
        print_almost_there:
        lea dx, [almost_there] ; (load effective adress) just like mov but can calculate and doesn't adress memory
        int 21h     ; print the string
        jmp lives_label
        
        print_keep_going:
        lea dx, [keep_going] ; (load effective adress) just like mov but can calculate and doesn't adress memory
        int 21h     ; print the string
        jmp lives_label
        
        print_getting_started:
        lea dx, [getting_started] ; (load effective adress) just like mov but can calculate and doesn't adress memory
        int 21h     ; print the string
        jmp lives_label
        
        print_get_good:
        lea dx, [get_good] ; (load effective adress) just like mov but can calculate and doesn't adress memory
        int 21h     ; print the string
        jmp lives_label
        
        ; LIVES
        lives_label:
        mov ah, 02h     ; set cursor position
        mov bh, 00h     ; set page number
        mov dh, 02h     ; set row
        mov dl, 32      ; set column
        int 10h
        
        mov ah, 09h     ; write string to standard output
        
        lea dx, [lives_text_word] ; (load effective adress) just like mov but can calculate and doesn't adress memory
        
        int 21h     ; print the string

        mov ah, 02h     ; set cursor position
        mov bh, 00h     ; set page number
        mov dh, 02h     ; set row
        mov dl, 30  ; set column
        int 10h
        
        mov ah, 09h     ; write string to standard output
        mov al, [lives]
        add al, 30h
        mov [lives_text], al
        lea dx, [lives_text] ; (load effective adress) just like mov but can calculate and doesn't adress memory
        
        int 21h     ; print the string
        
        ; TIME LEFT
        
        mov ah, 02h     ; set cursor position
        mov bh, 00h     ; set page number
        mov dh, 02h     ; set row
        mov dl, 13  ; set column
        int 10h
        
        mov ah, 09h     ; write string to standard output
        mov al, [time_left_right]
        add al, 30h
        mov [time_left_right_text], al
        lea dx, [time_left_right_text] ; (load effective adress) just like mov but can calculate and doesn't adress memory
        
        int 21h     ; print the string
        
        mov ah, 02h     ; set cursor position
        mov bh, 00h     ; set page number
        mov dh, 02h     ; set row
        mov dl, 12  ; set column
        int 10h
        
        mov ah, 09h     ; write string to standard output
        mov al, [time_left_middle]
        add al, 30h
        mov [time_left_middle_text], al
        lea dx, [time_left_middle_text] ; (load effective adress) just like mov but can calculate and doesn't adress memory
        
        int 21h     ; print the string
        
        mov ah, 02h     ; set cursor position
        mov bh, 00h     ; set page number
        mov dh, 02h     ; set row
        mov dl, 11  ; set column
        int 10h
        
        mov ah, 09h     ; write string to standard output
        mov al, [time_left_left]
        add al, 30h
        mov [time_left_left_text], al
        lea dx, [time_left_left_text] ; (load effective adress) just like mov but can calculate and doesn't adress memory
        
        int 21h     ; print the string
        
        mov ah, 02h     ; set cursor position
        mov bh, 00h     ; set page number
        mov dh, 02h     ; set row
        mov dl, 1h      ; set column
        int 10h
        
        mov ah, 09h
        
        lea dx, [time_left_text_ui] ; (load effective adress) just like mov but can calculate and doesn't adress memory
        
        int 21h
        ; AREA TARGET
        mov ah, 02h     ; set cursor position
        mov bh, 00h     ; set page number
        mov dh, 253 ; set row
        mov dl, 140 ; set column
        int 10h
        
        mov ah, 09h     ; write string to standard output
        
        lea dx, [target_area_captured] ; (load effective adress) just like mov but can calculate and doesn't adress memory
        
        int 21h     ; print the string
        
        
        ret
    endp update_ui_text_proc
    
    
    proc deduct_lives
        
        dec [lives]
        cmp [lives], 0
        jng end_menu_loser_label
        ret
        
        end_menu_loser_label:
            call end_menu_loser
            
    endp deduct_lives
    
    proc won_menu ; won menu
        
        lea dx, [won_menu_file]
        mov [BmpColSize], 320d
        mov [BmpRowSize], 200d
        mov [BmpTop], 0
        mov [BmpLeft], 0
        
        call Print_final
        wait_for_keyboard_input_won_menu:
            
            mov ah, 01h
            int 16h ;read one key from the user
            
            cmp al, 109 ; m
            je main_menu_label_from_won
            
            cmp al, 77 ; M
            je main_menu_label_from_won
            
            cmp al, 116 ;t
            je terminate_game
            
            cmp al, 84 ; T
            je terminate_game
            
            jmp wait_for_keyboard_input_won_menu
            
            main_menu_label_from_won:   
                call main_menu_proc
            
        ret
    endp won_menu
    
    proc end_menu_loser ; end menu
        
        mov ah, 02h
        int 33h
        
        mov [level_text_number], 1
        
        mov [time_left_right], 0
        mov [time_left_middle], 0
        mov [time_left_left], 6
        
        lea dx, [loser_end_menu]
        mov [BmpColSize], 320d
        mov [BmpRowSize], 200d
        mov [BmpTop], 0
        mov [BmpLeft], 0
        
        call Print_final
        
        wait_for_keyboard_input_end_menu:
            
            call Print_final
            call print_line_end_menu
            mov ah, 0
            int 16h ;read one key from the user

            cmp ah, 72 ;up arrow
            je up_move

            cmp ah, 80 ;down arrow
            je down_move

            cmp ah, 28 ; enter
            je selected 

            jmp wait_for_keyboard_input_end_menu
        up_move:
            push [key_press]
            call sound
            cmp [line_cory], 140
            je up_down
            sub [line_cory], 28
            jmp wait_for_keyboard_input_end_menu
        down_move:
            push [key_press]
            call sound
            cmp [line_cory], 196
            je down_up
            add [line_cory], 28
            jmp wait_for_keyboard_input_end_menu
        up_down:
            add [line_cory], 56
            jmp wait_for_keyboard_input_end_menu
        down_up:
            sub [line_cory], 56
            jmp wait_for_keyboard_input_end_menu
        selected:
            mov [current_level], 0
            mov [max_level], -1
            cmp [line_cory], 140
            je update_level

            cmp [line_cory], 168
            je main_menu_label

            cmp [line_cory], 196
            je terminate_game
        pop dx
        ret
            jmp wait_for_keyboard_input_end_menu
            
            main_menu_label:
                call main_menu_proc
        
        
    endp end_menu_loser 
    
    proc how_menu_proc ; how to play
        
        mov bx, offset level_cleared
        push [word ptr bx]
        call sound
        add bx, 2
        push [word ptr bx]
        call sound
        add bx, 2
        push [word ptr bx]
        call sound
        
        
        lea dx, [how_menu]
        mov [BmpColSize], 320d
        mov [BmpRowSize], 200d
        mov [BmpTop], 0
        mov [BmpLeft], 0
        
        call Print_final
        
        
        wait_for_keyboard_input_how_menu:
            
            mov ah, 02h     ; set cursor position
            mov bh, 00h     ; set page number
            mov dh, 02h     ; set row
            mov dl, 12      ; set column
            int 10h
            
            mov ah, 09h     ; write string to standard output
            
            lea dx, [esc_key] ; (load effective adress) just like mov but can calculate and doesn't adress memory
            
            int 21h     ; print the string
        
            
            mov ah, 0
            int 16h ;read one key from the user

            cmp al, 1bh
            je main_menu_label
            jmp wait_for_keyboard_input_how_menu
    endp how_menu_proc
    
    proc main_menu_proc ; main menu
        
        mov ax, 02
        int 33h
        
        mov [line_corx], 100
        mov [line_cory], 140
        mov [line_color], 15
        lea dx, [main_menu]
        mov [BmpColSize], 320d
        mov [BmpRowSize], 200d
        mov [BmpTop], 0
        mov [BmpLeft], 0
        
        call Print_final
        
        wait_for_keyboard_input_main_menu:
            
            call Print_final
            call print_line_end_menu
            mov ah, 0
            int 16h ;read one key from the user

            cmp ah, 72 
            je up_move_main

            cmp ah, 80
            je down_move_main

            cmp ah, 28
            je selected_main 

            jmp wait_for_keyboard_input_main_menu
        up_move_main:
            push [key_press]
            call sound
            cmp [line_cory], 140
            je up_down_main
            sub [line_cory], 28
            jmp wait_for_keyboard_input_main_menu
        down_move_main:
            push [key_press]
            call sound
            cmp [line_cory], 196
            je down_up_main
            add [line_cory], 28
            jmp wait_for_keyboard_input_main_menu
        up_down_main:
            add [line_cory], 56
            jmp wait_for_keyboard_input_main_menu
        down_up_main:
            sub [line_cory], 56
            jmp wait_for_keyboard_input_main_menu
        selected_main:
            
            mov [current_level], 0
            mov [max_level], -1
            cmp [line_cory], 140
            je update_level

            cmp [line_cory], 168
            je how_menu_label

            cmp [line_cory], 196
            je terminate_game
        pop dx
        ret
            jmp wait_for_keyboard_input_main_menu
            
            how_menu_label:
            call how_menu_proc
        
        ret
    endp main_menu_proc
    
  
    PROC print_line_end_menu
        push cx
        push ax
        bloop:
            call pixel_line_end_menu
            inc [line_corx]
            cmp [line_corx], 220
            jne bloop
        inc [line_cory] 
        dec [line_corx]
        cloop:
            call pixel_line_end_menu
            dec [line_corx]
            cmp [line_corx], 98
            jne cloop
        exit_p:
        dec [line_cory]
        pop ax
        pop cx
        ret
    ENDP print_line_end_menu

    proc pixel_line_end_menu
        push bx 
        push cx 
        push dx

        mov bh,0h 
        mov cx, [line_corx]
        mov dx, [line_cory]
        mov al, [line_color]
        mov ah, 0ch
        int 10h 

        pop dx
        pop cx
        pop bx
        ret
    endp pixel_line_end_menu
    
    


  ; input :
;   1.BmpLeft offset from left (where to start draw the picture) 
;   2. BmpTop offset from top
;   3. BmpColSize picture width , 
;   4. BmpRowSize bmp height 
;   5. dx offset to file name with zero at the end 
    proc OpenShowBmp
        push cx
        push bx


        call OpenBmpFile
        cmp [ErrorFile],1
        je @@ExitProc


        call ReadBmpHeader

        ; from  here assume bx is global param with file handle. 
        call ReadBmpPalette

        call CopyBmpPalette

        call ShowBMP


        call CloseBmpFile

    @@ExitProc:
        pop bx
        pop cx
        ret
    endp OpenShowBmp

    ; input dx filename to open
    proc OpenBmpFile    near                         
        mov ah, 3Dh
        xor al, al
        int 21h
        jc @@ErrorAtOpen
        mov [FileHandle], ax
        jmp @@ExitProc

    @@ErrorAtOpen:
        mov [ErrorFile],1
    @@ExitProc: 
        ret
    endp OpenBmpFile


    proc CloseBmpFile near
        mov ah,3Eh
        mov bx, [FileHandle]
        int 21h
        ret
    endp CloseBmpFile




    ; Read 54 bytes the Header
    proc ReadBmpHeader  near                    
        push cx
        push dx

        mov ah,3fh
        mov bx, [FileHandle]
        mov cx,54
        mov dx,offset Header
        int 21h

        pop dx
        pop cx
        ret
    endp ReadBmpHeader



    proc ReadBmpPalette near ; Read BMP file color palette, 256 colors * 4 bytes (400h)
                             ; 4 bytes for each color BGR + null)           
        push cx
        push dx

        mov ah,3fh
        mov cx,400h
        mov dx,offset Palette
        int 21h

        pop dx
        pop cx

        ret
    endp ReadBmpPalette


    ; Will move out to screen memory the colors
    ; video ports are 3C8h for number of first color
    ; and 3C9h for all rest
    proc CopyBmpPalette     near                    

        push cx
        push dx

        mov si,offset Palette
        mov cx,256
        mov dx,3C8h
        mov al,0  ; black first                         
        out dx,al ;3C8h
        inc dx    ;3C9h
    CopyNextColor:
        mov al,[si+2]       ; Red               
        shr al,2            ; divide by 4 Max (cos max is 63 and we have here max 255 ) (loosing color resolution).             
        out dx,al                       
        mov al,[si+1]       ; Green.                
        shr al,2            
        out dx,al                           
        mov al,[si]         ; Blue.             
        shr al,2            
        out dx,al                           
        add si,4            ; Point to next color.  (4 bytes for each color BGR + null)             

        loop CopyNextColor

        pop dx
        pop cx

        ret
    endp CopyBmpPalette


    proc ShowBMP 
    ; BMP graphics are saved upside-down.
    ; Read the graphic line by line (BmpRowSize lines in VGA format),
    ; displaying the lines from bottom to top.
        push cx

        mov ax, 0A000h
        mov es, ax

        mov cx,[BmpRowSize]

        mov ax,[BmpColSize] ; row size must dived by 4 so if it less we must calculate the extra padding bytes
        xor dx,dx
        mov si,4
        div si
        mov bp,dx

        mov dx,[BmpLeft]

    @@NextLine:
        push cx
        push dx

        mov di,cx  ; Current Row at the small bmp (each time -1)
        add di,[BmpTop] ; add the Y on entire screen


        ; next 5 lines  di will be  = cx*320 + dx , point to the correct screen line
        mov cx,di
        shl cx,6
        shl di,8
        add di,cx
        add di,dx

        ; small Read one line
        mov ah,3fh
        mov cx,[BmpColSize]  
        add cx,bp  ; extra  bytes to each row must be divided by 4
        mov dx,offset ScreenLineMax
        int 21h
        ; Copy one line into video memory
        cld ; Clear direction flag, for movsb
        mov cx,[BmpColSize]  
        mov si,offset ScreenLineMax
        rep movsb ; Copy line to the screen

        pop dx
        pop cx

        loop @@NextLine

        pop cx
        ret
    endp ShowBMP 

    proc Print_final
        push dx
        

        call OpenShowBmp
        
        pop dx
        ret
    endp Print_final
    
    proc clear_screen
    
        mov ax, 13h
        int 10h   
        
        mov ah, 0Bh ; set the configuration
        mov bh, 0 ; to the background color
        mov bl, 08h ; choose black
        int 10h
        ret
    endp clear_screen
    
    proc terminate_game ; go to text mode
    
        mov ah, 00h
        mov al, 00h
        int 10h
        
        mov ah, 4ch
        int 21h
        ret
    endp terminate_game
    
exit:
    mov ax, 4c00h
    int 21h
END start