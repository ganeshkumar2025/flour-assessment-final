import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { SalesRepresentative } from '../../features/sales-representative/sales-representative.model';

@Injectable({
  providedIn: 'root'
})
export class SalesRepresentativeService {
  private apiUrl = 'https://localhost:7232/api/salesrepresentatives';

  constructor(private http: HttpClient) {}

  getAll(): Observable<SalesRepresentative[]> {
    return this.http.get<SalesRepresentative[]>(this.apiUrl);
  }

  getById(id: number): Observable<SalesRepresentative> {
    return this.http.get<SalesRepresentative>(`${this.apiUrl}/${id}`);
  }

  create(rep: SalesRepresentative): Observable<SalesRepresentative> {
    return this.http.post<SalesRepresentative>(this.apiUrl, rep);
  }

  update(id: number, rep: SalesRepresentative): Observable<void> {
    return this.http.put<void>(`${this.apiUrl}/${id}`, rep);
  }

  delete(id: number): Observable<void> {
    return this.http.delete<void>(`${this.apiUrl}/${id}`);
  }
}