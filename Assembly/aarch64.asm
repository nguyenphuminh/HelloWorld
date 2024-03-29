/* ARM assembly AARCH64 Raspberry PI 3B */ 
/*  program disMessGraph64.s   */ 
/* link with gcc options  -lX11 -L/usr/lpp/X11/lib */ 
  
/*******************************************/ 
/* Constantes file                         */ 
/*******************************************/ 
/* for this file see task include a file in language AArch64 assembly*/ 
.include "../includeConstantesARM64.inc" 
.equ ClientMessage, 33 
  
/*******************************************/ 
/* Initialized data                        */ 
/*******************************************/  
.data 
szRetourligne: .asciz  "\n" 
szMessErreur:  .asciz "Server X11 not found.\n" 
szMessErrfen:  .asciz "Error create X11 window.\n" 
szMessErrGC:   .asciz "Error create Graphic Context.\n" 
szMessGoodBye: .asciz "Goodbye World!" 
  
szLibDW:       .asciz "WM_DELETE_WINDOW"      // message close window 
  
/*******************************************/ 
/* UnInitialized data                      */ 
/*******************************************/  
.bss 
.align 4 
qDisplay:        .skip 8           // Display address 
qDefScreen:      .skip 8           // Default screen address 
identWin:        .skip 8           // window ident 
wmDeleteMessage: .skip 16          // ident close message 
stEvent:         .skip 400         // provisional size 
  
buffer:          .skip 500  
  
/**********************************************/ 
/* -- Code section                            */ 
/**********************************************/ 
.text            
.global main                   // program entry 
main: 
    mov x0,#0                  // open server X 
    bl XOpenDisplay 
    cmp x0,#0 
    beq erreur 
                               //  Ok return Display address 
    ldr x1,qAdrqDisplay 
    str x0,[x1]                // store Display address for future use 
    mov x28,x0                 // and in register 28 
                               // load default screen 
    ldr x2,[x0,#264]           // at location 264 
    ldr x1,qAdrqDefScreen 
    str x2,[x1]                //store default_screen 
    mov x2,x0 
    ldr x0,[x2,#232]           // screen list 
  
                               //screen areas 
    ldr x5,[x0,#+88]           // white pixel 
    ldr x3,[x0,#+96]           // black pixel 
    ldr x4,[x0,#+56]           // bits par pixel 
    ldr x1,[x0,#+16]           // root windows 
                               // create window x11 
    mov x0,x28                 //display 
    mov x2,#0                  // position X  
    mov x3,#0                  // position Y 
    mov x4,600                 // weight 
    mov x5,400                 // height 
    mov x6,0                   // bordure ??? 
    ldr x7,0                   // ? 
    ldr x8,qBlanc              // background 
    str x8,[sp,-16]!           // argument fot stack 
    bl XCreateSimpleWindow 
    add sp,sp,16               // for stack alignement 
    cmp x0,#0                  // error ? 
    beq erreurF 
    ldr x1,qAdridentWin 
    str x0,[x1]                // store window ident for future use 
    mov x27,x0                 // and in register 27 
  
                               // Correction of window closing error 
    mov x0,x28                 // Display address 
    ldr x1,qAdrszLibDW         // atom name address 
    mov x2,#1                  // False  create atom if not exist 
    bl XInternAtom 
    cmp x0,#0 
    ble erreurF 
    ldr x1,qAdrwmDeleteMessage // address message 
    str x0,[x1] 
    mov x2,x1                  // address atom create 
    mov x0,x28                 // display address 
    mov x1,x27                 // window ident 
    mov x3,#1                  // number of protocoles  
    bl XSetWMProtocols 
    cmp x0,#0 
    ble erreurF 
                               // create Graphic Context 
    mov x0,x28                 // display address 
    mov x1,x27                 // window ident 
    bl createGC                // GC address -> x26 
    cbz x0,erreurF 
                               // Display window 
    mov x1,x27                 // ident window 
    mov x0,x28                 // Display address 
    bl XMapWindow 
  
    ldr x0,qAdrszMessGoodBye   // display text 
    bl displayText 
  
1:                             // events loop 
    mov x0,x28                 // Display address 
    ldr x1,qAdrstEvent         // events structure address 
    bl XNextEvent 
    ldr x0,qAdrstEvent         // events structure address 
    ldr w0,[x0]                // type in 4 fist bytes 
    cmp w0,#ClientMessage      // message for close window  
    bne 1b                     // no -> loop 
  
    ldr x0,qAdrstEvent         // events structure address 
    ldr x1,[x0,56]             // location message code 
    ldr x2,qAdrwmDeleteMessage // equal ? 
    ldr x2,[x2] 
    cmp x1,x2 
    bne 1b                     // no loop  
  
    mov x0,0                   // end Ok 
    b 100f 
erreurF:                       // error create window 
    ldr x0,qAdrszMessErrfen 
    bl affichageMess 
    mov x0,1 
    b 100f 
erreur:                        // error no server x11 active 
    ldr x0,qAdrszMessErreur 
    bl affichageMess 
    mov x0,1 
100:                           // program standard end 
    mov x8,EXIT 
    svc 0  
qBlanc:              .quad 0xF0F0F0F0 
qAdrqDisplay:        .quad qDisplay 
qAdrqDefScreen:      .quad qDefScreen 
qAdridentWin:        .quad identWin 
qAdrstEvent:         .quad stEvent 
qAdrszMessErrfen:    .quad szMessErrfen 
qAdrszMessErreur:    .quad szMessErreur 
qAdrwmDeleteMessage: .quad wmDeleteMessage 
qAdrszLibDW:         .quad szLibDW 
qAdrszMessGoodBye:   .quad szMessGoodBye 
/******************************************************************/ 
/*     create Graphic Context                                     */  
/******************************************************************/ 
/* x0 contains the Display address */ 
/* x1 contains the ident Window */ 
createGC: 
    stp x20,lr,[sp,-16]!       // save  registers 
    mov x20,x0                 // save display address 
    mov x2,#0 
    mov x3,#0 
    bl XCreateGC 
    cbz x0,99f 
    mov x26,x0                 // save GC 
    mov x0,x20                 // display address 
    mov x1,x26 
    ldr x2,qRed                // code RGB color 
    bl XSetForeground 
    cbz x0,99f 
    mov x0,x26                 // return GC 
    b 100f 
99: 
    ldr x0,qAdrszMessErrGC 
    bl affichageMess 
    mov x0,0 
100: 
    ldp x20,lr,[sp],16         // restaur  2 registers 
    ret                        // return to address lr x30 
qAdrszMessErrGC:             .quad szMessErrGC 
qRed:                        .quad 0xFF0000 
qGreen:                      .quad 0xFF00 
qBlue:                       .quad 0xFF 
qBlack:                      .quad 0x0 
/******************************************************************/ 
/*     display text on screen                                     */  
/******************************************************************/ 
/* x0 contains the address of text */ 
displayText: 
    stp x1,lr,[sp,-16]!    // save  registers 
    mov x5,x0              // text address 
    mov x6,0               // text size 
1:                         // loop compute text size 
    ldrb w10,[x5,x6]       // load text byte 
    cbz x10,2f             // zero -> end 
    add x6,x6,1            // increment size 
    b 1b                   // and loop 
2: 
    mov x0,x28             // display address 
    mov x1,x27             // ident window 
    mov x2,x26             // GC address 
    mov x3,#50             // position x 
    mov x4,#100            // position y 
    bl XDrawString 
100: 
    ldp x1,lr,[sp],16      // restaur  2 registers 
    ret                    // return to address lr x30 
/********************************************************/ 
/*        File Include fonctions                        */ 
/********************************************************/ 
/* for this file see task include a file in language AArch64 assembly */ 
.include "../includeARM64.inc"