
import { Injectable } from '@angular/core';
import { CanActivate, ActivatedRouteSnapshot, Router } from '@angular/router';
import { AuthService } from './auth.service';

@Injectable({ providedIn: 'root' })
export class AuthGuard implements CanActivate {
  constructor(private auth: AuthService, private router: Router) {}

  canActivate(route: ActivatedRouteSnapshot): boolean {
    const token = this.auth.getToken();
    console.log('AuthGuard check: token =', token);
    if (!token) {
      this.router.navigate(['/login']);
      return false;
    }

    const expectedRoles = route.data['roles'];
    const payload = JSON.parse(atob(token.split('.')[1]));
    if (!expectedRoles.includes(payload.role)) {
      this.router.navigate(['/unauthorized']);
      return false;
    }
   

    return true;
  }
}
