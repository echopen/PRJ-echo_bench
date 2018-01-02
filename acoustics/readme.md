Acoustics of mirrored waves
===========================

Problem description
-------------------

[./Problem_description.png](./Problem_description.png)

-   Problem 1: define the angles of all reflected and transmitted longitudinal
    (black vectors) and shear (red vectors) waves.

-   Problem 2: situate the echos, that is, the distance between the useful
    reflected wave and the echos

-   Problem 3: determine the magnitude of all vectors

Results
-------

-   Critical angle of longitudinal transmission Water-\>Copper : 19.4°

-   Critical angle of shear transmission Water-\>Copper : 39.7°

-   The incident angle (45°) is greater than the critical angles of longitudinal
    and shear transmission, therefore, there is no transmission of the incident
    wave into the copper layer, therefore no echo.

-   There is a direct shear reflection of 20.7°

(to reproduce the results, execute in Octave the script “acousticsOfMirrors.m”)

Open questions
--------------

-   Is the incident wave only longitudinal or also bears a shear component?

-   Information missing about the shear velocity of water and composite
    material. For water, I considered it to be equal to the longitudinal
    velocity. For composite material, I considered it to be the half of
    longitudinal velocity, as an analogy to copper.

Hypotheses
----------

**Propagation mode**. There are four modes of acoustic wave propagation:
longitudinal (compression), transverse (shear), surface (Rayleigh), plate (Lamb)
[1]. Surface and plate propagation occur in specific conditions and are note
considered here only longitudinal waves.

**Material**. All mediums are considered here to be homogeneous and isotropic.
That is, the elastic constant is equal in all directions and at any point of the
medium.

**Incident angle**. The incident wave meets the first boundary water/copper with
an angle of 45°.

Variables
---------

Compressional velocity (speed of longitudinal wave propagation, in m/s):

-   In copper :

    -   4660 [2]

    -   4760 (annealed) [6]

    -   4760 (annealed) [7]

    -   4660 [10]

    -   3560 [13]

-   In air:

    -   331.45 (dry) [6]

    -   331.2 (dry at 0°C) [8]

    -   331 [13]

-   In composite:

    -   4726 (Glass fiber-reinforced polyester composite) [9]

    -   3070 (graphite/epoxy) [10]

    -   2100 (L385:340 epoxy at 20°C) [11]

    -   2460 to 3170 (depending on thickness and material ratio) [14]

-   In water:

    -   1480 (at 20°C) [10]

    -   1483 (at 20°C) [12]

    -   1484 [8]

    -   1493 [13]

    -   1496 (distilled) [6]

Shear velocity (speed of shear wave propagation, in m/s):

-   In copper:

    -   2330 [2]

    -   2325 [6]

    -   2325 [7]

-   In composite:

    -   unknown

-   I water and air: no shear wave propagation

Acoustic impedence (in Ns/m³):

-   Copper:

    -   41.6e6 [3]

-   Air

    -   413 (at 20°C) [3]

-   Water

    -   1.48e6 [3]

Formula
-------

Share of the energy which is reflected at the boundary between two media of
acoustic impedences z1 and z2 [4]:

`((z2-z1)/(z2+z1))^2;`

Angle of the transmitted wave meeting the boundary between two media of
longitudinal wave velocities v1 and v2 at an angle alpha, derived from Snell’s
law [5]:

`asin (sin(incident_angle)*v2/v1)`

Critical angle of wave transmission:

`x = asin (v1/v2)`

References
----------

[1] https://www.slideshare.net/RakeshSingh125/minor-project-report-28478524, p
9-12

[2] https://www.slideshare.net/RakeshSingh125/minor-project-report-28478524, p
15

[3] https://www.slideshare.net/RakeshSingh125/minor-project-report-28478524, p
16

[4] https://www.slideshare.net/RakeshSingh125/minor-project-report-28478524, p
17

[5] https://www.slideshare.net/RakeshSingh125/minor-project-report-28478524, p
18

[6] http://www.rfcafe.com/references/general/velocity-sound-media.htm

[7] https://en.wikipedia.org/wiki/Speeds_of_sound_of_the_elements_(data_page)

[8] https://en.wikipedia.org/wiki/Speed_of_sound

[9] https://arxiv.org/ftp/arxiv/papers/1511/1511.04543.pdf

[10]
https://www.olympus-ims.com/de/ndt-tutorials/thickness-gage/appendices-velocities/

[11]
http://www.ndt.net/article/wcndt2004/pdf/materials_characterization/616_mchugh.pdf

[12] http://www.ondacorp.com/images/Liquids.pdf

[13] http://hyperphysics.phy-astr.gsu.edu/hbase/Tables/Soundv.html

[14]
http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.457.3039&rep=rep1&type=pdf

 

weitere infos
-------------

https://de.wikipedia.org/wiki/Snelliussches_Brechungsgesetz -\> Konvertierung
der Druckscwelle zur Scherschwelle

https://en.wikipedia.org/wiki/Snell%27s_law
