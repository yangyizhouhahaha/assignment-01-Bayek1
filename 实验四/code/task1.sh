#!usrbinenv bash
if [[ $1 == -h ]];then
	echo ������Ϣ;
	echo ������Ϣ;
	echo -h                          �鿴������Ϣ;
	echo -f �ļ��� -cr -size ���� -o ����ļ��� ��jpegpngsvg��ʽͼƬ�ڱ���ԭʼ��߱ȵ�ǰ����ѹ���ֱ���;
	echo -f �ļ��� -w �ı�ˮӡ Ƕ��λ�� -o ����ļ��� ��ͼƬ��������Զ����ı�ˮӡ;
	echo -f �ļ��� -rn -f-b ǰ׺��׺ -o ����ļ��� ����������ͳһ����ļ���ǰ׺���׺;
	echo -f �ļ��� -jpg -o ����ļ��� ��pngsvgͼƬͳһת��Ϊjpg��ʽͼƬ;

elif [[ $1 == -f ]];then
	if [[ $3 == -qc ]];then
		echo ѹ��;
		for file in $2
		do
			na=$file;
			na1=.jpg;
			outname=${na##}
			if [[ $file == $na1 ]];then
				echo $outname;
				convert -quality $5 $file $7$outname;
			fi
		done
		echo ����ѹ�����;
	elif [[ $3 == -cr ]];then
		echo ѹ���ֱ���;
		for file in $2
		do
			na=$file;
			na1=.jpg;
			na2=.png;
			na3=.svg;
			outname=${na##};
			if [[ $file == $na1  $file == $na2  $file == $na3 ]];then
				convert -resize $5 $file $7$outname;
			fi
		done
		echo �ȱ���ѹ���ֱ������;
	elif [[ $3 == -w ]];then
		echo ����Զ����ı�ˮӡ;
		for file in $2
		do
			na=$file;
			outname=${na##};
			convert $file -draw text $5 $4 $7$outname;
		done
		echo �Զ����ı�������;
	elif [[ $3 == -rn ]];then
		echo ������;
		for file in $2
		do
			na=$file;
			outname=${na##}
			if [[ $4 == -f ]];then
				newname=$7$5$outname;
			elif [[ $4 == -b ]];then
				newname=$7$outname$5;
			else
				echo �������-h�鿴����;
			fi
			mv $file $newname;
		done
		echo ���������;
	elif [[ $3 == -jpg ]];then
		echo ת��Ϊjpg��ʽͼƬ;
		for file in $2
		do
			na=$file;
			na1=.png;
			na2=.svg;
			na3=.jpg;
			outname=${na##};
			outname1=${outname%%.};
			if [[ $file == $na1  $file == $na2 ]];then
				echo $outname1;
				convert $file $5$outname1$na3;
			fi
		done
		echo ת����jpg;
	else
		echo �������-h�鿴������
	fi
else
	echo �������-h�鿴����;
fi