#!/bin/bash


if [ "$TERM" = "linux" ]; then
    case ${1:-3} in
        1) # Peppermint
        echo -en "\e]P0353535"
        echo -en "\e]P1E64569"
        echo -en "\e]P289D287"
        echo -en "\e]P3DAB752"
        echo -en "\e]P4439ECF"
        echo -en "\e]P5D961DC"
        echo -en "\e]P664AAAF"
        echo -en "\e]P7B3B3B3"
        echo -en "\e]P8535353"
        echo -en "\e]P9E4859A"
        echo -en "\e]PAA2CCA1"
        echo -en "\e]PBE1E387"
        echo -en "\e]PC6FBBE2"
        echo -en "\e]PDE586E7"
        echo -en "\e]PE96DCDA"
        echo -en "\e]PFDEDEDE"
        ;;

        2) # Hemisu dark
        echo -en "\e]P0444444"
        echo -en "\e]P1FF0054"
        echo -en "\e]P2B1D630"
        echo -en "\e]P39D895E"
        echo -en "\e]P467BEE3"
        echo -en "\e]P5B576BC"
        echo -en "\e]P6569A9F"
        echo -en "\e]P7EDEDED"
        echo -en "\e]P8777777"
        echo -en "\e]P9D65E75"
        echo -en "\e]PABAFFAA"
        echo -en "\e]PBECE1C8"
        echo -en "\e]PC9FD3E5"
        echo -en "\e]PDDEB3DF"
        echo -en "\e]PEB6E0E5"
        echo -en "\e]PFFFFFFF"
        ;;
        3) # Dark Pastel

        echo -en "\e]P0000000"
        echo -en "\e]P1ff5555"
        echo -en "\e]P255ff55"
        echo -en "\e]P3ffff55"
        echo -en "\e]P45555ff"
        echo -en "\e]P5ff55ff"
        echo -en "\e]P655ffff"
        echo -en "\e]P7bbbbbb"
        echo -en "\e]P8555555"
        echo -en "\e]P9ff5555"
        echo -en "\e]PA55ff55"
        echo -en "\e]PBffff55"
        echo -en "\e]PC5555ff"
        echo -en "\e]PDff55ff"
        echo -en "\e]PE55ffff"
        echo -en "\e]PFffffff"
        ;;

        5) # Harper

        echo -en "\e]P0010101"
        echo -en "\e]P1f8b63f"
        echo -en "\e]P27fb5e1"
        echo -en "\e]P3d6da25"
        echo -en "\e]P4489e48"
        echo -en "\e]P5b296c6"
        echo -en "\e]P6f5bfd7"
        echo -en "\e]P7a8a49d"
        echo -en "\e]P8726e6a"
        echo -en "\e]P9f8b63f"
        echo -en "\e]PA7fb5e1"
        echo -en "\e]PBd6da25"
        echo -en "\e]PC489e48"
        echo -en "\e]PDb296c6"
        echo -en "\e]PEf5bfd7"
        echo -en "\e]PFfefbea"
        ;;

        *)

    esac
fi
