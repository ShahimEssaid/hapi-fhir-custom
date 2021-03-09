package ca.uhn.fhir.jpa.searchparam;

/*
 * #%L
 * HAPI FHIR Search Parameters
 * %%
 * Copyright (C) 2014 - 2021 Smile CDR, Inc.
 * %%
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * #L%
 */

public enum SearchContainedEnum {

	/**
	 * default, search on the non-contained (normal) resources
	 */
	FALSE, 

	/**
	 * search on the contained resources only
	 */
	TRUE, 
	
	/**
	 * Search on the normal resources and contained resources.
	 * This option is not supported yet.
	 */
	BOTH,
}
