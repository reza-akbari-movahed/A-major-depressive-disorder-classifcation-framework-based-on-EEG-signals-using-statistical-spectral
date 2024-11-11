# A-major-depressive-disorder-classifcation-framework-based-on-EEG-signals-using-statistical-spectral
## Introducuion
This repository provides the implemented codes of “A major depressive disorder classification framework based on EEG signals using statistical, spectral, wavelet, functional connectivity, and nonlinear analysis” paper using Support Vector Machine with radial basis function (RBFSVM) kernel. This paper proposes a machine learning framework for MDD diagnosis, which uses different types of EEG-derived features. The features are extracted using statistical, spectral, wavelet, functional connectivity, and nonlinear analysis methods. The sequential backward feature selection (SBFS) algorithm is also employed to perform feature selection. Various classifier models are utilized to select the best one for the proposed framework. The more details of the paper are provided in the below link. <br />
https://doi.org/10.1016/j.jneumeth.2021.109209
## Dependencies
The codes are implemented using MATLAB R2019b in Windows platform.
## Dataset Link 
The preprocessed EEG signals is saved into a MAT file and can be downloaded using the below link. The label 1 refers to HC samples and the label -1 refers to MDD cases. <br />
https://drive.google.com/file/d/1A3Xyon397om1t5WxINzZzGMBjiaRd0d0/view?usp=sharing
## How to run 
1. Download the dataset using the provided link and copy it to the main directory of the project. 
2. Go to Feature Extraction folder and run Feature_Extraction_main_code.m in its directory. 
3. Go to Train and evaluate model folder and run Mfile.m to execute the proposed method based on 10-fold cross-validation.
## Citation 
If you use this repository, please cite it as:

@article{movahed2021major,
  title={A major depressive disorder classification framework based on EEG signals using statistical, spectral, wavelet, functional connectivity, and nonlinear analysis},
  author={Movahed, Reza Akbari and Jahromi, Gila Pirzad and Shahyad, Shima and Meftahi, Gholam Hossein},
  journal={Journal of Neuroscience Methods},
  volume={358},
  pages={109209},
  year={2021},
  publisher={Elsevier}
}


