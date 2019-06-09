


				AREA	routines, CODE, READONLY, ALIGN=2
				THUMB
				EXPORT CONVRT
				EXTERN OutStr
								
CONVRT		PROC
			PUSH {R0-R6}
			STR R4,[R0]
			LDR R6,[R0]
			MOV R0,#0
			MOV R1,#0
			MOV R2,#10
			MOV R3,#0
						
digit
			UDIV R6, R6, R2
			ADD  R0, #1			;counter for digit number
			ADD  R3, #1			;counter for 
			CMP  R6, #0
			BNE  digit
			B    getnum
			
getnum
			UDIV R1, R4, R2  ;divide by 10
			MUL R1, R2  ;multiply by 10
			SUB R1, R4, R1   ;subract from original number
			ADD R1, #0x30	;convert to ASCII
			SUB  R0, #1
			STRB R1,[R5,R0]  ;store it in correct order
			UDIV R4, R2		;divide by 10 to get rid of hanging zero
			CMP R4,#0     ; CMP to check any digits left
			BNE getnum				
			ADD R5, R3
			MOV R2, #0x04
			MOV R3, #0x0D
			MOV R6, #0
			STRB R3,[R5],#1
			STRB R2,[R5]
			POP {R0-R6}
			BX LR
			
			ALIGN
			ENDP
			END
					