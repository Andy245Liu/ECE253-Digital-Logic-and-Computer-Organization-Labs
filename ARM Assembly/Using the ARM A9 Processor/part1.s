.text
.global _start
_start:
LDR r1, =TEST_NUM
MOV r7,#0
MOV r8,#0
MOV r2,#0

while:
    LDR r4,[r1, r2] 
    CMP r4, #-1
    BEQ endwhile

        ADD r7, r4, r7    
        ADD r2, r2, #4
        ADD r8, r8, #1
        //BEQ[R1,R2],#-1,LOOP
        B while
endwhile:





END: B END

.end