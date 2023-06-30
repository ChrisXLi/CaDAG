MATLAB
### MAIN FUNCTIONS
function [g_skeleton, g_inv, gns, SP] = nonsta_cd_new(X,cond_ind_test,c_indx,maxFanIn,alpha, Type, pars)

 ### EXAMPLE 
CaDAG: example_for_seclect.m

### INPUT:  DATA.xlsx (normalized)
### OUTPUT: matrix g0 as a DAG structure
"g0(i,j)=1" means the i-th attribute is the parent node of the j-th attribute.

### REFERENCE

1.  Zhang, K., Huang, B., Zhang, J., Glymour, C., Scholkopf, B.. Causal Discovery from Nonstationary/Heterogeneous Data: Skeleton Estimation and Orientation Determination. IJCAI 2017.
2.  Huang, B., Zhang, K., Zhang, J., Glymour, C., Scholkopf, B. Behind Distribution Shift: Mining Driving Forces of Changes and Causal Arrows. ICDM 2017.
3.  Huang, B., Zhang, K., Zhang, J., Ramsey, J., Sanchez-Romero, R., Glymour, C., Scholkopf, B.. Causal Discovery from Heterogeneous/Nonstationary Data. JMLR, 21(89), 2020.

