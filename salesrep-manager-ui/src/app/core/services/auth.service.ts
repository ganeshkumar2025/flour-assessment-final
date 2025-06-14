
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { tap, map, Observable } from 'rxjs';
import { environment } from '../../../environments/environment';

@Injectable({ providedIn: 'root' })
export class AuthService {
  private readonly API = `${environment.apiUrl}/auth`;
  constructor(private http: HttpClient) {}
 
  login(credentials: { email: string; password: string }): Observable<void> {
    const fullPayload = {
    ...credentials,
    twoFactorCode: '',
    rememberMe: false,
    deviceId: 'web-' + navigator.userAgent // or generate UUID
  };
  console.log('Login Payload:', fullPayload);
    return this.http.post<any>(`${this.API}/login`, fullPayload).pipe(
      tap(res => {
        
      localStorage.clear();
      console.log('Login response:', res);
      localStorage.setItem('token', res.token);
      console.log('Token stored:', res.token);
      localStorage.setItem('refreshToken', res.refreshToken);
      console.log('Refresh token stored:', res.refreshToken);
      console.log('Token stored:', res.token);
      }),
      map(() => void 0)
    );
  }

  refreshToken(): Observable<void> {
    const refreshToken = localStorage.getItem('refreshToken');
    return this.http.post<any>(`${this.API}/refresh`, { refreshToken }).pipe(
      tap(res => localStorage.setItem('token', res.token)),
      map(() => void 0)
    );
  }

  logout() {
    const refreshToken = localStorage.getItem('refreshToken');
    this.http.post(`${this.API}/logout`, { refreshToken }).subscribe();
    localStorage.clear();
  }

  getToken(): string | null {
    return localStorage.getItem('token');
  }

  isLoggedIn(): boolean {
    return !!this.getToken();
  }
}
