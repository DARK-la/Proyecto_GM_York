-- AlterTable
ALTER TABLE `personajes_datos` ADD COLUMN `bankMoney` BIGINT NOT NULL DEFAULT 0,
    MODIFY `moneyPlayer` BIGINT NOT NULL DEFAULT 1000;
