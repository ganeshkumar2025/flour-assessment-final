import { CommonModule } from '@angular/common';
import { SplashScreenComponent } from './core/splash-screen/splash-screen.component';
import { Component, OnInit } from '@angular/core';
import { RouterOutlet, RouterLink } from '@angular/router';
import { MatToolbarModule } from '@angular/material/toolbar';
import { MatButtonModule } from '@angular/material/button';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [
    CommonModule,
    RouterOutlet,
    RouterLink,
    MatToolbarModule,
    MatButtonModule,
    SplashScreenComponent
  ],
  template: `
    <ng-container *ngIf="showSplash; else mainContent">
      <app-splash-screen></app-splash-screen>
    </ng-container>

    <ng-template #mainContent>
      <mat-toolbar color="primary">
        <span class="brand-title">Sales Representative Management System</span>
        <span class="spacer"></span>
        <button mat-button routerLink="/sales-representative">SalesRepresentative</button>
        <button mat-button routerLink="/products">Products</button>
        <button mat-button routerLink="/targets">Targets</button>
        <button mat-button routerLink="/sales">Sales</button>
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

  ngOnInit(): void {
    console.log('[AppComponent] ngOnInit triggered');
    setTimeout(() => {
      this.showSplash = false;
      console.log('[AppComponent] Splash hiding now');
    }, 2000);
  }
}