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

.alias MusicDataPtr		$F8		;Pointer base of music data.
.alias MusicDataPtrLB	$F8		;Pointer base of music data, lower byte.
.alias MusicDataPtrUB	$F9		;Pointer base of music data, upper byte.

.alias SQ2NoteIndex		$FC		;Index to current SQ2 musical note data.
.alias SQ1NoteIndex		$FD		;Index to current SQ1 musical note data.

.alias SQ2NoteRemain	$0700	;The counter used for remaining SQ2 note time.
.alias SQ1NoteRemain	$0701	;The counter used for remaining SQ1 note time.
.alias TriNoteRemain	$0702	;The counter used for remaining triangle note time.
.alias NoiseNoteRemain	$0703	;The counter used for remaining noise note time.

.alias SQ2NoteLength	$0704	;The total length of the of the current SQ2 note.
.alias SQ1NoteLength	$0705	;The total length of the of the current SQ1 note.
.alias TriNoteLength	$0706	;The total length of the of the current triangle note.
.alias NoiseNoteLength	$0707	;The total length of the of the current noise note.

;$0708
;$0709
;$070A
;$070B
.alias NoiseIndexReload	$070C	;Reload address to repeat drum beatsin song background.
.alias NoteLengthsBase	$070D	;Base index for note lengths for a given piece of music.

.alias SQ1SweepCntrl	$070E	;Control byte for SQ1 sweep hardware.
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
.alias NoiseVolIndex	$0720	;Index to noise channel control byte for volume/envelope.
;$0721
.alias TriNoteIndex		$0722	;Index to current triangle musical note data.
.alias NoiseMusicIndex	$0723	;Index to current noise music data.
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
