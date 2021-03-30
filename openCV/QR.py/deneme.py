import cv2
import math

c=cv2.VideoCapture(0)
qr=cv2.QRCodeDetector()

while True:
    _,frame=c.read()
    #frame = cv2.cvtColor(frame,cv2.COLOR_BGR2GRAY)
    
    #_,frame=cv2.threshold(frame,0,255,cv2.THRESH_OTSU)
    decodedText, points, _ = qr.detectAndDecode(frame)
    qr_data = decodedText.split(',')
    qr_size = qr_data[0]
    top = qr_data[1]
    bottom = qr_data[2]
    right = qr_data[3]
    left = qr_data[4]

    if points is not None:
        pts=len(points)
        print(pts)

        for i in range(pts):
            nextPointIndex = (i+1) % pts
            cv2.line(image, tuple(points[i][0]), tuple(points[nextPointIndex][0]), (255,0,0), 5)
            print(points[i][0])

            width = int(math.sqrt((points[0][0][0]-points[1][0][0])**2 + (points[0][0][1]-points[1][0][1])**2))
            height = int(math.sqrt((points[1][0][0]-points[2][0][0])**2 + (points[1][0][1]-points[2][0][1])**2))

        # Compare the size
            if(width==qr_data[0] and height==qr_data[0]):
                print("Sizes are equal")
            else:
                print("Width and height  " + str(width) + "x" +  str(height) + "  not equal to " + str(qr_data[0]) + "x" + str(qr_data[0]))

        # Add the extension values to points and crop
            y = int(points[0][0][1]) - int(qr_data[1])
            x = int(points[0][0][0]) - int(qr_data[4])
            roi = image[y:y+height + int(qr_data[3]), x:x+width + int(qr_data[2])]
            print(decodedText) 

        # Compare the size
            if(width==qr_data[0] and height==qr_data[0]):
                print("Sizes are equal")
            else:
                print("Width and height  " + str(width) + "x" +  str(height) + "  not equal to " + str(qr_data[0]) + "x" + str(qr_data[0]))
    cv2.imshow("Cap", frame)    
    if (cv2.waitKey(1)&0xff==27):
        break
c.release()       


