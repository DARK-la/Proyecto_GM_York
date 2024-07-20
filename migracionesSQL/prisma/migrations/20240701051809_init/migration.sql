/*
  Warnings:

  - You are about to drop the column `role` on the `cuenta_usuario` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `cuenta_usuario` DROP COLUMN `role`,
    MODIFY `serial` VARCHAR(191) NULL;
