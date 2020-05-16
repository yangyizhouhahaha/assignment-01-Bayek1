#!/usr/bin/env bash
if [[ $1 == "-h" ]];then
	echo "������Ϣ"
	echo "-h �鿴������Ϣ"
	echo "-f �ļ��� -host��ͳ�Ʒ�����Դ����TOP 100�ͷֱ��Ӧ���ֵ��ܴ���"
	echo "-f �ļ��� -ip�� ͳ�Ʒ�����Դ����TOP 100 IP�ͷֱ��Ӧ���ֵ��ܴ���"
	echo "-f �ļ��� -url��ͳ����Ƶ�������ʵ�URL TOP 100"
	echo "-f �ļ��� -code���Ʋ�ͬ��Ӧ״̬��ĳ��ִ����Ͷ�Ӧ�ٷֱ�"
	echo "-f �ļ��� -4code���ֱ�ͳ�Ʋ�ͬ4XX״̬���Ӧ��TOP 10 URL�Ͷ�Ӧ���ֵ��ܴ���"
	echo "-f �ļ��� -urlhost ָ��url: ����URL���TOP 100������Դ����"
elif [[ $1 == "-f" ]];then
	IFS_old=$IFS
	IFS=$'\t'
	i=-1
	while read -r line;do
		array=($line)
		if [[ $i -gt -1 ]];then
			host[$i]=${array[0]}
			url[$i]=${array[4]}
			code[$i]=${array[5]}
		fi
		((i++))
	done < $2
	#echo ${host[*]}
	#echo ${url[*]}
	#echo ${code[*]}

	if [[ $3 == "-urlhost" ]];then
		u=$4
		echo "ָ��url:$u"
		#cat $2 | awk '{print "'$u'"}'
		cat $2 | awk -F'\t' ' $5=="'$u'" {printf"%s\n",$1}' | sort | uniq -c | sort -rn | head -n 100 | awk ' {printf(" %s\t\t ����: %d\n",$2,$1)}'
	elif [[ $3 == "-4code" ]];then
		cat $2 | awk -F'\t' ' $6 ~/[4][0-9][0-9]/ {printf"%s\n",$5}'| sort | uniq -c | sort -rn | head -n 10 | awk '{printf(" %s\t\t ����: %d\n",$2,$1)}'
	elif [[ $3 == "-code" ]];then

		all=$(cat $2 | awk -F'\t' 'BEGIN{a=0} $6 ~/[0~9]/ {a=a+1} END {print a}')
		echo $all
		 cat $2 | awk -F'\t' '$6 ~/[0~9]/ {print $6}' | sort | uniq -c | sort -rn | awk -F' ' '{printf("%s\t ����:%d\tռ�� :%f \n",$2,$1,100*$1/'"${all}"')}'
		
	
	elif [[ $3 == "-url" ]];then

		cat $2 | awk -F'\t' '{print $5}' | sort | uniq -c | sort -rn | head -n 100 | awk -F' ' '{printf(" %s\t\t ����: %d\n",$2,$1)}'
		

	elif [[ $3 == "-host" || $3 == "-ip" ]];then
		dic1=($(echo ${host[*]} | sed 's/ /\n/g'|sort | uniq))
		#echo "ȥ�����"
		IFS=$'\n'
		dic=($dic1)
		#echo "�ֶ�֮��ģ�${#dic[@]} ${dic1[@]}"
		declare -A hostnum
		for v in ${dic}
		do
			hostnum[$v]=0
		done
		for v in ${host[@]}
		do
			x=${hostnum[$v]}
			((x++))
			hostnum[$v]=$x
		done
		#for key in "${!hostnum[@]}";do
		#	echo "$key�� ${hostnum[$key]}"
		#done
		i=0
		for key in "${!hostnum[@]}";do
			#echo $key
			if [[ $3 == "-host" ]];then

				if [[ $key == *[a-zA-Z]* ]];then
					name[$i]=$key
					#echo "--------------------    ${name[$i]}"
					((i++))
				fi
			fi

			if [[ $3 == "-ip" ]];then
				if [[ $key == *[a-zA-Z]* ]];then
					x=1
				else
					name[$i]=$key
					((i++))
				fi
			fi

		done
		echo "��ʼ����"
		t=${name[0]}
		for((i=0;i<100;i++));
		do
			max=${hostnum[$t]}
			m=$t

			for v in ${name[@]};
			do
				x=${hostnum[$v]}
				if [[ $x -gt $max ]];then
					max=$x
					m=$v
				fi	
			done

			echo "TOP$((i+1)):   $m             �����ǣ�$max"
			hostnum[$m]=-1

		done

	else
		echo "$3�������-h�鿴������Ϣ"

	fi

else
	echo "$1�������-h�鿴������Ϣ"
fi