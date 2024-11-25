const request = require('supertest');
const app = require('../app'); // Ajusta la ruta según tu estructura de carpetas

describe('GET /', () => {
    it('should return a welcome message', async () => {
        const response = await request(app).get('/'); // Simula una solicitud GET
        expect(response.status).toBe(200); // Verifica el código de estado
        expect(response.body).toEqual({ message: 'Welcome to Express!' }); // Verifica el cuerpo de la respuesta
    });
});
