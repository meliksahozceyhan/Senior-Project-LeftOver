import { Body, Controller, Get, Post } from '@nestjs/common';
import { MapService } from './map.service';
import { Map } from './entity/map.entity'
import { Crud, CrudController } from '@nestjsx/crud';

@Crud({
	model: {
		type: Map
	}
})

@Controller('map')
export class MapController implements CrudController<Map> {
  constructor(public service: MapService) {}

    @Get('/getLocations')
	public async getLocations() {
		return 'My Location'
	}
}