import csv
import re
import os

log_folder="C:/LogsTelemetria/"
log_file=""

staging_columns = [
    'raw_episodio', 'raw_mapa', 'raw_sector', 'raw_jugador', 'raw_sesion',
    'raw_tic', 'raw_numero_tic', 'raw_timestamp_ms', 'raw_pos_x', 'raw_pos_y',
    'raw_pos_z', 'raw_angulo_vision', 'raw_momentum_dx', 'raw_momentum_dy',
    'raw_velocidad', 'raw_salud', 'raw_armadura', 'raw_municion_balas',
    'raw_municion_escopeta', 'raw_municion_cohetes', 'raw_municion_celulas'
]

current_episode = ""
current_map = ""

archivos = os.listdir(log_folder)
for log_file in archivos:
    with open("{0}{1}".format(log_folder,log_file), 'r') as infile, open("{0}{1}.csv".format(log_folder,log_file.split(".")[0]), 'w', newline='') as outfile:
        writer = csv.writer(outfile, delimiter=',')
        for line_num, line in enumerate(infile, 1):
            line = line.strip()
            if not line:
                continue
            print(line)
            if line.startswith("When:"):
                print(line)
                ep_match = re.search(r'Episode:\s*(\d+)', line)
                map_match = re.search(r'Map:\s*(\d+)', line)
                
                if ep_match: 
                    current_episode = ep_match.group(1)
                if map_match: 
                    current_map = map_match.group(1)
                    
                print(f"[Línea {line_num}] Cambio de nivel detectado -> Episodio: {current_episode}, Mapa: {current_map}")
                continue
            if line.startswith("timestamp"):
                continue
            parts = re.split(r'\t+|\s{2,}', line)
            if len(parts) >= 12:
                row_data = {col: '' for col in staging_columns}
                row_data['raw_episodio'] = current_episode
                row_data['raw_mapa'] = current_map
                row_data['raw_timestamp_ms'] = parts[0]
                row_data['raw_numero_tic'] = parts[1]
                row_data['raw_pos_x'] = parts[2]
                row_data['raw_pos_y'] = parts[3]
                row_data['raw_pos_z'] = parts[4]
                row_data['raw_angulo_vision'] = parts[5]
                row_data['raw_momentum_dx'] = parts[6]
                row_data['raw_momentum_dy'] = parts[7]
                row_data['raw_armadura'] = parts[8]
                row_data['raw_salud'] = parts[9]
                row_data['raw_municion_balas'] = parts[10]
                row_data['raw_sector'] = parts[11] # ej. (0,0)
                
                writer.writerow([row_data[col] for col in staging_columns])
print("Archivos CSV generados exitosamente.")
        
    
    
