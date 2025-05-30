<center>

[comment]: <img src="./media/media/image1.png" style="width:1.088in;height:1.46256in" alt="escudo.png" />

![./media/media/image1.png](./media/logo-upt.png)

**UNIVERSIDAD PRIVADA DE TACNA**

**FACULTAD DE INGENIERIA**

**Escuela Profesional de Ingeniería de Sistemas**

**Proyecto de Sistema Fit Match***

Curso: *Calidad y Pruebas de Software*

Docente: *Patrick Cuadros Quiroga*

Integrantes:

    Luna Juarez, Juan Brendon 			(2020068762)
    Vargas Gutierrez, Angel Jose 		(2020066922)
    Chino Rivera, Angel Alessandro 		(2021069830)
    

**Tacna – Perú**

***2025***


</center>
<div style="page-break-after: always; visibility: hidden"></div>

Sistema *Sistema Fit Match*

Informe de Factibilidad

Versión *{1.0}*

|CONTROL DE VERSIONES||||||
| :-: | :- | :- | :- | :- | :- |
|Versión|Hecha por|Revisada por|Aprobada por|Fecha|Motivo|
|1\.0|MPV|ELV|ARV|10/10/2020|Versión Original|

<div style="page-break-after: always; visibility: hidden">\pagebreak</div>

# **INDICE GENERAL**

[1. Descripción del Proyecto](#_Toc52661346)

[2. Riesgos](#_Toc52661347)

[3. Análisis de la Situación actual](#_Toc52661348)

[4. Estudio de Factibilidad](#_Toc52661349)

[4.1 Factibilidad Técnica](#_Toc52661350)

[4.2 Factibilidad económica](#_Toc52661351)

[4.3 Factibilidad Operativa](#_Toc52661352)

[4.4 Factibilidad Legal](#_Toc52661353)

[4.5 Factibilidad Social](#_Toc52661354)

[4.6 Factibilidad Ambiental](#_Toc52661355)

[5. Análisis Financiero](#_Toc52661356)

[6. Conclusiones](#_Toc52661357)


<div style="page-break-after: always; visibility: hidden">\pagebreak</div>

**<u>Informe de Factibilidad</u>**

1. <span id="_Toc52661346" class="anchor"></span>**Descripción del Proyecto**

    1.1. Nombre del proyecto<br>
    <br>
         - Sistema Fit Match.
<br>
    1.2. Duración del proyecto<br>
       <br>
       - 5 meses
   <br>
    1.3. Descripción

   El proyecto consiste en el desarrollo de una aplicación de emparejamiento en gimnasio que permitirá a los usuarios hacer match     de acuerdo a sus preferencias para encontrar un compañero para entrenar.

         

    1.4. Objetivos

        1.4.1 Objetivo general
   
               Desarrollar una aplicación web que potenciarea de entrenamiento físico que
               permita a los usuarios hacer match con un compañero para potenciar sus entrenamientos.
   
        1.4.2 Objetivos Específicos
   
               Crear perfiles personalizados para los usuarios

               Permitir a los usuarios registrar su información personal, 
               preferencias de entrenamiento, historial de actividad y objetivos físicos.
                
               Implementar un sistema de mensajería 
                
               Desarrollar un chat interno o integración con sistemas de mensajería para que los usuarios puedan coordinar sus entrenamientos.
                 
               Optimizar la experiencia del usuario (UX/UI)
                
               Diseñar una interfaz intuitiva y atractiva para mejorar la navegación y la accesibilidad. 
                
               Desarrollar una versión escalable
               Planificar una arquitectura escalable para futuras mejoras y aumento de usuarios




<div style="page-break-after: always; visibility: hidden"></div>

2. <span id="_Toc52661347" class="anchor"></span>**Riesgos**

        Riesgo Técnico: Posible dificultad para integrar correctamente la interfaz de Windows
        Forms con SQL Server, lo cual podría retrasar el desarrollo.
   
        Riesgo Financiero: Incremento en los costos estimados debido a ajustes adicionales
        en el diseño o funcionalidades de la aplicación.
   
        Riesgo de Seguridad: Posibles vulnerabilidades en la protección de datos de los
        usuarios, que podrían impactar en la confianza y aceptación de la aplicación.

        Riesgo Operativo: Que los usuarios no encuentren la aplicación lo suficientemente
        intuitiva, afectando la adopción y uso continuo de la herramienta.
       
        Riesgo de Cumplimiento: Cambios en normativas de privacidad y seguridad de datos
        que podrían requerir ajustes en la aplicación.

        Riesgo de Competencia: Aparición de aplicaciones similares en el mercado que
        ofrecen más funcionalidades o mejores prestaciones.


<div style="page-break-after: always; visibility: hidden"></div>

3. <span id="_Toc52661348" class="anchor"></span>**Análisis de la Situación actual**

    3.1. Planteamiento del problema

            Muchos usuarios no ven progresos o avances en el gimnasio en cuanto a su
            físico por que no llevan un registro en         cuanto a los pesos que cargan en el
            gimnasio o un registro de la cantidad de calorías en el gimnasio.

    3.2. Consideraciones de hardware y software

            Hardware
                Computadoras de escritorio o laptops con sistema operativo Windows,
                con al menos 4 GB de RAM y 10 GB de espacio disponible en disco, para
                asegurar el rendimiento óptimo de la aplicación.

            Software
                Sistema Operativo: Windows 10 o superior.
   
                Entorno de Desarrollo: Visual Studio para el desarrollo en Windows
                Forms, ya que proporciona herramientas robustas para la creación de
                aplicaciones de escritorio en C#.

                Base de Datos: SQL Server para el almacenamiento de información de
                usuarios y rutinas, seleccionado por su capacidad de manejar datos de
                manera segura y eficiente.

                Librerías y Componentes: Se considerarán librerías para la
                implementación de gráficos de progreso y otros elementos visuales
                interactivos.


<div style="page-break-after: always; visibility: hidden">\pagebreak</div>

4. <span id="_Toc52661349" class="anchor"></span>**Estudio de
    Factibilidad**

    Describir los resultados que esperan alcanzar del estudio de factibilidad, las actividades que se realizaron para preparar la evaluación de factibilidad y por quien fue aprobado.

    4.1. <span id="_Toc52661350" class="anchor"></span>Factibilidad Técnica

        El estudio de viabilidad técnica se enfoca en obtener un entendimiento de los recursos tecnológicos disponibles actualmente y su aplicabilidad a las necesidades que se espera tenga el proyecto. En el caso de tecnología informática esto implica una evaluación del hardware y software y como este puede cubrir las necesidades del sistema propuesto.

        Realizar una evaluación de la tecnología actual existente y la posibilidad de utilizarla en el desarrollo e implantación del sistema.*

        Describir acerca del hardware (equipos, servidor), software (aplicaciones, navegadores, sistemas operativos, dominio, internet, infraestructura de red física, etc.

    4.2. <span id="_Toc52661351" class="anchor"></span>Factibilidad Económica

        El propósito del estudio de viabilidad económica, es determinar los beneficios económicos del proyecto o sistema propuesto para la organización, en contraposición con los costos.
        Como se mencionó anteriormente en el estudio de factibilidad técnica wvaluar si la institución (departamento de TI) cuenta con las herramientas necesarias para la implantación del sistema y evaluar si la propuesta requiere o no de una inversión inicial en infraestructura informática.
        Se plantearán los costos del proyecto.
        Costeo del Proyecto: Consiste en estimar los costos de los recursos Humanos, materiales o consumibles y/o máquinas) directos para completar las actividades del proyecto}.*

        Definir los siguientes costos:

        4.2.1. Costos Generales

                Los costos generales son todos los gastos realizados en accesorios y material de oficina y de uso diario, necesarios para los procesos, tales como, papeles, plumas, cartuchos de impresora, marcadores, computadora etc. Colocar tabla de costos.

        4.2.2. Costos operativos durante el desarrollo 
        
                Evaluar costos necesarios para la operatividad de las actividades de la empresa durante el periodo en el que se realizara el proyecto. Los costos de operación pueden ser renta de oficina, agua, luz, teléfono, etc.

        4.2.3. Costos del ambiente

                Evaluar si se cuenta con los requerimientos técnicos para la implantación del software como el dominio, infraestructura de red, acceso a internet, etc.

        4.2.4. Costos de personal

                Aquí se incluyen los gastos generados por el recurso humano que se necesita para el desarrollo del sistema únicamente.

                No se considerará personal para la operación y funcionamiento del sistema.

                Incluir tabla que muestra los gastos correspondientes al personal.

                Indicar organización y roles. Indicar horario de trabajo del personal.

        4.2.5.  Costos totales del desarrollo del sistema

                {Totalizar costos y realizar resumen de costo final del proyecto y la forma de pago.

    4.3. <span id="_Toc52661352" class="anchor"></span>Factibilidad Operativa

        Describir los beneficios del producto y si se tiene la capacidad por parte del cliente para mantener el sistema funcionando y garantizar el buen funcionamiento y su impacto en los usuarios. Lista de interesados.

    4.4. <span id="_Toc52661353" class="anchor"></span>Factibilidad Legal

        Determinar si existe conflicto del proyecto con restricciones legales como leyes y regulaciones del país o locales relacionadas con seguridad, protección de datos, conducta de negocio, empleo y adquisiciones.

    4.5. <span id="_Toc52661354" class="anchor"></span>Factibilidad Social 

        Evaluar influencias y asuntos de índole social y cultural como el clima político, códigos de conducta y ética*

    4.6. <span id="_Toc52661355" class="anchor"></span>Factibilidad Ambiental

        Evaluar influencias y asuntos de índole ambiental como el impacto y repercusión en el medio ambiente.

<div style="page-break-after: always; visibility: hidden">\pagebreak</div>

5. <span id="_Toc52661356" class="anchor"></span>**Análisis Financiero**

    El plan financiero se ocupa del análisis de ingresos y gastos asociados a cada proyecto, desde el punto de vista del instante temporal en que se producen. Su misión fundamental es detectar situaciones financieramente inadecuadas.
    Se tiene que estimar financieramente el resultado del proyecto.

    5.1. Justificación de la Inversión

        5.1.1. Beneficios del Proyecto

            El beneficio se calcula como el margen económico menos los costes de oportunidad, que son los márgenes que hubieran podido obtenerse de haber dedicado el capital y el esfuerzo a otras actividades.
            El beneficio, obtenido lícitamente, no es sólo una recompensa a la inversión, al esfuerzo y al riesgo asumidos por el empresario, sino que también es un factor esencial para que las empresas sigan en el  mercado e incorporen nuevas inversiones al tejido industrial y social de las naciones.
            Describir beneficios tangibles e intangibles*
            Beneficios tangibles: son de fácil cuantificación, generalmente están relacionados con la reducción de recursos o talento humano.
            Beneficios intangibles: no son fácilmente cuantificables y están relacionados con elementos o mejora en otros procesos de la organización.
>
            Ejemplo de beneficios:

            - Mejoras en la eficiencia del área bajo estudio.
            - Reducción de personal.
            - Reducción de futuras inversiones y costos.
            - Disponibilidad del recurso humano.
            - Mejoras en planeación, control y uso de recursos.
            - Suministro oportuno de insumos para las operaciones.
            - Cumplimiento de requerimientos gubernamentales.
            - Toma acertada de decisiones.
            - Disponibilidad de información apropiada.
            - Aumento en la confiabilidad de la información.
            - Mejor servicio al cliente externo e interno
            - Logro de ventajas competitivas.
            - Valor agregado a un producto de la compañía.
        
        5.1.2. Criterios de Inversión

            5.1.2.1. Relación Beneficio/Costo (B/C)

                En base a los costos y beneficios identificados se evalúa si es factible el desarrollo del proyecto. 
                Si se presentan varias alternativas de solución se evaluará cada una de ellas para determinar la mejor solución desde el punto de vista del > retorno de la inversión
                El B/C si es mayor a uno, se acepta el proyecto; si el B/C es igual a uno es indiferente aceptar o rechazar el proyecto y si el B/C es menor a uno se rechaza el proyecto

            5.1.2.2. Valor Actual Neto (VAN)
            
                Valor actual de los beneficios netos que genera el proyecto. Si el VAN es mayor que cero, se acepta el proyecto; si el VAN es igual a cero es indiferente aceptar o rechazar el proyecto y si el VAN es menor que cero se rechaza el proyecto

            5.1.2.3 Tasa Interna de Retorno (TIR)*
                Es la tasa porcentual que indica la rentabilidad promedio anual que genera el capital invertido en el proyecto. Si la TIR es mayor que el costo de oportunidad se acepta el proyecto, si la TIR es igual al costo de oportunidad es indiferente aceptar o rechazar el proyecto, si la TIR es menor que el costo de oportunidad se rechaza el proyecto

                Costo de oportunidad de capital (COK) es la tasa de interés que podría haber obtenido con el dinero invertido en el proyecto

<div style="page-break-after: always; visibility: hidden">\pagebreak</div>

6. <span id="_Toc52661357" class="anchor"></span>**Conclusiones**

Explicar los resultados del análisis de factibilidad que nos indican si el proyecto es viable y factible.
