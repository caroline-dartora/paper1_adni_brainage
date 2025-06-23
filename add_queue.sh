output_path="/scratch/caroline/papers/ongoing/project00/ADNI_analysis/data/images/PET/processed/"

tail -n +1 "${1}" | while IFS=, read -r Individual freesurfer_6_0_0_aparc_thickness_GUID; do

    echo "Running $Individual"
    config_file="/scratch/caroline/papers/ongoing/project00/ADNI_analysis/code/pet_process/config_${Individual}.sh"
    echo "qsub -q all.q@saga.cgland -S /bin/bash -cwd petprocess.sh -p ${Individual} -f ${freesurfer_6_0_0_aparc_thickness_GUID} -o ${output_path} -g ${Individual} -s ${config_file}"
    
done
