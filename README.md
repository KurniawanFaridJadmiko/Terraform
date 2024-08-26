# terraform-botikaaz-virtual-machine

Modul untuk provision virtual machine dan child-child resource-nya di Azure.

Modul ini dapat mem-provision:

- Virtual Machine

    - Dapat memilih image
    - Hanya mengizinkan SSH key
    - Dengan dukungan attach satu atau lebih NIC (attach existing maupun buat baru)
    - Setiap NIC dapat di-attach satu atau lebih ip (public maupun private) (attach existing maupun buat baru)
    - Dapat attach data disk satu atau lebih (attach existing maupun buat baru)



    User dapat mengkostumisasi sebagian besar parameter yang diberikan oleh resource [`azurerm_linux_virtual_machine`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine).


## Naming

Modul ini mem-provision virtual machine mengikuti [naming convention Botika](https://wiki.botika.online/en/engineering/infrastructure/standard-infrastruktur#naming-convention).

Gunakan modul [app.terraform.io/BotikaDevOps/azure-regions/botikaaz](https://app.terraform.io/app/BotikaDevOps/registry/modules/private/BotikaDevOps/azure-regions/botikaaz) sebagai penamaan region. 

Referensi: 

- [https://dev.azure.com/Botika/terraform-modules/_git/terraform-botikagcp-compute-engine](https://dev.azure.com/Botika/terraform-modules/_git/terraform-botikagcp-compute-engine)
