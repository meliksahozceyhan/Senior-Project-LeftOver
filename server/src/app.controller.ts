import { Controller, Get } from '@nestjs/common'
import { AppService } from './app.service'
import { SkipAuth } from './decorators/decorators'

@Controller()
export class AppController {
	constructor(private readonly appService: AppService) {}

	@Get()
	@SkipAuth()
	getHello(): string {
		return this.appService.getHello()
	}
}
