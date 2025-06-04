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


export const routes: Routes = [
  { path: '', component: HomeComponent },
  { path: 'sales-reps', redirectTo: 'sales-representative', pathMatch: 'full' },
  { path: 'sales-representative', component: SalesRepListComponent },
  { path: 'sales-representative/create', component: SalesRepCreateComponent },
  { path: 'sales-representative/edit/:id', component: SalesRepEditComponent },

  { path: 'products', component: ProductListComponent },
  { path: 'products/create', component: CreateComponent  },
  { path: 'products/edit/:id', component: EditComponent  },

  { path: 'targets', component: TargetListComponent },
  { path: 'targets/create', component: TargetsCreateComponent },
  { path: 'targets/edit/:id', component: TargetEditComponent },

  { path: 'sales', component: SalesListComponent },
  { path: 'sales/create', component: SalesCreateComponent },
  { path: 'sales/edit/:id', component: SalesEditComponent },

  { path: '**', redirectTo: '' }
];
