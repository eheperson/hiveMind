import cv2
c=cv2.VideoCapture(0)
qr=cv2.QRCodeDetector()
#xyz
while True:
    _,frame=c.read()
    #frame = cv2.cvtColor(frame,cv2.COLOR_BGR2GRAY)
    
    #_,frame=cv2.threshold(frame,0,255,cv2.THRESH_OTSU)
    decodedText, points, _ = qr.detectAndDecode(frame)

    
    
    if points is not None:
        nrOfPoints = len(points)
        #print("sacma", nrOfPoints)
        for i in range(nrOfPoints):
            nextPointIndex = (i + 1) % nrOfPoints
            #print("next", nextPointIndex)
            cv2.line(frame, tuple(points[i][0]), tuple(points[nextPointIndex][0]), (255, 0, 0), 5)
            font = cv2.FONT_HERSHEY_SIMPLEX
            cv2.putText(frame, decodedText, (140 , 50), font, .5, (0, 0, 0), 1, cv2.LINE_AA)
            print(decodedText)
    cv2.imshow("Cap", frame)
    if (cv2.waitKey(100)&0xff==27):
        break
c.release()