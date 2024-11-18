-- CreateTable
CREATE TABLE `cuenta_usuario` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `banned` BOOLEAN NOT NULL DEFAULT false,
    `online` BOOLEAN NOT NULL DEFAULT false,
    `email` VARCHAR(191) NOT NULL,
    `ip` VARCHAR(191) NULL,
    `serial` VARCHAR(191) NULL,
    `username` VARCHAR(191) NOT NULL,
    `password` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `lastOnline` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `cuenta_usuario_email_key`(`email`),
    UNIQUE INDEX `cuenta_usuario_username_key`(`username`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `personajes_datos` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `firstName` VARCHAR(191) NOT NULL,
    `lastName` VARCHAR(191) NOT NULL,
    `gender` ENUM('Hombre', 'Mujer') NOT NULL DEFAULT 'Hombre',
    `dead` BOOLEAN NOT NULL DEFAULT false,
    `age` INTEGER NOT NULL DEFAULT 18,
    `dni` INTEGER NOT NULL DEFAULT 0,
    `jail` BIGINT NOT NULL DEFAULT 0,
    `skin` BIGINT NOT NULL DEFAULT 0,
    `health` DOUBLE NOT NULL DEFAULT 100.0,
    `positionPlayer` VARCHAR(191) NOT NULL DEFAULT '[[0,0,0,0,0]]',
    `moneyPlayer` BIGINT NOT NULL DEFAULT 1000,
    `bankMoney` BIGINT NOT NULL DEFAULT 0,
    `ownerId` INTEGER NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `vehiculos` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `vehicleID` INTEGER NOT NULL,
    `positionVehicle` VARCHAR(255) NOT NULL,
    `colorVehicle` VARCHAR(255) NOT NULL,
    `engineState` BOOLEAN NOT NULL DEFAULT false,
    `locked` BOOLEAN NOT NULL DEFAULT false,
    `health` SMALLINT UNSIGNED NOT NULL DEFAULT 1000,
    `personajeId` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `personajes_datos` ADD CONSTRAINT `personajes_datos_ownerId_fkey` FOREIGN KEY (`ownerId`) REFERENCES `cuenta_usuario`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `vehiculos` ADD CONSTRAINT `vehiculos_personajeId_fkey` FOREIGN KEY (`personajeId`) REFERENCES `personajes_datos`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
