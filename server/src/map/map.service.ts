import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { TypeOrmCrudService } from '@nestjsx/crud-typeorm';
import { getRepository, Repository } from 'typeorm';
import { Map } from './entity/map.entity'

@Injectable()
export class MapService extends TypeOrmCrudService<Map>{
    private mapRepo = getRepository(Map)
    constructor(@InjectRepository(Map) private readonly mapRepository: Repository<Map>) {
		super(mapRepository)
	}

    // public async getAllLocations(): Promise<Map[]> {
	// 	return await this.mapRepo
	// }
}
