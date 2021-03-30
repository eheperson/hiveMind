import cv2
kamera=cv2.VideoCapture(0)
qr=cv2.QRCodeDetector()
#xyz
while True:
    _,frame=kamera.read()
    image=frame
    qrCodeDetector = cv2.QRCodeDetector()

    # gray & blur & thresh operation
    frame_gray = cv2.cvtColor(frame,cv2.COLOR_BGR2GRAY)
    blur = cv2.GaussianBlur(frame_gray,(9,9),0)
    thresh = cv2.threshold(blur,0,255,cv2.THRESH_BINARY_INV+cv2.THRESH_OTSU)

    # morp close

    kernel = cv2.getStructuringElement(cv2.MORPH_RECT, (5,5))
    close = cv2.morphologyEx(thresh, cv2.MORPH_CLOSE, kernel, iterations=2)

    # Find contours and filter for QR code
    cnts = cv2.findContours(close, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    cnts = cnts[0] if len(cnts) == 2 else cnts[1]
    for c in cnts:
        peri = cv2.arcLength(c, True)
        approx = cv2.approxPolyDP(c, 0.04 * peri, True)
        x,y,w,h = cv2.boundingRect(approx)
        area = cv2.contourArea(c)
        ar = w / float(h)
        if len(approx) == 4 and area > 1000 and (ar > .85 and ar < 1.3):
            cv2.rectangle(frame, (x, y), (x + w, y + h), (36,255,12), 3)
            ROI = original[y:y+h, x:x+w]

    #frame = cv2.cvtColor(frame,cv2.COLOR_BGR2GRAY)
    
    #_,frame=cv2.threshold(frame,0,255,cv2.THRESH_OTSU)
    decodedText, points, _ = qr.detectAndDecode(frame)
    if points is not None:
        nrOfPoints = len(points)
        for i in range(nrOfPoints):
            nextPointIndex = (i + 1) % nrOfPoints
            cv2.line(frame, tuple(points[i][0]), tuple(points[nextPointIndex][0]), (255, 0, 0), 5)
            font = cv2.FONT_HERSHEY_SIMPLEX
            cv2.putText(frame, decodedText, (140 , 50), font, .5, (0, 0, 0), 1, cv2.LINE_AA)
            
       
    cv2.imshow("Cap", ROI)
    
    if (cv2.waitKey(100) & 0xFF==ord('q')):
        break

c.release()