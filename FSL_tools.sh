#!/bin/bash

initialInfo() {
    clear            
    figlet -c 'FSL COMANDOS'    
}

functionBet(){ #1 - BET 
    initialInfo
    bet input output -f 0.2 -m
}

functionSusan(){ #2 - SUSAN 
    initialInfo
    #susan <input> <bt> <dt> <dim> <use_median> <n_usans> [<usan1> <bt1> [<usan2> <bt2>]] <output>
    susan input 2000 2 3 1 0 output 
}

functionFast(){ #3 - FAST 
    initialInfo
    #fast [options] file(s)]
    fast -t 1 -n 3 -H 0.1 -I 4 -l 20.0 -o output 
}

functionFlirt(){ #4 - FLIRT 
    initialInfo
   #/home/mariaprojeto/fsl/bin/flirt [options] -in <inputvol> -ref <refvol> -out <outputvol>
   #/home/mariaprojeto/fsl/bin/flirt [options] -in <inputvol> -ref <refvol> -omat <outputmatrix>
   #/home/mariaprojeto/fsl/bin/flirt [options] -in <inputvol> -ref <refvol> -applyxfm -init <matrix> -out <outputvol>
   
   flirt -in input -ref MNI152_T1_2mm_brain -out output -omat output.mat -bins 256 -cost corratio -searchrx -90 90 -searchry -90 90 -searchrz -90 90 -dof 12  -interp trilinear
}

functionFugue(){ #5 - FUGUE
    initialInfo
    #fugue -i <epi> -p <unwrapped phase map> -d <dwell-to-asym-ratio> -u <result> [options]
    #fugue  -i <unwarped-image> -p <unwrapped phase map> -d <dwell-to-asym-ratio> -w <epi-like-result> [options]
    #fugue -p <unwrapped phase map> -d <dwell-to-asym-ratio> --saveshift=<shiftmap> [options]

    prelude -c fieldmap -u unwrapped_phase
    fugue -i epi -p unwrapped_phase -d 0.295 -u unwarped_epi
}

functionSienax(){ #6 - SIENAX
    initialInfo
    #sienax <input> [options]
    sienax input
}

functionFeat(){  #7 - FEAT 
    initialInfo
    feat design.fsf
}

functionMelodic(){  #8 - MELODIC
    initialInfo
    working_dir=$(pwd)
    melodic -i "$working_dir/fmri.nii.gz"                            #input: fmri.nii.gz        #to run melodic   
}

functionFirst(){  #9 - FIRST
    initialInfo
    #first -i <input image> -l <flirt matrix> -m <model>

    first_flirt input output
    run_first -i RS2MA4D -t input_to_std_sub.mat -n 20 -o input_first_L_Hipp -m \
    ${FSLDIR}/data/first/models_317_bin/L_Hipp_bin.bmv
}

functionAll(){ #10 Corre todas as ferramentas
    functionBet
    functionFast
    functionFeat
    functionFirst
    functionFlirt
    functionFugue
    functionMelodic
    functionSienax
    functionSusan
}

echoLine(){  
    echo -n -e "-----------------------------------------------------------------"
}

menu() {
    local options=("1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "q")       
    local option_selected            
    for i in "${options[@]}"; do     
        while [ "$option" != "q" ]; do
            initialInfo
            echo -n -e "   Selecione uma das seguintes opções.\n
        1 - BET;\n
        2 - SUSAN;\n
        3 - FAST;\n
        4 - FLIRT;\n
        5 - FUGUE;\n
        6 - SIENAX;\n
        7 - FEAT;\n
        8 - MELODIC;\n
        9 - FIRST;\n
        10 - All;\n
        q - Sair;\n
    Opção: "
            read option_selected
            case $option_selected in
                1) functionBet ;;
                2) functionSusan ;;
                3) functionFast ;;
                4) functionFlirt ;;
                5) functionFugue ;;
                6) functionSienax ;;
                7) functionFeat ;;
                8) functionMelodic ;;
                9) functionFirst ;;
                10) functionAll ;;
                q) exit 0 ;;
                *) echo "A opção que colocou é inválida! $REPLY";; 
            esac
        done
    done

}
menu