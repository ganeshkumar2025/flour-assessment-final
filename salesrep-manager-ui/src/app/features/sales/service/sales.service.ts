import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Sale } from '../model/sales.model';

@Injectable({ providedIn: 'root' })
export class SalesService {
  private baseUrl = 'https://localhost:7232/api/sales';

  constructor(private http: HttpClient) {}

  getAll(): Observable<Sale[]> {
    return this.http.get<Sale[]>(this.baseUrl);
  }

  getById(id: number): Observable<Sale> {
    return this.http.get<Sale>(`${this.baseUrl}/${id}`);
  }

  create(data: Sale): Observable<Sale> {
    return this.http.post<Sale>(this.baseUrl, data);
  }

  update(id: number, data: Sale): Observable<Sale> {
    return this.http.put<Sale>(`${this.baseUrl}/${id}`, data);
  }

  delete(id: number): Observable<void> {
    return this.http.delete<void>(`${this.baseUrl}/${id}`);
  }
}

