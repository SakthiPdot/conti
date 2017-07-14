package com.conti.master.service;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

@Entity
@Table(name = "m_service")
@JsonIgnoreProperties(ignoreUnknown = true)
public class ServiceMaster {

		private int service_id;
		private String service_name;
		private String service_code;
		private String created_datetime;
		private String updated_datetime;
		private int created_by;
		private int updated_by;
		private String obsolete;
		private String active;
		
		public ServiceMaster() {
			
		}
		
		@Id
		@Column(name = "service_id")
		public int getService_id() {
			return service_id;
		}
		public void setService_id(int service_id) {
			this.service_id = service_id;
		}
		
		@Column(name = "service_name")
		public String getService_name() {
			return service_name;
		}
		public void setService_name(String service_name) {
			this.service_name = service_name;
		}
		
		@Column( name = "service_code")
		public String getService_code() {
			return service_code;
		}
		public void setService_code(String service_code) {
			this.service_code = service_code;
		}
		
		@Column( name = "created_datetime")
		public String getCreated_datetime() {
			return created_datetime;
		}
		public void setCreated_datetime(String created_datetime) {
			this.created_datetime = created_datetime;
		}
		
		@Column( name = "updated_datetime")
		public String getUpdated_datetime() {
			return updated_datetime;
		}
		public void setUpdated_datetime(String updated_datetime) {
			this.updated_datetime = updated_datetime;
		}
		
		@Column( name = "created_by")
		public int getCreated_by() {
			return created_by;
		}
		public void setCreated_by(int created_by) {
			this.created_by = created_by;
		}
		
		@Column( name = "updated_by")
		public int getUpdated_by() {
			return updated_by;
		}
		public void setUpdated_by(int updated_by) {
			this.updated_by = updated_by;
		}
		
		@Column( name = "obsolete")
		public String getObsolete() {
			return obsolete;
		}
		public void setObsolete(String obsolete) {
			this.obsolete = obsolete;
		}
		
		@Column ( name = "active")
		public String getActive() {
			return active;
		}
		public void setActive(String active) {
			this.active = active;
		}
		
		
		
}
