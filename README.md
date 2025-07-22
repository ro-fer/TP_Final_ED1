#  TP Final - Electrónica Digital I
Proyecto final de la materia **Electrónica Digital I** – ECyT, UNSAM  
Autora: **Rocío Belén Fernández**  
Cuatrimestre: 1° 2023

**Voltímetro digital con salida VGA**

## 📌 Objetivo
Este proyecto implementa un **voltímetro digital** que mide señales analógicas (0 V a 3,3 V) y muestra el valor en pantalla mediante **salida VGA**.  
Se desarrolló utilizando **VHDL** y fue probado en una **FPGA Arty A7-35T**. La arquitectura del sistema incluye bloques secuenciales, combinacionales y memoria ROM para caracteres.

## 🧱 Componentes principales

- `ffd.vhd`: Flip-Flop D con realimentación
- `reg_Nb.vhd`: Registro paralelo de N bits
- `c33K.vhd`: Contador binario hasta 3.300.000
- `BCD_counter.vhd`: Contador BCD de 0 a 9
- `cOnes.vhd`: Contador de unos en BCD (3 dígitos)
- `comp_Nb.vhd`: Comparador de N bits
- `mux.vhd`, `mux_color.vhd`, `mux_selector.vhd`: Multiplexores para selección de dígitos y símbolos
- `carac_rom.vhd`: ROM con caracteres 0-9, punto y unidad
- `vga_controller.vhd`: Controlador VGA con resolución 640x480
- `Voltimetro.vhd`: Integración de todos los bloques

## 🧪 Simulación y validación

Las simulaciones se realizaron en **Vivado 2022.2** y en *GTKWave*, verificando:

- El funcionamiento individual de cada bloque
- La correcta sincronización y conteo de señales
- La visualización estable del voltaje en pantalla

Se incluyen esquemas y simulaciones en el informe PDF dentro del repositorio.
## 🎬 Video de funcionamiento

![Video demo](./Material_audiovisual/voltimetro_funcionando.gif)


## 🛠️ Herramientas

- [Vivado 2022.2](https://www.xilinx.com/support/download.html)
- GTKWave
- FPGA: **Arty A7-35T**
- Frecuencia del sistema: 25 MHz (derivada del reloj de 100 MHz mediante MMCM o divisor)


## 📚 Informe final

📄 [Descargar informe (PDF)](./Informe/TP_Final_ED1_FernandezRocio_.docx.pdf)

Incluye:
- Objetivo y resumen
- Desarrollo de cada componente
- Diagramas y simulaciones por bloque
- Pruebas sobre la FPGA
## 🧑‍💻 Autora

**Rocío Belén Fernández**  
Estudiante de Ingeniería – UNSAM  
📧 rfernandez@estudiantes.unsam.edu.ar  
🔗 [@_biogeeks](https://instagram.com/_biogeeks)

---

💚 Gracias por visitar este proyecto. ¡Toda retroalimentación es bienvenida!