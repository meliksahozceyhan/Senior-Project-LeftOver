import { Injectable } from '@nestjs/common'
import { InjectRepository } from '@nestjs/typeorm'
import { TypeOrmCrudService } from '@nestjsx/crud-typeorm'
import { Repository } from 'typeorm'
import { Item } from './entity/item.entity'

@Injectable()
export class ItemService extends TypeOrmCrudService<Item> {
	constructor(@InjectRepository(Item) private readonly itemRepo: Repository<Item>) {
		super(itemRepo)
	}
}
