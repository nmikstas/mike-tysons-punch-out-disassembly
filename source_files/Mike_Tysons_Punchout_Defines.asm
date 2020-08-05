;-------------------------------------[General Purpose Variables]------------------------------------

.alias GenByteE0        $E0     ;General purpose byte.

;-----------------------------------------[Variable Defines]-----------------------------------------

.alias RoundMinute      $0302   ;Current minute in round.
.alias RoundUpperSec    $0304   ;Current tens of seconds in round.
.alias RoundLowerSec    $0305   ;Current second in round(base 10).

;--------------------------------------[Sound Engine Variables]--------------------------------------

;$E0

;$F0
;$F1
;$F2
;$F3
;$F4
;$F5
;$F6
;$F7

;$F8
;$F9

;$FC
;$FD

;$0700
;$0701
;$0702
;$0703
;$0704
;$0705
;$0706
;$0707
;$0708
;$0709
;$070A
;$070B
;$070C
;$070D
;$070E
.alias SQ0LoFreqBits    $070F   ;Lower frequency bits of SQ0.
.alias SQ1LoFreqBits    $0710   ;Lower frequency bits of SQ1.
;$0711
;$0712
;$0713

;$0715
;$0716
;$0717
;$0718
;$0719
;$071A
;$071B
;$071C
;$071D
;$071E
;$071F
;$0720
;$0721
;$0722
;$0723
;$0724
;$0725
;$0726

;$0728
;$0729
;$072A
;$072B
;$072C


;-------------------------------------[Hardware Registers]-------------------------------------------

.alias PPUControl0      $2000   ;
.alias PPUControl1      $2001   ;
.alias PPUStatus        $2002   ;
.alias SPRAddress       $2003   ;PPU hardware control registers.
.alias SPRIOReg         $2004   ;
.alias PPUScroll        $2005   ;
.alias PPUAddress       $2006   ;
.alias PPUIOReg         $2007   ;

.alias SQ1Cntrl0        $4000   ;
.alias SQ1Cntrl1        $4001   ;SQ1 hardware control registers.
.alias SQ1Cntrl2        $4002   ;
.alias SQ1Cntrl3        $4003   ;

.alias SQ2Cntrl0        $4004   ;
.alias SQ2Cntrl1        $4005   ;SQ2 hardware control registers.
.alias SQ2Cntrl2        $4006   ;
.alias SQ2Cntrl3        $4007   ;

.alias TriangleCntrl0   $4008   ;
.alias TriangleCntrl1   $4009   ;Triangle hardware control registers.
.alias TriangleCntrl2   $400A   ;
.alias TriangleCntrl3   $400B   ;

.alias NoiseCntrl0      $400C   ;
.alias NoiseCntrl1      $400D   ;Noise hardware control registers.
.alias NoiseCntrl2      $400E   ;
.alias NoiseCntrl3      $400F   ;

.alias DMCCntrl0        $4010   ;
.alias DMCCntrl1        $4011   ;DMC hardware control registers.
.alias DMCCntrl2        $4012   ;
.alias DMCCntrl3        $4013   ;

.alias SPRDMAReg        $4014   ;Sprite RAM DMA register.
.alias APUCommonCntrl0  $4015   ;APU common control 1 register.
.alias CPUJoyPad1       $4016   ;Joypad1 register.
.alias APUCommonCntrl1  $4017   ;Joypad2/APU common control 2 register.

;------------------------------------------[MMC Registers]-------------------------------------------

;--------------------------------------------[Constants]---------------------------------------------

;Sound channel indexes.
.alias AUD_SQ0_INDEX    $00     ;Square wave 0 channel index.
.alias AUD_SQ1_INDEX    $04     ;Square wave 1 channel index.
.alias AUD_TRI_INDEX    $08     ;Triangle wave channel index.
