import { HttpException, HttpStatus, Module } from '@nestjs/common'
import { ImageService } from './image.service'
import { ImageController } from './image.controller'
import { extname } from 'path'
import { TypegooseModule } from 'nestjs-typegoose'
import { ImageModel } from './image.model'
import { MulterModule } from '@nestjs/platform-express'

const imageFilter = function (req, file, cb) {
	// accept image only
	if (!file.originalname.match(/\.(jpg|jpeg|png)$/)) {
		cb(new HttpException(`Unsupported file type ${extname(file.originalname)}`, HttpStatus.BAD_REQUEST), false)
	}
	cb(null, true)
}

@Module({
	controllers: [ImageController],
	imports: [
		TypegooseModule.forFeature([
			{
				typegooseClass: ImageModel,
				schemaOptions: { versionKey: false }
			}
		]),
		MulterModule.registerAsync({
			useFactory: () => ({
				fileFilter: imageFilter
			})
		})
	],
	providers: [ImageService]
})
export class ImageModule {}
