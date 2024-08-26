# terraform-botikaaz-virtual-machine

Modul untuk provision virtual machine dan child-child resource-nya di Azure.

Modul ini dapat mem-provision:

- Virtual Machine

    - Dapat memilih image
    - Hanya mengizinkan SSH key
    - Dengan dukungan attach satu atau lebih NIC (attach existing maupun buat baru)
    - Setiap NIC dapat di-attach satu atau lebih ip (public maupun private) (attach existing maupun buat baru)
    - Dapat attach data disk satu atau lebih (attach existing maupun buat baru)