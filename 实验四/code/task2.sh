#!/usr/bin/env bash
if [[ $1 == "-h" ]];then
	echo "������Ϣ";
	echo "-h �鿴������Ϣ"
	echo "-f �ļ��� -age [-range]:ͳ�Ʋ�ͬ�������䷶Χ��20�����¡�[20-30]��30�����ϣ�����Ա�������ٷֱ�"
	echo "               [-max] :����������Ա��˭"
	echo "               [-min]: ������С����Ա��˭"
	echo "-f �ļ��� -position:ͳ�Ʋ�ͬ����λ�õ���Ա�������ٷֱ�"
	echo "-f �ļ��� -name [-max]|[-min]:�����/��̵���Ա"
else
	if [[ $1 != "-f" ]];then
		echo "$3�������-h�鿴������Ϣ"
	
	else
		IFS_old=$IFS
		IFS=$'\t'
                i=-1
		while read -r line;do
			array=($line)
                	if [[ $i -gt -1 ]];then 
				name[$i]=${array[8]}
				age[$i]=${array[5]}
				pos[$i]=${array[4]}
			fi
                        ((i++))
		done < $2
		

		if [[ $3 == "-age" ]];then
			if [[ $4 == "-range" ]];then
				age1=0
				age2=0
				age3=0
				i=0
				for val in ${age[@]}
				do
					
					if [[ $val -lt 20 ]];then
						((age1++))
					elif [[ $val -ge 20 ]] && [[ $val -le 30 ]];then
						((age2++))
					else
						((age3++))
					fi
					((i++))
				done
				per1=$(echo "scale=2; $age1*100/${#age[@]}" | bc -l)	
				per2=$(echo "scale=2; $age2*100/${#age[@]}" | bc -l)
				per3=$(echo "scale=2; $age3*100/${#age[@]}" | bc -l)


				echo "ͳ�Ʋ�ͬ�������䷶Χ:"
				echo "20�����µ���Ա��$age1 �ˣ�ռ�� $per1 %"
				echo "20������30�����µ���Ա��$age2 �ˣ�ռ�� $per2 %"
				echo "30�����ϵ���Ա��$age3 �ˣ�ռ�� $per3 %"
			elif [[ $4 == "-min" ]];then
				max=${age[0]}
				for val in ${age[@]}
				do
					if [[ $val -lt $max ]];then
						max=$val
					fi
				done
				i=0
				j=0
				echo "������СΪ��$max"
				for val in ${age[@]}
				do
					if [[ $val -eq $max ]];then
						maxage[$j]=${name[$i]}
						((j++))
					fi
					((i++))
				done
				echo "�����ǣ�"
				for val in ${maxage[@]}
				do
					echo "$val"
				done	
			elif [[ $4 == "-max" ]];then
				max=${age[0]}
				
				for val in ${age[@]}
				do
					if [[ $val -gt $max ]];then
						max=$val
					fi
				done
				i=0
				j=0
				echo "�������Ϊ��$max"
				for val in ${age[@]}
				do
					if [[ $val -eq $max ]];then
						maxage[$j]=${name[$i]}
						((j++))
					fi
					((i++))
				done
				echo "�����ǣ�"
				for val in ${maxage[@]}
				do
					echo "$val"
				done

			
			fi
		elif [[ $3 == "-position" ]];then
			i=0
			loc1=($(echo ${pos[*]} | sed 's/ /\n/g'|sort | uniq))
			IFS=$'\n'
			loc=($loc1)
			declare -A locnum
			for v in ${loc[@]}
			do
				locnum[$v]=0
				
			done

			for v in ${pos[@]}
			do
				x=${locnum[$v]}
				((x++))
				locnum[$v]=$x

				#if [[ ! -n locnum[${v}] ]];then
				#	locnum[${v}]=1
				#else
				#	((locum[${v}]++))
				#fi
			done
			
			
			for key in "${!locnum[@]}";do
				echo "$key�� ${locnum[$key]} �ˣ�ռ��Ϊ $(echo "scale=2; ${locnum[$key]}*100/${#pos[@]}" | bc -l) %"
			done
				

		elif [[ $3 == "-name" ]];then
			n=${name[0]}
			x=$(echo ${n} | wc -c)

			if [[ $4 == "-max" ]];then
				for v in ${name[@]}
				do
					y=$(echo ${v} | wc -c)
					if [[ $y -gt $x ]];then
						x=$y
					fi
				done
				echo "��������ǣ����ֽ������㣩��$x �ֽ�"
				for v in ${name[@]}
				do
					y=$(echo ${v} | wc -c)
					if [[ $y -eq $x ]];then
						x=$y
						echo $v
					fi
				done
			elif [[ $4 == "-min" ]];then	
				for v in ${name[@]}
				do
					y=$(echo ${v} | wc -c)
					if [[ $y -lt $x ]];then
						x=$y
					fi
				done

				echo "������̵��ǣ����ֽ������㣩��$x �ֽ�"
				for v in ${name[@]}
				do
					y=$(echo ${v} | wc -c)
					if [[ $y -eq $x ]];then
						x=$y
						echo $v
					fi
				done

			else
				echo "$4 �������-h�鿴������"
			fi
		else
			echo "$3����-h�鿴����"

		fi

		IFS=$IFS_old
	fi
fi