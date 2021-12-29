.text
.global _start
_start:
LDR r1, =LIST
LDR r2, [r1]
MOV r3,#0 
LDR SP ,=0x3FFFFFFC

SUB r5, r2, #1 


LOOP:
    CMP r3, r5
    BGE END
    MOV r6, #0 
    SUB r9, r5, r3 
	MOV r4, #4
    SUBLOOP:
    
        CMP r6, r9
        BGE ENDSUBLOOP
        ADD r0,r1, r4
		
        //ADD r10, r4, #4 
        //LDR r8, [r1, r10]
        //CMP r7, r8
        //BLE NOSWAP
	
        BL SWAP
		
        //NOSWAP:
        ADD r6, r6, #1    
        ADD r4, r4, #4
        B SUBLOOP
    ENDSUBLOOP:
    	ADD r3, r3, #1
    	B LOOP
    
END: B END
    
//LIST:    .word 10, 1400, 45, 23, 5, 3, 8, 17, 4, 20, 33 

.global SWAP
SWAP:
	
	PUSH {r2,r3,LR}
	LDR r3, [r0, #4]
	LDR r2, [r0]
	CMP r2, r3
	BLE NOSWAP
    	STR r3, [r0]
		
    	STR r2, [r0, #4]
		MOV r0, #1
		B ENDSWAP
	NOSWAP:
		MOV r0, #0
    	B ENDSWAP
ENDSWAP:
		POP {r2, r3,PC}
