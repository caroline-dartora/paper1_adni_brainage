#!/bin/bash

# Set the base directory
BASE_DIR="/scratch/caroline/papers/ongoing/project00/ADNI_analysis/data/images/PET/processed"

# Set output file name
OUTPUT_FILE="all_pet_results.csv"

# Create a temporary directory for processing
TEMP_DIR=$(mktemp -d)

# Crate an output path
OUTPUT_PATH="/scratch/caroline/papers/ongoing/project00/ADNI_analysis/data/"

# Initialize the combined file with header from the first found CSV
FIRST_CSV=$(find "$BASE_DIR" -name "*_gtm_pet_pvc_pons_SUVR.csv" | head -n 1)
head -n 1 "$FIRST_CSV" > "$TEMP_DIR/$OUTPUT_FILE"

# Loop through all ID folders in processed directory
for id_dir in "$BASE_DIR"/*/; do
    if [ -d "$id_dir" ]; then
        ID=$(basename "$id_dir")
        SCALAR_DIR="$id_dir/scalar_output"
        
        if [ -d "$SCALAR_DIR" ]; then
            # Process all matching CSV files in this ID's scalar_output directory
            for file in "$SCALAR_DIR"/*_gtm_pet_pvc_pons_SUVR.csv; do
                if [ -f "$file" ]; then
                    tail -n +2 "$file" >> "$TEMP_DIR/$OUTPUT_FILE"
                fi
            done
        fi
    fi
done

# Move the final file to the current directory
mv "$TEMP_DIR/$OUTPUT_FILE" "$OUTPUT_PATH/$OUTPUT_FILE"

# Cleanup
rm -rf "$TEMP_DIR"

echo "All PET results have been combined into all_pet_results.csv"
echo "Output location: $OUTPUT_PATH$OUTPUT_FILE"