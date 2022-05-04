import { Module } from '@nestjs/common';
import { MapService } from './map.service';
import { MapController } from './map.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Map } from './entity/map.entity'

@Module({
  imports: [TypeOrmModule.forFeature([Map])],
  controllers: [MapController],
  providers: [MapService]
})
export class MapModule {}
