cat $1_Dealer_schedule | grep "$2" | awk '{print $5, $6}'
