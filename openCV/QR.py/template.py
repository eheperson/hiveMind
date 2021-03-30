import cv2 as cv
import numpy as np
from matplotlib import pyplot as plt

img = cv.imread('qr_org.png',0)
img2 = img.copy()
template = cv.imread('qr.png',0)
w, h = template.shape[::-1]
# All the 6 methods for comparison in a list
methods = ['cv.TM_CCOEFF', 'cv.TM_CCOEFF_NORMED', 'cv.TM_CCORR',
            'cv.TM_CCORR_NORMED', 'cv.TM_SQDIFF', 'cv.TM_SQDIFF_NORMED']
for meth in methods:
    img = img2.copy()
    method = eval(meth)
    # Apply template Matching
    res = cv.matchTemplate(img,template,method)
    min_val, max_val, min_loc, max_loc = cv.minMaxLoc(res)
    # If the method is TM_SQDIFF or TM_SQDIFF_NORMED, take minimum
    if method in [cv.TM_SQDIFF, cv.TM_SQDIFF_NORMED]:
        top_left = min_loc
    else:
        top_left = max_loc
    
    bottom_right = (top_left[0] + w, top_left[1] + h)
    cv.rectangle(img,top_left, bottom_right, 255, 2)
    kirpilmis = img[top_left[1]:bottom_right[1],top_left[0]:bottom_right[0]]
    print(top_left)
    print(bottom_right)
    plt.subplot(231),plt.imshow(res,cmap = 'gray')
    plt.title('Matching Result'), plt.xticks([]), plt.yticks([])
    plt.subplot(232),plt.imshow(img,cmap = 'gray')
    plt.title('Detected Point'), plt.xticks([]), plt.yticks([])
    plt.subplot(233),plt.imshow(kirpilmis,cmap= 'gray')
    plt.title('Crop Rectangle'), plt.xticks([]), plt.yticks([])
    plt.subplot(234),plt.imshow(img,cmap= 'gray')
    plt.title('orginal'), plt.xticks([]), plt.yticks([])

    plt.suptitle(meth)
    plt.show()
    
    """
    kirpilmis = img[top_left,bottom_right]
    cv.imshow('kirpilmis' ,kirpilmis)
    cv.waitKey(0)
    cv.destroyAllWindows()
    """





