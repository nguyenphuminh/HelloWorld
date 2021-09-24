_TXTLOCK
_TXTATTRIB "TRUECOLOR", 1
OC = FGC()
R = CINT(RAND(255)): G = CINT(RAND(255)): B = CINT(RAND(255))
X = 3: Y = RAND(0.5, 1): X = X - Y: Z = RAND(0.5, 1): X = X -Z
IF CINT(RAND(1)) = 1: X = X * -1: ENDIF
IF CINT(RAND(1)) = 1: Y = Y * -1: ENDIF
IF CINT(RAND(1)) = 1: Z = Z * -1: ENDIF
@ LOOP
COLOR RGB(LIMIT(R, 0, 255), LIMIT(G, 0, 255), LIMIT(B, 0, 255))
PRINT "Hello, World!",, PAD$(CINT(R), 3), PAD$(CINT(G), 3), PAD$(CINT(B), 3),, PAD$(X, 9, " "), PAD$(Y, 9, " "), PAD$(Z, 9, " ");
COLOR OC
PRINT
R = R + X
G = G + Y
B = B + Z
IF R > 255: X = X * -1: ENDIF
IF R < 0: X = X * -1: ENDIF
IF G > 255: Y = Y * -1: ENDIF
IF G < 0: Y = Y * -1: ENDIF
IF B > 255: Z = Z * -1: ENDIF
IF B < 0: Z = Z * -1: ENDIF
WAIT 0.005
PUT "\r"
LOCATE , CURY() - 1
GOTO LOOP
