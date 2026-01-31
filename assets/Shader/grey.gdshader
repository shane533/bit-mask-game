shader_type canvas_item;

uniform int mode = 0;

void vertex() {
	// Called for every vertex the material is visible on.
	
}

void fragment() {
	// Called for every pixel the material is visible on.
	float grey = COLOR.r * 0.299 + COLOR.g*0.587 + COLOR.b*0.114;
	switch (mode){
		case 0:
			COLOR =COLOR.a == 0.f ? COLOR :(grey < 0.5 ? vec4(0, 0, 0, 1): vec4(1,1,1,1));
			break;
		case 1:
			COLOR = COLOR.a == 0.f ? COLOR :(grey > 0.5 ? vec4(0, 0, 0, 1) : vec4(1,1,1,1));
			break;
		case 2:
			COLOR = COLOR.a == 0.f ? COLOR :(vec4(grey, grey, grey, 1));
			break;
		case 4:
		case 5:
		case 6:
		case 7:
		case 8:
			float g = float(mode-4)*0.25;
			COLOR = COLOR.a == 0.f ? COLOR :(vec4(g, g, g, 1));
			break;
		//case 5:
			//COLOR = COLOR.a == 0.f ? COLOR :(vec4(0.25, 0.25, 0.25, 1));
			//break;
		//case 6:
			//COLOR = COLOR.a == 0.f ? COLOR :(vec4(0.5, 0.5, 0.5, 1));
			//break;
		//case 7:
			//COLOR = COLOR.a == 0.f ? COLOR :(vec4(0.75, 0.75, 0.75, 1));
			//break;
		//case 8:
			//COLOR = COLOR.a == 0.f ? COLOR :(vec4(0.25, 0.25, 0.25, 1));
			//break;
		default:
			COLOR = COLOR;
			break;
	}
	//COLOR =COLOR.a == 0.f ? COLOR :( (mode == 0 ? (grey < 0.5 ? vec4(0, 0, 0, 1) : vec4(1, 1, 1, 1)) : (mode==1 ? (grey > 0.5 ? vec4(0, 0, 0, 1) : vec4(1, 1, 1, 1)) : (mode==2 ? vec4(grey, grey, grey, 1) : COLOR)  )));
	//COLOR = vec4(grey, grey, grey, 1);
	//COLOR = grey > 0.5 ? vec4(0, 0, 0, 1) : vec4(1, 1, 1, 1);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
