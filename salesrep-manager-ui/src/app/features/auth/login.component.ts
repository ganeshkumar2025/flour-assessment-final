
import { Component } from '@angular/core';
import { AuthService } from '../../core/services/auth.service';
import { JwtHelperService } from '../../core/services/jwt-helper.service';
import { NotificationService } from '../../core/services/notification.service';
import { Router, RouterModule } from '@angular/router'
import { CommonModule } from '@angular/common';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatButtonModule } from '@angular/material/button';
import { FormBuilder, Validators, FormGroup, ReactiveFormsModule } from '@angular/forms';
import { inject } from '@angular/core';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
@Component({
  selector: 'app-login',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule,MatFormFieldModule,
  MatInputModule,
  MatButtonModule,RouterModule,MatProgressSpinnerModule],
  templateUrl: './login.component.html'
})
export class LoginComponent {
  
loading = false; // 🔄 Spinner state
  role = '';
  form: FormGroup;
fb = inject(FormBuilder);
authService = inject(AuthService);
jwtHelper = inject(JwtHelperService);
notify = inject(NotificationService);
router = inject(Router);


constructor() {
  this.form = this.fb.group({
    email: ['', [Validators.required, Validators.email]],
    password: ['', Validators.required]
  
  });
}

onSubmit(): void {
  localStorage.clear();
  if (this.form.invalid) return;
  this.loading = true;
this.authService.login(this.form.value).subscribe({
  next: () => {
    setTimeout(() => {
      const token = this.jwtHelper.getToken();
      const decoded = this.jwtHelper.getDecodedToken();
      console.log('[Login] Decoded role:', decoded?.role);
      console.log('[Login] Email:', decoded?.email);
      this.notify.show(`Welcome ${this.role}`);
      this.router.navigate(['./home']);
      this.loading = false;

      this.router.navigate(['/home']);
    }, 100); // allow storage to persist before read
  },
  error: () => {
      this.notify.show('Login failed');
      this.loading = false; // ❌ Stop spinner on failure
    }
  });
}
}
