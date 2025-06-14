
import { Conditional } from '@angular/compiler';
import { Injectable } from '@angular/core';

@Injectable({ providedIn: 'root' })
export class JwtHelperService {
  getToken(): string | null {
    const token = localStorage.getItem('token');
  console.log('JWT Helper: Token from storage =', token);
  return token;;
  }

  getDecodedToken(): any {
    const token = this.getToken();
    console.log(token);
    if (!token) return null;
  const decoded = JSON.parse(atob(token.split('.')[1]));
  console.log('[JWT Decode] Decoded payload:', decoded);
  return decoded;
  }

  getUserRole(): string {
    const decoded = this.getDecodedToken();
    console.log(decoded);
    console.log('AuthGuard check: role =', decoded?.role);
    return decoded?.role || '';
  }
}
