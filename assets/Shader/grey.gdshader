shader_type canvas_item;

uniform int mode = 0;

void vertex() {
	// Called for every vertex the material is visible on.
	
}

void fragment() {
	// Called for every pixel the material is visible on.
	float grey = COLOR.r * 0.299 + COLOR.g*0.587 + COLOR.b*0.114;
	COLOR =COLOR.a == 0.f ? COLOR :( (mode == 0 ? (grey < 0.5 ? vec4(0, 0, 0, 1) : vec4(1, 1, 1, 1)) : (mode==1 ? (grey > 0.5 ? vec4(0, 0, 0, 1) : vec4(1, 1, 1, 1)) : (mode==2 ? vec4(grey, grey, grey, 1) : COLOR)  )));
	//COLOR = vec4(grey, grey, grey, 1);
	//COLOR = grey > 0.5 ? vec4(0, 0, 0, 1) : vec4(1, 1, 1, 1);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
