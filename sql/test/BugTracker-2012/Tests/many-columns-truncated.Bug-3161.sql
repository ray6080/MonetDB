create table household (
    RT VARCHAR(255),
    SERIALNO INT,
    DIVISION INT,
    PUMA INT,
    REGION INT,
    ST INT,
    ADJHSG INT,
    ADJINC INT,
    WGTP INT,
    NP INT,
    ZZZZ INT,
    ACR INT,
    AGS INT,
    BATH INT,
    BDSP INT,
    BLD INT,
    BUS INT,
    CONP INT,
    ELEP INT,
    FS INT,
    FULP INT,
    GASP INT,
    HFL INT,
    INSP INT,
    MHP INT,
    MRGI INT,
    MRGP INT,
    MRGT INT,
    MRGX INT,
    REFR INT,
    RMSP INT,
    RNTM INT,
    RNTP INT,
    RWAT INT,
    SINK INT,
    SMP INT,
    STOV INT,
    TEL INT,
    TEN INT,
    TOIL INT,
    VACS INT,
    VALP INT,
    VEH INT,
    WATP INT,
    YBL INT,
    FES INT,
    FINCP INT,
    FPARC INT,
    GRNTP INT,
    GRPIP INT,
    HHL INT,
    HHT INT,
    HINCP INT,
    HUGCL INT,
    HUPAC INT,
    HUPAOC INT,
    HUPARC INT,
    KIT INT,
    LNGI INT,
    MULTG INT,
    MV INT,
    NOC INT,
    NPF INT,
    NPP INT,
    NR INT,
    NRC INT,
    OCPIP INT,
    PARTNER INT,
    PLM INT,
    PSF INT,
    R18 INT,
    R60 INT,
    R65 INT,
    RESMODE INT,
    SMOCP INT,
    SMX INT,
    SRNT INT,
    SVAL INT,
    TAXP INT,
    WIF INT,
    WKEXREL INT,
    WORKSTAT INT,
    FACRP INT,
    FAGSP INT,
    FBATHP INT,
    FBDSP INT,
    FBLDP INT,
    FBUSP INT,
    FCONP INT,
    FELEP INT,
    FFSP INT,
    FFULP INT,
    FGASP INT,
    FHFLP INT,
    FINSP INT,
    FKITP INT,
    FMHP INT,
    FMRGIP INT,
    FMRGP INT,
    FMRGTP INT,
    FMRGXP INT,
    FMVP INT,
    FPLMP INT,
    FREFRP INT,
    FRMSP INT,
    FRNTMP INT,
    FRNTP INT,
    FRWATP INT,
    FSINKP INT,
    FSMP INT,
    FSMXHP INT,
    FSMXSP INT,
    FSTOVP INT,
    FTAXP INT,
    FTELP INT,
    FTENP INT,
    FTOILP INT,
    FVACSP INT,
    FVALP INT,
    FVEHP INT,
    FWATP INT,
    FYBLP INT,
    wgtp1 INT,
    wgtp2 INT,
    wgtp3 INT,
    wgtp4 INT,
    wgtp5 INT,
    wgtp6 INT,
    wgtp7 INT,
    wgtp8 INT,
    wgtp9 INT,
    wgtp10 INT,
    wgtp11 INT,
    wgtp12 INT,
    wgtp13 INT,
    wgtp14 INT,
    wgtp15 INT,
    wgtp16 INT,
    wgtp17 INT,
    wgtp18 INT,
    wgtp19 INT,
    wgtp20 INT,
    wgtp21 INT,
    wgtp22 INT,
    wgtp23 INT,
    wgtp24 INT,
    wgtp25 INT,
    wgtp26 INT,
    wgtp27 INT,
    wgtp28 INT,
    wgtp29 INT,
    wgtp30 INT,
    wgtp31 INT,
    wgtp32 INT,
    wgtp33 INT,
    wgtp34 INT,
    wgtp35 INT,
    wgtp36 INT,
    wgtp37 INT,
    wgtp38 INT,
    wgtp39 INT,
    wgtp40 INT,
    wgtp41 INT,
    wgtp42 INT,
    wgtp43 INT,
    wgtp44 INT,
    wgtp45 INT,
    wgtp46 INT,
    wgtp47 INT,
    wgtp48 INT,
    wgtp49 INT,
    wgtp50 INT,
    wgtp51 INT,
    wgtp52 INT,
    wgtp53 INT,
    wgtp54 INT,
    wgtp55 INT,
    wgtp56 INT,
    wgtp57 INT,
    wgtp58 INT,
    wgtp59 INT,
    wgtp60 INT,
    wgtp61 INT,
    wgtp62 INT,
    wgtp63 INT,
    wgtp64 INT,
    wgtp65 INT,
    wgtp66 INT,
    wgtp67 INT,
    wgtp68 INT,
    wgtp69 INT,
    wgtp70 INT,
    wgtp71 INT,
    wgtp72 INT,
    wgtp73 INT,
    wgtp74 INT,
    wgtp75 INT,
    wgtp76 INT,
    wgtp77 INT,
    wgtp78 INT,
    wgtp79 INT,
    wgtp80 INT
);

copy 5 offset 2 records into household from stdin using delimiters ',',E'\n','"' NULL as '';
RT,SERIALNO,DIVISION,PUMA,REGION,ST,ADJHSG,ADJINC,WGTP,NP,TYPE,ACR,AGS,BATH,BDSP,BLD,BUS,CONP,ELEP,FS,FULP,GASP,HFL,INSP,MHP,MRGI,MRGP,MRGT,MRGX,REFR,RMSP,RNTM,RNTP,RWAT,SINK,SMP,STOV,TEL,TEN,TOIL,VACS,VALP,VEH,WATP,YBL,FES,FINCP,FPARC,GRNTP,GRPIP,HHL,HHT,HINCP,HUGCL,HUPAC,HUPAOC,HUPARC,KIT,LNGI,MULTG,MV,NOC,NPF,NPP,NR,NRC,OCPIP,PARTNER,PLM,PSF,R18,R60,R65,RESMODE,SMOCP,SMX,SRNT,SVAL,TAXP,WIF,WKEXREL,WORKSTAT,FACRP,FAGSP,FBATHP,FBDSP,FBLDP,FBUSP,FCONP,FELEP,FFSP,FFULP,FGASP,FHFLP,FINSP,FKITP,FMHP,FMRGIP,FMRGP,FMRGTP,FMRGXP,FMVP,FPLMP,FREFRP,FRMSP,FRNTMP,FRNTP,FRWATP,FSINKP,FSMP,FSMXHP,FSMXSP,FSTOVP,FTAXP,FTELP,FTENP,FTOILP,FVACSP,FVALP,FVEHP,FWATP,FYBLP,wgtp1,wgtp2,wgtp3,wgtp4,wgtp5,wgtp6,wgtp7,wgtp8,wgtp9,wgtp10,wgtp11,wgtp12,wgtp13,wgtp14,wgtp15,wgtp16,wgtp17,wgtp18,wgtp19,wgtp20,wgtp21,wgtp22,wgtp23,wgtp24,wgtp25,wgtp26,wgtp27,wgtp28,wgtp29,wgtp30,wgtp31,wgtp32,wgtp33,wgtp34,wgtp35,wgtp36,wgtp37,wgtp38,wgtp39,wgtp40,wgtp41,wgtp42,wgtp43,wgtp44,wgtp45,wgtp46,wgtp47,wgtp48,wgtp49,wgtp50,wgtp51,wgtp52,wgtp53,wgtp54,wgtp55,wgtp56,wgtp57,wgtp58,wgtp59,wgtp60,wgtp61,wgtp62,wgtp63,wgtp64,wgtp65,wgtp66,wgtp67,wgtp68,wgtp69,wgtp70,wgtp71,wgtp72,wgtp73,wgtp74,wgtp75,wgtp76,wgtp77,wgtp78,wgtp79,wgtp80
H,168,9,00300,4,02,1000000,1007624,00056,03,1,1,,1,03,02,2,,200,2,3500,003,4,0760,,1,01800,1,1,1,07,,,1,1,,1,1,1,1,,0235000,2,1600,5,7,000089500,4,,,1,3,000089500,0,4,4,4,1,1,1,6,00,03,0,0,00,033,0,1,0,0,0,0,1,02425,3,0,1,43,3,14,13,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,00074,00014,00062,00094,00047,00055,00045,00072,00060,00120,00018,00058,00031,00061,00054,00052,00015,00020,00088,00058,00020,00060,00107,00057,00110,00115,00016,00047,00017,00072,00055,00018,00063,00019,00089,00070,00047,00043,00056,00086,00081,00020,00070,00094,00068,00047,00057,00094,00080,00078,00039,00061,00012,00051,00063,00047,00021,00014,00095,00072,00016,00050,00079,00073,00082,00079,00016,00053,00024,00035,00054,00016,00039,00012,00118,00135,00066,00047,00050,00076
H,433,9,00200,4,02,1000000,1007624,00000,01,2,,,,,,,,,2,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,5,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,0,,,,,,,,,,,0,,,,,,,,,,,,,,,,,,,,,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000,00000
H,650,9,00200,4,02,1000000,1007624,00057,00,1,2,,1,02,02,2,,,,,,,,,,,,,1,06,,,1,1,,1,,,1,5,,,,7,,,,,,,,,,,,,1,,,,,,,,,,,1,,,,,2,,,0,0,,,,,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,00060,00017,00057,00016,00093,00106,00059,00058,00058,00017,00056,00101,00054,00116,00096,00018,00072,00015,00061,00055,00054,00018,00054,00015,00096,00097,00057,00065,00055,00017,00049,00094,00059,00113,00088,00018,00059,00013,00056,00050,00060,00017,00059,00017,00096,00098,00052,00050,00050,00017,00060,00093,00057,00102,00101,00017,00068,00020,00053,00054,00066,00018,00063,00019,00091,00106,00056,00056,00057,00020,00057,00090,00054,00098,00101,00016,00051,00017,00061,00061
H,1890,9,00400,4,02,1000000,1007624,00046,02,1,,,1,01,06,,,001,2,0001,003,4,,,,,,,1,02,2,00600,1,1,,1,1,3,1,,,1,0001,3,,,,0600,021,1,7,000034700,0,4,4,4,1,1,1,3,00,,0,1,00,,0,1,0,0,0,0,2,,,1,0,,,,,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,00010,00016,00010,00042,00061,00044,00054,00045,00071,00067,00112,00050,00015,00041,00111,00079,00037,00067,00038,00040,00081,00095,00070,00081,00051,00040,00038,00047,00015,00022,00018,00034,00095,00055,00014,00051,00048,00018,00043,00012,00007,00013,00015,00057,00072,00055,00048,00050,00075,00080,00116,00051,00014,00038,00126,00057,00030,00093,00029,00053,00080,00055,00071,00046,00038,00057,00039,00047,00016,00016,00020,00050,00091,00058,00020,00072,00043,00011,00048,00009
H,2029,9,00101,4,02,1000000,1007624,00269,04,1,1,,1,04,02,2,,080,2,0002,080,1,1500,,1,00920,1,1,1,07,,,1,1,,1,1,1,1,,0200000,1,0200,4,8,000047100,2,,,1,3,000047100,1,2,4,2,1,1,2,7,00,04,0,0,02,028,0,1,1,1,1,1,2,01097,3,0,1,34,1,15,15,0,0,0,0,0,0,0,1,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,00252,00470,00264,00430,00228,00243,00192,00107,00265,00079,00266,00268,00068,00335,00503,00116,00095,00389,00228,00114,00254,00071,00225,00116,00289,00291,00233,00539,00310,00423,00262,00346,00511,00235,00079,00407,00420,00121,00223,00090,00250,00070,00240,00101,00259,00326,00245,00461,00241,00480,00315,00275,00286,00338,00118,00363,00409,00087,00238,00418,00278,00322,00297,00486,00376,00262,00198,00095,00259,00104,00238,00309,00135,00230,00408,00117,00083,00497,00244,00418

select count(*) from household;
select * from household limit 5;
