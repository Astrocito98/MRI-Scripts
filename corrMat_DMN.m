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


%Corteza preLimbica(PrL)
atlas(atlas==462) = 461;

#la mascara de PrL del atlas sigma incluye orbitofrontal ventral, lateral y rostromedial, considerar separar para crear una mascara de orbital y otra  prelimbica dorsomedial

%Corteza del Cingulo(Cg)
atlas(atlas==502) = 501;
atlas(atlas==701) = 501;
atlas(atlas==702) = 501;

%%
%Corteza Auditiva/Temporal de asociación (Au/TeA)
atlas(atlas==492) = 491;
atlas(atlas==681) = 491;
atlas(atlas==682) = 491;
atlas(atlas==691) = 491;
atlas(atlas==692) = 491;
atlas(atlas==771) = 491;
atlas(atlas==772) = 491;

%%Corteza parietal de asociación
%Corteza Parietal Posterior(PPC)
atlas(atlas==312) = 311;
atlas(atlas==381) = 311;
atlas(atlas==382) = 311;
atlas(atlas==401) = 311;
atlas(atlas==402) = 311;

%Corteza parietal anteromedial
atlas(atlas==282) = 281;
atlas(atlas==391) = 281;
atlas(atlas==392) = 281;

#Ademas, aunque se ve actividad 

%Corteza Visual Primaria(V1)
#atlas(atlas==622) = 621;
#atlas(atlas==631) = 621;
#atlas(atlas==632) = 621;
#atlas(atlas==641) = 621;
#atlas(atlas==642) = 621;

#El articulo de componentes fiuncionales de la DMN en ratas incluye la corteza visual primaria

%Corteza Visual Secundaria Medial (V2M)
atlas(atlas==322) = 321;
atlas(atlas==331) = 321;
atlas(atlas==332) = 321;

%%
%Corteza Retrosplenial(RSC)
atlas(atlas==652) = 651;
atlas(atlas==661) = 651;
atlas(atlas==662) = 651;
atlas(atlas==671) = 651;
atlas(atlas==672) = 651;

#Aunque el articulo de DMN en ratas solo menciona cingulo y RSCX, las imagenes de actividad cerebral parecen abarcar corteza motora secundaria, considerar incluir en el analisis

%%
%Hipocampo Dorsal(HIPP)
atlas(atlas==72) = 71;
atlas(atlas==101) = 71;
atlas(atlas==102) = 71;

#El articulo de DMN en ratas describe como parte solo la porción dorsal, considerar separar de la mascara la region ventral del hipocampo

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
