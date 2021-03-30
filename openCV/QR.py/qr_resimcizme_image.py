import cv2
import math
import numpy as np 
from matplotlib import pyplot as plt


# resim acma 
image = cv2.imread('alan_resmi.png')

qrCodeDetector = cv2.QRCodeDetector()
decodedText,points,_ = qrCodeDetector.detectAndDecode(image)

qr_data = decodedText.split(',')

# deger kontrolu
print('decodedText is :', decodedText)
print('points are : ', points)
print('qr_data len', len(qr_data))
print('what is qr_data', qr_data)
print('what are len of points : ', len(points))



top_left = points[0][0]
top_right = points[0][1]
bottom_right = points[0][2]
bottom_left = points[0][3]

print('top_left point is: ', top_left)
print('top_right points is: ', top_right)
print('bottom_right point is: ', top_right)
print('bottom_left points is: ', top_left)
print('points size: ', points.size)
print('print tuple 0 0 : ', tuple(points[0][0]))
print('print tuple 0 1 : ', tuple(points[0][1]))
print('print tuple 0 2 : ', tuple(points[0][2]))
print('print tuple 0 3 : ', tuple(points[0][3]))

if points is not None:
    pts = int(points.size/2)
    print('size', pts)
    


    for i in range(pts):
        nextPointIndex = (i+1) % pts
        print('next point is : ', nextPointIndex)
        cv2.line(image,tuple(points[0][i]),tuple(points[0][nextPointIndex]),(255,0,255),5)
        print(points[0][i])      

else:
    print('QR not detected')




"""
# resim gosterme 
cv2.imshow('alan',image)
"""

plt.subplot(111)
plt.imshow(image)
plt.title('stage1')

plt.show()


cv2.waitKey(0)
cv2.destroyAllWindows()