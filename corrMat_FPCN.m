%% Generar Matrices de correlacion y comparar, ratas de Lau

%% Set Path

%addpath(genpath('navalj@penfield.inb.unam.mx/misc/jasper/alcauter/MATLABscripts'));

%cd /mnt/Data/RAT_fMRI/LauraMonica/Nifti_Analysis_Edad/ppBOLD
%cd /misc/cannabis/alcauter/LauraMonica/Nifti_Analysis_Edad_2020/ppBold
%cd navalj@penfield.inb.unam.mx/misc/geminis/navalj/prueba/Nifti_Analysis_prueba/ppBOLD
cd /media/ageinglab/Expansion/Analisis_AGMOT/18m_Ctrl/

%% Read data

%atlas = load_Data('/mnt/Data/RAT_fMRI/Templates_Rat/TohokuUniv/correctOrientation/atlas_TohokuWHSsubcGM_combined_5mm.nii.gz');
atlas = load_Data('/media/ageinglab/Expansion/Atlas/SIGMA_Brain/SIGMA2Tohoku-WHS/SIGMA_InVivo_Anatomical_Brain_Atlas_reoriented_5mm.nii.gz');
%labels = unique(atlas);

%Lateral Fronto parietal-Control Network

% Corteza Frontal de Asociación (FrA)
atlas(atlas==112) = 111;

%Dorsolateral prefrontal
atlas(atlas==112) = 111;
atlas(atlas==361) = 111;
atlas(atlas==362) = 111;

%Corteza Parietal Posterior(PPC)
atlas(atlas==312) = 311;
atlas(atlas==381) = 311;
atlas(atlas==382) = 311;
atlas(atlas==401) = 311;
atlas(atlas==402) = 311;

%%Cingulo insular - Saliencia Network
%Corteza del Cingulo(Cg)
atlas(atlas==502) = 501;
atlas(atlas==701) = 501;
atlas(atlas==702) = 501;

%Insula anterior agranular (Ia)
atlas(atlas==1002)=1001;
atlas(atlas==1003)=1001;
atlas(atlas==1049)=1001;
atlas(atlas==1050)=1001;
atlas(atlas==1051)=1001;



% 9 ROIS
% labels= Orb, PrL, Cg, Au/TeA, PPC, V1, V2M, RSC, HIPP
labels=[111, 461, 501, 491, 281, 621, 321,651, 71];

nonWntedLabels= [0];
gps=[ones(1,4) 2*ones(1,4) 3*ones(1,4)];

for i=1:length(nonWntedLabels)
    labels(labels==nonWntedLabels(i))=[];
end

Data=load5D_Data_cell('*_aCCtf_sm425.nii.gz');

%% Get Matrices

cMats=corrMat_atlas(Data,atlas,labels);
% cMats=partialcorrMat_atlas(Data,atlas,labels);

cMats_thr=cMats;
thr=0;
cMats_thr(cMats<thr)=0;

cMats_thr=cMats2Z(cMats_thr);
cMats_thr(cMats<0)=0;
cMats_thr(isinf(cMats_thr))=max(cMats_thr(:)~=inf);
