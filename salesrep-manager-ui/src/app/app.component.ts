import { CommonModule } from '@angular/common';
import { SplashScreenComponent } from './core/splash-screen/splash-screen.component';
import { Component, OnInit } from '@angular/core';
import { RouterOutlet, RouterLink, Router, NavigationEnd } from '@angular/router';
import { MatToolbarModule } from '@angular/material/toolbar';
import { MatButtonModule } from '@angular/material/button';
import { JwtHelperService } from './core/services/jwt-helper.service';
import { AuthService } from './core/services/auth.service';
import { MatMenuModule } from '@angular/material/menu';
import { MatIconModule } from '@angular/material/icon';
import { MatDividerModule } from '@angular/material/divider';
import { filter } from 'rxjs/internal/operators/filter';


@Component({
  selector: 'app-root',
  standalone: true,
  imports: [
    CommonModule,
    RouterOutlet,
    RouterLink,
    MatToolbarModule,
    MatButtonModule,
    SplashScreenComponent,
    MatMenuModule
    , MatIconModule,
    MatDividerModule
  ],
  template: `
    <ng-container *ngIf="showSplash; else mainContent">
      <app-splash-screen></app-splash-screen>
    </ng-container>

    <ng-template #mainContent>
      <mat-toolbar *ngIf="!isLoginRoute" color="primary">
  <span class="brand-title">Sales Representative Management System</span>

  <span class="spacer"></span>

  <!-- Navigation buttons -->
  <button mat-button routerLink="/sales-representative">SalesRepresentative</button>
  <button mat-button routerLink="/products">Products</button>
  <button mat-button routerLink="/targets">Targets</button>
  <button mat-button routerLink="/sales">Sales</button>

  <!-- 👤 Avatar + Role + Menu -->
  <button mat-icon-button [matMenuTriggerFor]="userMenu" aria-label="User menu">
    <mat-icon>account_circle</mat-icon>
  </button>
 <button mat-menu-item disabled>
  <mat-icon>mail</mat-icon>
  {{ userEmail }}
</button>
  <mat-menu #userMenu="matMenu">
    <button mat-menu-item disabled>
  <mat-icon>person</mat-icon>
  {{ userEmail }}
</button>
<button mat-menu-item disabled>
  <mat-icon>badge</mat-icon>
  Role: {{ userRole }}
</button>
    <mat-divider></mat-divider>
    <button mat-menu-item (click)="logout()">
      <mat-icon>logout</mat-icon>
      Logout
    </button>
  </mat-menu>
</mat-toolbar>
      
      <router-outlet></router-outlet>
      
      <footer class="footer">
        © {{ currentYear }} Sales Representative Management System | Built with Angular 20
      </footer>
    </ng-template>
  `,
  styleUrls: ['./app.component.scss']
})
export class AppComponent implements OnInit {
  title = 'Daniel Flour India Pvt Ltd.';
  currentYear = new Date().getFullYear();
  showSplash = true;
  isLoginRoute = false;
  userRole = '';
  userEmail = '';
decoded: any = null;
  constructor(private router: Router,private jwtHelper: JwtHelperService,
    private authService: AuthService,) {}

  ngOnInit(): void {
    this.checkLoginRoute();
    this.router.events.subscribe(() => this.checkLoginRoute()); 
  this.router.events.pipe(
    filter(event => event instanceof NavigationEnd)
  ).subscribe(() => {
    const token = this.jwtHelper.getToken();
    console.log('[AppComponent] Fetched Token:', token);
    if (token) {
  this.decoded = this.jwtHelper.getDecodedToken();
  console.log('[AppComponent] Decoded Token:', this.decoded);
  this.userEmail = this.decoded?.sub || this.decoded?.email || 'N/A';
  this.userRole = this.decoded?.role || this.decoded?.['http://schemas.microsoft.com/ws/2008/06/identity/claims/role'] || 'N/A';
}
  });

  setTimeout(() => {
    this.showSplash = false;
    console.log('[AppComponent] Splash hiding now');
  }, 2000);
}

isLoggedIn(): boolean {
  return !!this.jwtHelper.getToken();
}

  private checkLoginRoute(): void {
    this.isLoginRoute = this.router.url === '/login';
  }
  logout(): void {
    this.authService.logout();
    this.router.navigate(['/login']);
  }
}