"""
limpiar_telemetria.py
Limpia los archivos TXT de Chocolate Doom:
- Elimina logs del sistema
- Elimina headers repetidos (When:, timestamp)
- Deja solo UN header + todos los datos de telemetria

USO: python limpiar_telemetria.py
"""

import os

CARPETA = r'C:\Users\ZBOOK\OneDrive\LogsTelemetria'

archivos = [
    'nicolas.txt',
    'Davidg.txt',
    'gaby.12.txt',
    'Juanes.txt',
    'Juan.txt',
    'Lindsay.txt',
]

for archivo in archivos:
    ruta_entrada = os.path.join(CARPETA, archivo)
    nombre_sin_ext = os.path.splitext(archivo)[0]
    ruta_salida = os.path.join(CARPETA, nombre_sin_ext + '_clean.txt')

    try:
        with open(ruta_entrada, 'r', encoding='utf-8', errors='ignore') as f:
            lineas = f.readlines()

        # Encontrar la primera linea de header
        header_linea = None
        for linea in lineas:
            if 'timestamp' in linea.lower() and 'tic' in linea.lower():
                header_linea = linea
                break

        if header_linea is None:
            print(f"ERROR: No se encontro header en {archivo}")
            continue

        # Guardar solo el header una vez + las filas de datos reales
        # Una fila de datos empieza con una fecha (2026-...)
        lineas_limpias = [header_linea]
        for linea in lineas:
            stripped = linea.strip()
            # Es dato si empieza con año (timestamp real)
            if stripped.startswith('2026') or stripped.startswith('2025') or stripped.startswith('2024'):
                lineas_limpias.append(linea)

        with open(ruta_salida, 'w', encoding='utf-8') as f:
            f.writelines(lineas_limpias)

        datos = len(lineas_limpias) - 1
        print(f"{archivo} -> {nombre_sin_ext}_clean.txt ({datos} filas de datos)")

    except FileNotFoundError:
        print(f"ERROR: No se encontro {ruta_entrada}")
    except Exception as e:
        print(f"ERROR en {archivo}: {e}")

print("\nListo. Usa los archivos _clean.txt en el script de carga.")
