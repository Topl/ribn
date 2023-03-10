export type APIRequest = {
	method: string;
	data?: Record<string, any>;
};

export type InternalMessage = {
	id: string;
	method: string;
	target: string;
	sender: string;
	data?: Record<string, any>;
	error?: Record<string, any>;
	event?: string;
	origin?: string;
};