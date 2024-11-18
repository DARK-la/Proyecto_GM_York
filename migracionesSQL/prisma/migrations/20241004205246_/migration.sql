/*
  Warnings:

  - Added the required column `placaAuto` to the `vehiculos` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `vehiculos` ADD COLUMN `placaAuto` VARCHAR(9) NOT NULL;
