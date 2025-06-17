; Zero Page
ORG     &00
GUARD   &ff

.RUPTURE_COUNTER    skip 1
.FRAME_COUNTER      skip 1

; Register temporary storage
.TEMP_A skip 1
.TEMP_X skip 1
.TEMP_Y skip 1

.TEMP_A2 skip 1
.TEMP_X2 skip 1
.TEMP_Y2 skip 1

; 16-bit temporary storage
.TEMP_1_LO skip 1
.TEMP_1_HI skip 1
.TEMP_2_LO skip 1
.TEMP_2_HI skip 1
.TEMP_3_LO skip 1
.TEMP_3_HI skip 1

TEMP_1 = TEMP_1_LO
TEMP_2 = TEMP_2_LO
TEMP_3 = TEMP_3_LO

; Memory address temporary storage
.TEMP_ADDR_1_LO skip 1
.TEMP_ADDR_1_HI skip 1
.TEMP_ADDR_2_LO skip 1
.TEMP_ADDR_2_HI skip 1
.TEMP_ADDR_3_LO skip 1
.TEMP_ADDR_3_HI skip 1

TEMP_ADDR_1 = TEMP_ADDR_1_LO
TEMP_ADDR_2 = TEMP_ADDR_2_LO
TEMP_ADDR_3 = TEMP_ADDR_3_LO
