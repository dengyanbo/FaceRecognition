import os
import math
import shutil

def look_over(BASE_PATH):
    SEPARATOR=";"
    label = 0
    dataset = []
    b = []
    for dirname, dirnames, filenames in os.walk(BASE_PATH):
        for subdirname in dirnames:
            subject_path = os.path.join(dirname, subdirname)
            title3 = 'Train_data'
            title4 = 'Test_data'
            sp3 = os.path.join(subject_path, title3)
            sp4 = os.path.join(subject_path, title4)
            os.mkdir(sp3)
            os.mkdir(sp4)
            if os.path.exists(sp3) or os.path.exists(sp4):
                continue
            for filename in os.listdir(subject_path):
                s3 = os.path.join(sp3, filename)
                s4 = os.path.join(sp4, filename)
                abs_path = "%s/%s" % (subject_path, filename)
#                print(abs_path)
#                b = "%s%s%d" % (abs_path, SEPARATOR, label)
                if filename[-5] != '_':
                    if int(filename[-5]) % 2 == 1:
                        shutil.move(abs_path,sp3)
                    elif int(filename[-5]) % 2 == 0:
                        shutil.move(abs_path,sp4)

look_over("F:/face_data")