import { ConnectedSocket, MessageBody, SubscribeMessage, WebSocketGateway } from '@nestjs/websockets'
import { SocketService } from './socket.service'
import { Socket } from 'socket.io'
import { NotificationBody } from './model/notification_body'

@WebSocketGateway(3001, { namespace: 'socket', cors: '*', transports: 'websocket' })
export class SocketGateway {
	constructor(private readonly socketService: SocketService) {}

	@SubscribeMessage('notification')
	public handleEvent(@MessageBody() data: NotificationBody, @ConnectedSocket() client: Socket) {
		console.log(data)
		client.to(data.to.id).emit('notification', data)
	}

	@SubscribeMessage('join')
	public handleCreateOfRoom(@MessageBody() data: string, @ConnectedSocket() client: Socket) {
		console.log(`Joined to the room ${data}`)
		client.join(data)
	}

	@SubscribeMessage('notification1')
	public handleNotification1(@MessageBody() data: string) {
		console.log(data)
	}
}
