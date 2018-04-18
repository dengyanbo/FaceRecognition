# FaceRecognition

Motivation
We are going to design and implement a face recognition system by using images of human faces on MATLAB. Then test our system and generate genuine and imposter distribution, ROC curve and CMC curve to evaluate the performance of the system.
Achievement
We separate our data set into two parts: one is set to the gallery and the other is used for testing. Our System achieves an overall 82.62% Recognition Rate of face recognition with our data set. This is done by python script.

We choose the basic algorithm PCA to implement our face recognition. The procedure of the algorithm is followed:
•	Read in face data and convert them into vectors. Connect those vectors into a matrix which could represent the whole gallery.
•	Subtract the matrix by its mean vector (mean face) to enhance the distinctive features.
•	Compute the covariance matrix of the enhanced matrix
•	Compute the eigenvectors and eigenvalues of the covariance matrix to generate an eigen space.
•	Select several eigenvectors (eigenfaces) as the patterns to train our model
•	Compute the Manhattan Distance as the matching score.
In our system, the number of eigenvectors we chose as the patterns is 198, which provide a 90% weight of the eigenvalues of our eigen space.
