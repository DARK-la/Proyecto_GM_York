-- CreateTable
CREATE TABLE `vehiculos` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `vehicleID` INTEGER NOT NULL,
    `positionVehicle` VARCHAR(255) NOT NULL,
    `colorVehicle` VARCHAR(255) NOT NULL,
    `engineState` BOOLEAN NOT NULL DEFAULT false,
    `locked` BOOLEAN NOT NULL DEFAULT false,
    `personajeId` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `vehiculos` ADD CONSTRAINT `vehiculos_personajeId_fkey` FOREIGN KEY (`personajeId`) REFERENCES `personajes_datos`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
