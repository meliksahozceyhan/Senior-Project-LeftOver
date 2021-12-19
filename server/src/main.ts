import { NestFactory } from '@nestjs/core'
import { AppModule } from './app.module'
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger'
import { QueryFailedExceptionFilter } from './filters/query-failed-exception.filter'

async function bootstrap() {
	const app = await NestFactory.create(AppModule)
	app.enableCors()

	app.useGlobalFilters(new QueryFailedExceptionFilter())
	const config = new DocumentBuilder().setTitle('Senior Project Left-Over! Swagger Page').setDescription('This Page is the Swagger OpenAPI documentation for project Lef-Over!').setVersion('1.0').addTag('Left-Over!').build()

	const document = SwaggerModule.createDocument(app, config)
	SwaggerModule.setup('swagger/api/v1', app, document)

	await app.listen(3000)
}
bootstrap()
