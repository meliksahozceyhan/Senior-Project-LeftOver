import { ConnectedSocket, MessageBody, SubscribeMessage, WebSocketGateway, WebSocketServer } from '@nestjs/websockets'
import { SocketService } from './socket.service'
import { Socket, Server } from 'socket.io'
import { NotificationBody } from './model/notification_body'

@WebSocketGateway(3001, { namespace: 'socket', cors: '*', transports: 'websocket' })
export class SocketGateway {
	@WebSocketServer() server: Server
	private connectedClients: String[] = []

	constructor(private readonly socketService: SocketService) {}

	@SubscribeMessage('notification')
	public handleEvent(@MessageBody() data: NotificationBody, @ConnectedSocket() client: Socket) {
		console.log(this.connectedClients)
		if (this.connectedClients.includes(data.to.id)) client.to(data.to.id).emit('notification', data)
		else this.socketService.createNotification(data)
	}

	@SubscribeMessage('join')
	public async handleCreateOfRoom(@MessageBody() data: string, @ConnectedSocket() client: Socket) {
		console.log(`The Socket ${client.id} Joined to the room ${data}`)
		client.join(data)
		this.connectedClients.push(data)
		console.log(`The User ${data} Is Trying to get unread Notifications`)
		const unreadNotifications = await this.socketService.getNotificationsOfUser(data)
		this.server.to(data).emit('unreadNotifications', unreadNotifications)
		this.socketService.deleteReadNotifications(unreadNotifications)
	}

	@SubscribeMessage('getUnreadNotifications')
	public handleUnreadNotifications(@MessageBody() data: string, @ConnectedSocket() client: Socket) {}

	@SubscribeMessage('leaveServer')
	public handleLeaveServer(@MessageBody() data: string, @ConnectedSocket() client: Socket) {
		client.leave(data)
		client.disconnect()
		this.connectedClients.splice(
			this.connectedClients.findIndex((item) => item === data),
			1
		)
		console.log(this.connectedClients)
	}
}
