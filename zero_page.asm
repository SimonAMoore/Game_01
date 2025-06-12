; Zero Page
ORG &70
GUARD &9F

.TEMP_1_LO        skip 1
.TEMP_1_HI        skip 1
.TEMP_2_LO        skip 1
.TEMP_2_HI        skip 1

TEMP_1 = TEMP_1_LO
TEMP_2 = TEMP_2_LO

.TEMP_ADDR_1_LO   skip 1
.TEMP_ADDR_1_HI   skip 1
.TEMP_ADDR_2_LO   skip 1
.TEMP_ADDR_2_HI   skip 1
.TEMP_ADDR_3_LO   skip 1
.TEMP_ADDR_3_HI   skip 1

TEMP_ADDR_1 = TEMP_ADDR_1_LO
TEMP_ADDR_2 = TEMP_ADDR_2_LO
TEMP_ADDR_3 = TEMP_ADDR_3_LO

.TEMP_A           skip 1
.TEMP_X           skip 1
.TEMP_Y           skip 1
