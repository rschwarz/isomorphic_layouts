kbm_template = """
! Template for a keyboard mapping
!
! Size of map. The pattern repeats every so many keys:
12
! First MIDI note number to retune:
0
! Last MIDI note number to retune:
127
! Middle note where the first entry of the mapping is mapped to:
60
! Reference note for which frequency is given:
69
! Frequency to tune the above note to (floating point e.g. 440.0):
440.0
! Scale degree to consider as formal octave (determines difference in pitch
! between adjacent mapping patterns):
12
! Mapping.
! The numbers represent scale degrees mapped to keys. The first entry is for
! the given middle note, the next for subsequent higher keys.
! For an unmapped key, put in an "x". At the end, unmapped keys may be left out.
0
1
2
3
4
5
6
7
8
9
10
11
"""
