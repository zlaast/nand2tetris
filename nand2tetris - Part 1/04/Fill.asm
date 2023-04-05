// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.


(INIT)          // i = 8191
    @8191
    D=A
    @i
    M=D         

(CHECK)         // Check if key is pressed
    @KBD
    D=M

    @FILL
    D;JGT       // Go to FILL if any key is being pressed (KBD>0)...

    @CLEAR      // ...else go to CLEAR
    0;JMP

(FILL)          // Fill screen
    @SCREEN
    D=A
    @i
    A=D+M       // Go to address SCREEN+i

    M=-1        // Fill the 16-bit chunk with pixels

    @i
    M=M-1
    D=M         // i=i-1 (we're filling the screen from bottom up)
    
    @INIT
    D;JLT       // If i<0, then screen is filled. Go back to INIT to reset i...
    
    @FILL       // ...else keep filling
    0;JMP
    
(CLEAR)         // Clear screen
    @SCREEN
    D=A
    @i
    A=D+M

    M=0

    @i
    M=M-1
    D=M
    
    @INIT
    D;JLT

    @CLEAR
    0;JMP