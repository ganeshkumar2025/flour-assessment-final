import { Routes } from '@angular/router';

import { HomeComponent } from './home-component/home.component';

import { ListComponent as SalesRepListComponent } from './features/sales-representative/list/list.component';
import { CreateComponent as SalesRepCreateComponent } from './features/sales-representative/create/create.component';
import { EditComponent as SalesRepEditComponent } from './features/sales-representative/edit/edit.component';

import { ProductListComponent } from './features/products/list/list.component';
import { CreateComponent  } from './features/products/create/create.component';
import { EditComponent  } from './features/products/edit/edit.component';

import { TargetListComponent } from './features/targets/list/list.component';
import { TargetsCreateComponent } from './features/targets/create/create.component';
import { EditComponent as TargetEditComponent } from './features/targets/edit/edit.component';

import { SalesListComponent } from './features/sales/list/list.component';
import { SalesCreateComponent } from './features/sales/create/create.component';
import { EditComponent as SalesEditComponent } from './features/sales/edit/edit.component';
import { LoginComponent } from './features/auth/login.component';
import { AuthGuard } from './core/services/auth.guard';


export const routes: Routes = [
  { path: '', redirectTo: 'home', pathMatch: 'full' }, // 🔁 Redirect root to login

  { path: 'login', component: LoginComponent },

  {
    path: 'home',
    canActivate: [AuthGuard],
    data: { roles: ['Admin', 'SalesManager'] },
    loadComponent: () => import('./home-component/home.component').then(m => m.HomeComponent)
  },

  // Secure remaining paths (add AuthGuard where needed)
  {
    path: 'sales-representative',
    component: SalesRepListComponent,
    canActivate: [AuthGuard],
    data: { roles: ['Admin', 'SalesManager'] }
  },
  { path: 'sales-representative/create', component: SalesRepCreateComponent },
  { path: 'sales-representative/edit/:id', component: SalesRepEditComponent },

  { path: 'products', component: ProductListComponent,canActivate: [AuthGuard],
  data: { roles: ['Admin', 'SalesManager'] } },
  { path: 'products/create', component: CreateComponent ,canActivate: [AuthGuard],
  data: { roles: ['Admin', 'SalesManager'] }},
  { path: 'products/edit/:id', component: EditComponent,canActivate: [AuthGuard],
  data: { roles: ['Admin', 'SalesManager'] } },

  { path: 'targets', component: TargetListComponent,canActivate: [AuthGuard],
  data: { roles: ['Admin', 'SalesManager'] } },
  { path: 'targets/create', component: TargetsCreateComponent,canActivate: [AuthGuard],
  data: { roles: ['Admin', 'SalesManager'] } },
  { path: 'targets/edit/:id', component: TargetEditComponent,canActivate: [AuthGuard],
  data: { roles: ['Admin', 'SalesManager'] } },

  { path: 'sales', component: SalesListComponent,canActivate: [AuthGuard],
  data: { roles: ['Admin', 'SalesManager'] } },
  { path: 'sales/create', component: SalesCreateComponent,canActivate: [AuthGuard],
  data: { roles: ['Admin', 'SalesManager'] } },
  { path: 'sales/edit/:id', component: SalesEditComponent,canActivate: [AuthGuard],
  data: { roles: ['Admin', 'SalesManager'] } },

  {
    path: 'admin',
    canActivate: [AuthGuard],
    data: { roles: ['Admin'] },
    loadComponent: () => import('./features/admin/admin.component').then(m => m.AdminComponent)
  },

  { path: '**', redirectTo: 'login' } // 🔁 Catch-all to login
];
