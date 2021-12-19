import { HttpStatus } from '@nestjs/common'
import { ArgumentsHost, Catch, ExceptionFilter } from '@nestjs/common'
import { Request, Response } from 'express'
import { QueryFailedError } from 'typeorm'

@Catch(QueryFailedError)
export class QueryFailedExceptionFilter implements ExceptionFilter<QueryFailedError> {
	catch(exception: QueryFailedError, host: ArgumentsHost) {
		const context = host.switchToHttp()
		const response = context.getResponse<Response>()
		const request = context.getRequest<Request>()
		const status = HttpStatus.INTERNAL_SERVER_ERROR

		response
			.status(status)
			.json({
				statusCode: status,
				timestamp: new Date().toISOString(),
				path: request.url,
				message: exception.message,
				detail: exception.driverError.detail
			})
			.send()
	}
}
